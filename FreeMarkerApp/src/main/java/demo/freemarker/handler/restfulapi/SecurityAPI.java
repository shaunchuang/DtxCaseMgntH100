/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.handler.restfulapi;

import com.sun.net.httpserver.Headers;
import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.OtherPatientInfoAPI;
import demo.freemarker.api.PatientAPI;

import demo.freemarker.api.UserAPI;
import demo.freemarker.api.UserRoleAPI;
import demo.freemarker.core.GsonUtil;
import demo.freemarker.core.SecurityUtils;
import demo.freemarker.dto.UserRoleDTO;
import demo.freemarker.model.OtherPatientInfo;
import demo.freemarker.model.Patient;
import demo.freemarker.model.User;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.httpd.session.HttpSession;
import itri.sstc.framework.core.httpd.session.HttpSessionManager;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Random;
import javax.imageio.ImageIO;
import org.json.JSONObject;

/**
 *
 * @author zhush
 */
public class SecurityAPI extends RESTfulAPI {

    public SecurityAPI() {
    }

    @Override
    public String getContextPath() {
        return "/security/api/";
    }

    @RESTfulAPIDefine(url = "login", methods = "post", description = "登入")
    private String doLogin(HttpExchange exchange) throws IOException {
        HttpSession session2 = HttpSessionManager.getInstance().getSession(exchange, false);
        String cookieHeader = exchange.getRequestHeaders().getFirst("Cookie");
        // 2. 預設 lang 為空
        // 1. 一開始直接給 lang 預設值
        String lang = "zh_TW";

        if (cookieHeader != null) {
            String[] cookies = cookieHeader.split(";");
            for (String c : cookies) {
                c = c.trim();
                String[] parts = c.split("=", 2);
                if (parts.length == 2) {
                    String name = parts[0].trim();
                    String value = parts[1].trim();
                    // 如果找到 _freemarker_lang，就用它的 value 覆寫預設
                    if ("_freemarker_lang".equals(name)) {
                        lang = value;
                        break;
                    }
                }
            }
        }
        // 3. 把 Set-Cookie header 加到 response 裡
        Headers responseHeaders = exchange.getResponseHeaders();
        // Path=/ 表示整個網站都生效；也可以加 max-age、HttpOnly、Secure 等設定
        StringBuilder sb = new StringBuilder();
        sb.append("_freemarker_lang=").append(lang)
                .append("; Path=/")
                .append("; Max-Age=").append(60 * 60 * 24 * 30);
        responseHeaders.add("Set-Cookie", sb.toString());
        // 3. 此時如果沒有從 Cookie 讀到 _freemarker_lang，就會保持「zh_TW」

        JSONObject jsonRequest;
        JSONObject responseJson = new JSONObject();
        try {
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            jsonRequest = new JSONObject(requestBody.toString());
        } catch (Exception e) {
            e.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, -1);
            return null;
        }

        if (!jsonRequest.has("account") || jsonRequest.getString("account").equals("")
                || !jsonRequest.has("password") || jsonRequest.getString("password").equals("")
                || !jsonRequest.has("captcha") || jsonRequest.getString("captcha").equals("")) {
            responseJson.put("message", "請輸入帳號、密碼和驗證碼");
            responseJson.put("success", Boolean.FALSE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();
        }

        String account = jsonRequest.getString("account").trim().toLowerCase();
        String password = jsonRequest.getString("password").trim();
        String captchaInput = jsonRequest.getString("captcha").trim();
        String location = jsonRequest.optString("location", null);
        HttpSession session = getSession(exchange);
        if (session == null) {
            session = HttpSessionManager.getInstance().createSession(exchange);
        } else {
        }
        String storedCaptcha = (String) session.getAttribute("captcha");

        if (storedCaptcha == null || !storedCaptcha.equals(captchaInput)) {
            responseJson.put("message", "驗證碼錯誤");
            responseJson.put("success", Boolean.FALSE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();
        }

        User user = UserAPI.getInstance().getUserByAccount(account);
        if (user == null) {
            responseJson.put("message", "用戶不存在");
            responseJson.put("success", Boolean.FALSE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();
        }
        Boolean isValid = SecurityUtils.verifyPassword(password, user.getPassword());

        if (!isValid) {
            responseJson.put("message", "密碼錯誤");
            responseJson.put("success", Boolean.FALSE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();
        }
        // 更新最後登入日期
        UserAPI.getInstance().updateLastLoginDate(user.getId());
        User updatedUser = UserAPI.getInstance().getUser(user.getId());
        // 設置當前用戶並清除驗證碼
        SecurityUtils.setCurrentUser(session, "DTXSTORE", updatedUser);
        String token = SecurityUtils.getOrCreateSessionJWTToken(session, updatedUser);
        UserRoleDTO userInfo = SecurityUtils.extractUserIdFromToken(token);
        session.setAttribute("captcha", null);

        /* ② 同時寫入 Cookie，供「所有之後的請求」帶出 */
        String cookie = new StringBuilder()
            .append("DTX-AUTH=").append(token)
            .append("; Domain=localhost")      // 同一網域即可跨 3000/7001 兩個 port
            .append("; Path=/")
            .append("; Max-Age=").append(60 * 60 * 8) // 8 小時
            .append("; HttpOnly")              // 若前端 JS 需要自行讀 token 可拿掉
            .append("; SameSite=Lax")          // 由 Java 跳轉／<a> 連結仍會帶 Cookie
            // .append("; Secure")             // 上到 https 才開
            .toString();
        exchange.getResponseHeaders().add("Set-Cookie", cookie);

        /* ③ CORS 仍要允許帶憑證 */
        exchange.getResponseHeaders().set("Access-Control-Allow-Origin",
            exchange.getRequestHeaders().getFirst("Origin"));
        exchange.getResponseHeaders().set("Access-Control-Allow-Credentials", "true");

        if (location != null && location.equals("imas")) {
            if (userInfo.getRoleAlias().equals("CASE")) {
                Patient patient = PatientAPI.getInstance().getPatientByUserId(userInfo.getId());
                if (patient == null) {
                    responseJson.put("casePlatform", "toInfoComplete");
                } else {
                    responseJson.put("casePlatform", "infoCompleted");
                }
                responseJson.put("message", "登入成功");
                responseJson.put("success", Boolean.TRUE);
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
                return responseJson.toString();
            } else {
                responseJson.put("user", GsonUtil.toJsonObject(userInfo));
                responseJson.put("token", token);
                responseJson.put("message", "登入成功");
                responseJson.put("success", Boolean.TRUE);
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
                return responseJson.toString();
            }
        } else {
            responseJson.put("user", GsonUtil.toJsonObject(userInfo));
            responseJson.put("token", token);
            responseJson.put("message", "登入成功");
            responseJson.put("success", Boolean.TRUE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();
        }
    }

    @RESTfulAPIDefine(url = "register", methods = "post", description = "註冊")
    private String doRegister(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);

        // 解析 JSON
        JSONObject jsonRequest;
        try {
            jsonRequest = new JSONObject(requestBody.toString());

            // 驗證必要欄位
            if (!jsonRequest.has("account") || jsonRequest.getString("account").equals("")
                    || !jsonRequest.has("username") || jsonRequest.getString("username").equals("")
                    || !jsonRequest.has("password") || jsonRequest.getString("password").equals("")
                    || !jsonRequest.has("email") || jsonRequest.getString("email").equals("")
                    || !jsonRequest.has("telCell") || jsonRequest.getString("telCell").equals("")
                    || !jsonRequest.has("captcha") || jsonRequest.getString("captcha").equals("")) {
                responseJson.put("message", "請填寫所有必要欄位，包括驗證碼");
                responseJson.put("success", Boolean.FALSE);
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
                return responseJson.toString();
            }

            String captchaInput = jsonRequest.getString("captcha").trim();

            // 獲取並驗證 session 中的驗證碼
            HttpSession session = getSession(exchange);
            if (session == null) {
                responseJson.put("message", "會話已過期，請重新整理頁面");
                responseJson.put("success", Boolean.FALSE);
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
                return responseJson.toString();
            }

            String storedCaptcha = (String) session.getAttribute("captcha");

            if (storedCaptcha == null || !storedCaptcha.equals(captchaInput)) {
                responseJson.put("message", "驗證碼錯誤");
                responseJson.put("success", Boolean.FALSE);
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
                return responseJson.toString();
            }

            // 檢查帳號是否已存在
            String account = jsonRequest.getString("account").trim().toLowerCase();
            User existingUser = UserAPI.getInstance().getUserByAccount(account);
            if (existingUser != null) {
                responseJson.put("message", "帳號已存在，請選擇其他帳號");
                responseJson.put("success", Boolean.FALSE);
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
                return responseJson.toString();
            }

            // 檢查電子郵件是否已存在
            String email = jsonRequest.getString("email").trim();
            User existingEmailUser = UserAPI.getInstance().getUserByEmail(email);
            if (existingEmailUser != null) {
                responseJson.put("message", "電子郵件已被註冊，請使用其他電子郵件");
                responseJson.put("success", Boolean.FALSE);
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
                return responseJson.toString();
            }

            // 創建新用戶
            User user = new User();
            String username = jsonRequest.getString("username").trim();
            String password = jsonRequest.getString("password").trim();
            String telCell = jsonRequest.getString("telCell").trim();

            user.setUsername(username);
            String hashedPass = SecurityUtils.hashPassword(password);
            user.setPassword(hashedPass);
            user.setAccount(account);
            user.setTelCell(telCell);
            user.setEmail(email);
            user.setCreatedTime(new Date());
            user.setStatus(User.UserStatus.APPROVED);

            UserAPI.getInstance().createUser(user);

            UserRoleAPI.getInstance().createUserRole(user.getId(), 1L);

            // 清除驗證碼
            session.setAttribute("captcha", null);

            responseJson.put("message", "註冊成功");
            responseJson.put("success", Boolean.TRUE);

        } catch (Exception e) {
            e.printStackTrace();
            responseJson.put("message", "註冊失敗：" + e.getMessage());
            responseJson.put("success", Boolean.FALSE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();
        }

        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }

    @RESTfulAPIDefine(url = "captcha", methods = "get", description = "取得圖片驗證碼")
    private String generateCaptcha(HttpExchange exchange) throws IOException {
        // 這裡 auto=true，會幫你新建並回 Set-Cookie
        HttpSession session = HttpSessionManager.getInstance().getSession(exchange, true);

        String captcha = generateNumericCaptcha(4);
        session.setAttribute("captcha", captcha);

        // 產生驗證碼圖片
        int width = 100, height = 40;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();

        // 設定背景顏色
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, width, height);

        // 設定字型
        g.setFont(new Font("Arial", Font.BOLD, 24));

        Random rand = new Random();

        // 隨機干擾線
        for (int i = 0; i < 5; i++) {
            g.setColor(new Color(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)));
            g.drawLine(rand.nextInt(width), rand.nextInt(height), rand.nextInt(width), rand.nextInt(height));
        }

        // 繪製驗證碼數字
        for (int i = 0; i < captcha.length(); i++) {
            // 確保顏色不會太淺
            int red = 50 + rand.nextInt(206); // 範圍: 50-255
            int green = 50 + rand.nextInt(206);
            int blue = 50 + rand.nextInt(206);
            g.setColor(new Color(red, green, blue));
            g.drawString(String.valueOf(captcha.charAt(i)), 20 + i * 20, 28);
        }

        g.dispose();

        // 設定回應標頭
        exchange.getResponseHeaders().set("Content-Type", "image/png");
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        // 建完 session、加入 Set-Cookie 之後

        // 回傳圖片
        try (OutputStream os = exchange.getResponseBody()) {
            ImageIO.write(image, "png", os);
        }
        return null;
    }

    @RESTfulAPIDefine(url = "user", methods = "get", description = "取得當前使用者 (Bearer Token 驗證)")
    private String getCurrentUser(HttpExchange exchange) throws IOException {
        JSONObject resp = new JSONObject();

        // 1. 先拿 Authorization header
        String authHeader = exchange.getRequestHeaders().getFirst("Authorization");
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            // 沒有帶 Bearer token，就回未授權
            resp.put("message", "尚未登入，缺少 Bearer token");
            resp.put("success", false);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
            return resp.toString();
        }

        // 2. 取出真正的 token（跳過 "Bearer " 前綴）
        String token = authHeader.substring("Bearer ".length()).trim();
        if (token.isEmpty()) {
            resp.put("message", "尚未登入，Bearer token 為空");
            resp.put("success", false);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
            return resp.toString();
        }

        // 3. 嘗試解析並驗證 JWT
        UserRoleDTO userInfo = null;
        try {
            userInfo = SecurityUtils.extractUserIdFromToken(token);
        } catch (Exception e) {
            // 解析失敗：可能是簽章錯誤或已過期
            resp.put("message", "Token 驗證失敗");
            resp.put("success", false);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, 0);
            return resp.toString();
        }
        // 4. 驗證成功後，回傳使用者資料
        resp.put("user", GsonUtil.toJsonObject(userInfo));
        resp.put("token", token);
        resp.put("message", "驗證成功");
        resp.put("success", true);
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return resp.toString();
    }

    @RESTfulAPIDefine(url = "logout", methods = "post", description = "登出")
    private String doLogout(HttpExchange exchange) throws IOException {

        JSONObject responseJson = new JSONObject();

        HttpSession session = HttpSessionManager.getInstance().getSession(exchange, false);
        if (session != null) {
            try {
                SecurityUtils.removeToken(session);
                HttpSessionManager.getInstance().removeSession(exchange);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        responseJson.put("message", "登出成功");
        responseJson.put("success", Boolean.TRUE);

        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }

    @RESTfulAPIDefine(url = "adhdlogin", methods = "post", description = "JavaScript 登入")
    private String doJavaScriptLogin(HttpExchange exchange) throws IOException {

        HttpSession session = HttpSessionManager.getInstance()
                                               .getSession(exchange, true); // 找不到就新建

        JSONObject res = new JSONObject();
        try {
            String body = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            String email = new JSONObject(body).optString("email", "").trim();

            if (email.isEmpty()) {
                res.put("success", false).put("message", "請提供電子郵件地址");
                return res.toString();           // 讓 RESTfulAPI 送 200 + JSON
            }

            User user = UserAPI.getInstance().getUserByEmail(email);
            if (user == null) {
                res.put("success", false).put("message", "用戶不存在");
                return res.toString();
            }

            // 這裡直接用「已確定存在的 session」產生 / 取得 token
            String token = SecurityUtils.getOrCreateSessionJWTToken(session, user);

            res.put("success", true)
               .put("message", "登入成功")
               .put("token", token);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return res.toString();

        } catch (Exception e) {
            e.printStackTrace();
            res.put("success", false).put("message", e.getMessage());
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return res.toString();               
        }
    }

    private String generateNumericCaptcha(int length) {
        Random random = new Random();
        int min = (int) Math.pow(10, length - 1);
        int max = (int) Math.pow(10, length) - 1;
        return String.valueOf(random.nextInt(max - min + 1) + min);
    }
}
