package demo.freemarker.core;

import com.sun.net.httpserver.HttpExchange;

import demo.freemarker.api.RoleAPI;
import demo.freemarker.api.UserAPI;
import demo.freemarker.api.UserRoleAPI;
import demo.freemarker.dto.UserRoleDTO;
import demo.freemarker.model.Role;
import demo.freemarker.model.User;
import demo.freemarker.model.UserRole;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import itri.sstc.framework.core.Config;
import itri.sstc.framework.core.httpd.session.HttpSession;
import itri.sstc.framework.core.httpd.session.HttpSessionManager;
import itri.sstc.freemarker.core.Constants;
import itri.sstc.freemarker.core.RequestData;
import java.security.Key;
import io.jsonwebtoken.security.Keys;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.stream.Collectors;
import org.mindrot.jbcrypt.BCrypt;

public class SecurityUtils {

    /**
     * 獲取當前登錄用戶
     *
     * @param request
     * @return
     */
    public static User getCurrentUser(HttpExchange exchange) {
        HttpSession session = HttpSessionManager.getInstance().getSession(exchange, false);
        return getCurrentUser(session);
    }

    /**
     * 獲取當前登錄用戶
     *
     * @param session
     * @return
     */
    public static User getCurrentUser(HttpSession session) {
        if (session != null) {
            Object obj = session.getValue(Constants.SESSION_CURRENT_USER);
            if (obj != null && obj instanceof User) {
                return (User) obj;
            }
        }
        return null;
    }

    // public static User getCurrentUser(RequestData request) {
    // User user = null;
    // user = getCurrentUser(request.session);
    // if (user == null) {
    // try {
    // String tenantId = request.cookies.get(Constants.COOKIE_TENANTID);
    // Long userId = Long.valueOf(request.cookies.get(Constants.COOKIE_USERNAME));
    // Long usertime = Long.valueOf(request.cookies.get(Constants.COOKIE_USERTIME));
    // if (System.currentTimeMillis() - usertime < (Constants.COOKIE_EXPIRES_TIME *
    // 1000)) {
    // String hql = "SELECT oo FROM User oo WHERE oo.id = :id ";
    // HashMap<String, Object> params = new HashMap<>();
    // params.put("id", userId);
    // List<User> qryObject = UserDAO.getInstance().listUser(hql, params);
    // user = qryObject.get(0);
    // setCurrentUser(request, tenantId, user);
    // }
    // } catch (Exception ex) {
    // }
    // }
    // return user;
    // }
    public static UserRoleDTO getCurrentUser(RequestData request) {
        User user = getCurrentUser(request.session);
        
        // 若 session 中沒有使用者，再從 cookie 嘗試取得
        if (user == null) {
            try {
                String userIdStr = request.cookies.get(Constants.COOKIE_USERNAME);
                String usertimeStr = request.cookies.get(Constants.COOKIE_USERTIME);
    
                if (userIdStr == null || usertimeStr == null) {
                    return null; // 沒有登入資訊，直接返回 null
                }
    
                Long userId = Long.valueOf(userIdStr);
                Long usertime = Long.valueOf(usertimeStr);
                if (System.currentTimeMillis() - usertime < (Constants.COOKIE_EXPIRES_TIME * 1000)) {
                    user = UserAPI.getInstance().getUser(userId);
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        
        if (user != null) {
            User currentUser = UserAPI.getInstance().getUser(user.getId());
            // 取得該 user 的所有角色
            List<Role> roles = RoleAPI.getInstance().listRolesByUserId(user.getId());
            // 封裝成 DTO 回傳 (假設 DTO 的建構子為 UserRoleDTO(Long userId, User user, List<Role> roles))
            return new UserRoleDTO(currentUser, roles);
        }
        return null;
    }
    

    public static void setCurrentUser(HttpSession session, User user) {
        if (session != null) {
            session.setValue(Constants.SESSION_CURRENT_USER, user);
        }
    }

    public static void setCurrentUser(RequestData request, User user) {
        setCurrentUser(request.session, user);
    }

    public static void setCurrentUser(HttpSession session, String tenantId, User user) {
        if (session != null) {
            session.setValue(Constants.SESSION_CURRENT_TENANT_ID, tenantId);
            session.setValue(Constants.SESSION_CURRENT_USER, user);

        }
    }

    public static void setCurrentUser(RequestData request, String tenantId, User user) {
        setCurrentUser(request.session, tenantId, user);
        request.cookies.put(Constants.COOKIE_TENANTID, tenantId);
        request.cookies.put(Constants.COOKIE_USERNAME, Long.toString(user.getId()));
        request.cookies.put(Constants.COOKIE_USERTIME, Long.toString(System.currentTimeMillis()));
        List<UserRole> userRoles = UserRoleAPI.getInstance().listUserRolesByUserId(user.getId());
        SecurityUtils.setCurrentUserRoles(request, tenantId, userRoles);
    }

    public static Set<String> getCurrentUserRoles(HttpSession session) {
        Object obj = session.getValue(Constants.SESSION_CURRENT_USERROLES);
        if (obj != null && obj instanceof Set) {
            return (Set<String>) obj;
        }
        return null;
    }

    public static void setCurrentUserRoles(HttpSession session, String tenantId, List<UserRole> userRoles) {
        if (session != null) {
            Set<String> userRoleIds = userRoles.stream()
                    .map(userRole -> String.valueOf(userRole.getRoleId())) // 確保型別為 String
                    .collect(Collectors.toSet());
            session.setValue(Constants.SESSION_CURRENT_USERROLES, userRoleIds);
        }
    }

    public static void setCurrentUserRoles(HttpSession session, List<UserRole> userRoles) {
        if (session != null) {
            Set<String> userRoleIds = userRoles.stream()
                    .map(userRole -> String.valueOf(userRole.getRoleId())) // 確保型別為 String
                    .collect(Collectors.toSet());
            session.setValue(Constants.SESSION_CURRENT_USERROLES, userRoleIds);
        }
    }

    public static void setCurrentUserRoles(RequestData request, String tenantId, List<UserRole> userRoles) {
        setCurrentUserRoles(request.session, tenantId, userRoles);
    }

    public static boolean hasRoles(HttpSession session, String[] roleIds) {
        if (session != null) {
            Set<String> userRoleIds = getCurrentUserRoles(session);
            if (userRoleIds == null || userRoleIds.isEmpty()) {
                return false;
            }

            for (String roleId : roleIds) {
                if (userRoleIds.contains(roleId)) {
                    return true;
                }
            }
        }

        return false;
    }

    public static void clearCurrentUserAndSession(RequestData request) {
        if (request.session != null) {
            request.session.setValue(Constants.SESSION_CURRENT_TENANT_ID, null);
            request.session.setValue(Constants.SESSION_CURRENT_USER, null);
        }

        request.cookies.put(Constants.COOKIE_TENANTID, null);
        request.cookies.put(Constants.COOKIE_USERNAME, null);
        request.cookies.put(Constants.COOKIE_USERTIME, null);
        request.cookies.put(Constants.SESSION_CURRENT_USERROLES, null);
        request.cookies.put(Constants.SESSION_CURRENT_USER, null);

        request.cookies.remove(Constants.COOKIE_USERNAME);
        request.cookies.remove(Constants.COOKIE_USERTIME);
        request.cookies.remove(Constants.COOKIE_TENANTID);
        request.cookies.remove(Constants.SESSION_CURRENT_USERROLES);
        request.cookies.remove(Constants.SESSION_CURRENT_USER);
    }

    public static boolean hasRoles(RequestData request, String[] roleIds) {
        return hasRoles(request.session, roleIds);
    }

    public static Long getLongId(RequestData request, String fieldName) {
        try {
            return Long.valueOf(request.query.get(fieldName).trim());
        } catch (Exception ex) {
        }
        return null;
    }

    public static String getStringId(RequestData request, String fieldName) {
        try {
            return request.query.get(fieldName);
        } catch (Exception ex) {
        }
        return null;
    }

    // 加密密碼
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }

    // 驗證密碼
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }

    public static String getOrCreateJwtToken(RequestData request, UserRoleDTO user) {
        if (request.session == null) {
            throw new IllegalStateException("Session is not available in the request");
        }
        HttpSession session = request.session;
        String token = (String) session.getValue("jwt_token");

        if (token == null || token.isEmpty()) {
            token = createJwtToken(user);
            session.setValue("jwt_token", token);
        }
        return token;
    }

    private static String createJwtToken(UserRoleDTO user) {
        return Jwts.builder()
            .setSubject(user.getUsername())
            .claim("userId", user.getId())
            .claim("roles", user.getRoles() != null ? user.getRoles().stream().map(Role::getId).collect(Collectors.toList()) : Collections.emptyList())
            .setIssuedAt(new Date())
            .setExpiration(new Date(System.currentTimeMillis() + 86400000)) // 24 小時
            .signWith(SignatureAlgorithm.HS256, getSecretKey())
            .compact();
    }

    private static Key getSecretKey() {
        String secret = Config.get("jwt.secret", "KW+YiSYTz8y4CdHVonmDZWL/FxLTkVmjIDt+Xmfw1bg=");
        return Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
    }

    public static String getOrCreateSessionJWTToken(HttpSession session, UserRoleDTO user) {
        if (session == null) {
            throw new IllegalStateException("Session is not available in the request");
        }
        String token = (String) session.getValue("jwt_token");
        if (token == null || token.isEmpty()) {
            token = createJwtToken(user);
            session.setValue("jwt_token", token);
        }
        return token;
    }
    
    public static String getOrCreateSessionJWTToken(HttpSession session, User user) {
        List<Role> roles = RoleAPI.getInstance().listRolesByUserId(user.getId());
        UserRoleDTO userRoleDTO = new UserRoleDTO(user, roles);
        if (session == null) {
            throw new IllegalStateException("Session is not available in the request");
        }
        String token = (String) session.getValue("jwt_token");
        if (token == null || token.isEmpty()) {
            token = createJwtToken(userRoleDTO);
            session.setValue("jwt_token", token);
        }
        return token;
    }

    public static UserRoleDTO extractUserIdFromToken(String jwtToken) {
        
        Jws<Claims> parsedToken = Jwts.parserBuilder()
            .setSigningKey(getSecretKey()) // 這要跟產生 token 時用同一組密鑰
            .build()
            .parseClaimsJws(jwtToken);
    
        Claims claims = parsedToken.getBody();
        Long userId = claims.get("userId", Long.class);
        User user = UserAPI.getInstance().getUser(userId);
        List<Role> roles = RoleAPI.getInstance().listRolesByUserId(userId);
        return new UserRoleDTO(user, roles);
    }

    /**
     * 從 session 中移除 JWT token
     */
    public static void removeToken(HttpSession session) {
        if (session != null) {
            session.setValue("jwt_token", null);
        }
    }

    public static Locale getLocale(RequestData request) {
        String langTag = request.cookies.get("_freemarker_lang");
        // 只取 ; 前面的語言代碼
        if (langTag != null && langTag.contains(";")) {
            langTag = langTag.split(";")[0].trim();
        }
        if (langTag == null || langTag.isEmpty()) {
            langTag = "zh_TW";
        }
        Locale locale = toLocale(langTag);
        return locale;
    }

    public static Locale getLocale(HttpExchange exchange) {
        String langTag = null;
        if (exchange.getRequestHeaders().containsKey("Cookie")) {
            List<String> cookies = exchange.getRequestHeaders().get("Cookie");
            for (String cookie : cookies) {
                if (cookie.startsWith("_freemarker_lang=")) {
                    langTag = cookie.substring("_freemarker_lang=".length());
                    // 只取 ; 前面的語言代碼
                    if (langTag.contains(";")) {
                        langTag = langTag.split(";")[0].trim();
                    }
                    break;
                }
            }
        }
        if (langTag == null || langTag.isEmpty()) {
            langTag = "zh_TW";
        }
        Locale locale = toLocale(langTag);
        return locale;
    }

    private static Locale toLocale(String langTag) {
    if (langTag == null || langTag.isEmpty()) {
        // 如果連字串都沒提供，直接回傳預設 Locale（可自行決定，這裡用系統預設）
        return Locale.getDefault();
    }
    // 用底線 "_" 分成兩段，最多只切一次
    String[] parts = langTag.split("_", 2);
    if (parts.length == 1) {
        // 只有語言碼，像 "zh" 或 "en"
        return new Locale(parts[0]);
    } else {
        // 語言 + 區域/國家
        // 例如 parts[0]="zh", parts[1]="TW" → new Locale("zh","TW")
        return new Locale(parts[0], parts[1]);
    }
}
}
