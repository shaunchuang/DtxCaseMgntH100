package demo.freemarker.handler.restfulapi;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.HashMap;
import java.util.Map;

import com.sun.net.httpserver.HttpExchange;

import demo.freemarker.core.HttpClientUtil;

import org.json.JSONObject;

import itri.sstc.framework.core.api.RESTfulAPI;

public class SupersetRESTfulAPI extends RESTfulAPI {

    private static final String supersetUrl = "http://localhost:8088";

    public SupersetRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/superset/api/";
    }

    @RESTfulAPIDefine(url = "guest-token", methods = "post", description = "登入")
    private String getGuestToken(HttpExchange exchange) throws IOException {
        JSONObject jsonRequest;
        JSONObject responseJson = new JSONObject();
        try {
            JSONObject payload = new JSONObject();

            String url = supersetUrl + "/security/guest_token";
            Map<String, String> headers = new HashMap<>();
            headers.put("Accept-Language", "zh-TW");
            headers.put("User-Agent", "Mozilla/5.0");
            headers.put("Accept-Charset", "UTF-8");
            String response = HttpClientUtil.sendPostRequest(url, headers, payload.toString());
            return response;
        } catch (Exception e) {
            e.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, -1);
        }
        return null;
    }

}
