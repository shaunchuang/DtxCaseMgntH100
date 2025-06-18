package demo.freemarker.handler.restfulapi.scale;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.scale.ScaleItemAPI;
import demo.freemarker.core.GsonUtil;
import demo.freemarker.model.scale.ScaleItem;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;
import org.json.JSONObject;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class ScaleItemRESTfulAPI extends RESTfulAPI {

    public ScaleItemRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/ScaleItem/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                ScaleItemAPI.getInstance().getName(),
                ScaleItemAPI.getInstance().getVersion(),
                ScaleItemAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(ScaleItem.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "取得所有 ScaleItem 資料")
    private String list(HttpExchange exchange) throws IOException {
        List<ScaleItem> items = new ArrayList<>();
        try {
            items = ScaleItemAPI.getInstance().list();
        } catch (Exception ex) {
            ex.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
            return null;
        }
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(items);
    }

}
