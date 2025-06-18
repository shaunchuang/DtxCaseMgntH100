package demo.freemarker.handler.restfulapi.scale;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.scale.ScaleItemOptionAPI;
import demo.freemarker.core.GsonUtil;
import demo.freemarker.model.scale.ScaleItemOption;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;
import org.json.JSONObject;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class ScaleItemOptionRESTfulAPI extends RESTfulAPI {

    public ScaleItemOptionRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/ScaleItemOption/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                ScaleItemOptionAPI.getInstance().getName(),
                ScaleItemOptionAPI.getInstance().getVersion(),
                ScaleItemOptionAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(ScaleItemOption.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "取得所有 ScaleItemOption 資料")
    private String list(HttpExchange exchange) throws IOException {
        List<ScaleItemOption> options = new ArrayList<>();
        try {
            options = ScaleItemOptionAPI.getInstance().list();
        } catch (Exception ex) {
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
            return null;
        }
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(options);
    }
}
