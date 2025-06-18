/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.handler.restfulapi;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.UserAPI;
import demo.freemarker.model.User;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.json.JSONObject;

/**
 *
 * @author zhush
 */
public class UserRESTfulAPI extends RESTfulAPI {
    public UserRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/User/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                UserAPI.getInstance().getName(),
                UserAPI.getInstance().getVersion(),
                UserAPI.getInstance().getDescription());
        //
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(User.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有使用者")
    private String list(HttpExchange exchange) throws IOException {
        List<User> users = UserAPI.getInstance().listUser();

        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(users);
    }

    @RESTfulAPIDefine(url = "listUserRole", methods = "post", description = "列出所有使用者角色")
    private String listUserRole(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);

        JSONObject json = new JSONObject(requestBody);

        String role = json.optString("alias", null);
        List<User> users = UserAPI.getInstance().listUserByRole(role);

        responseJson.put("doctors", users);
        responseJson.put("success", true);

        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }
}
