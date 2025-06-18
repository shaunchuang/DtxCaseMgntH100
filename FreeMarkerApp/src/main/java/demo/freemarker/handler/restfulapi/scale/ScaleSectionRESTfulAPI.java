package demo.freemarker.handler.restfulapi.scale;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.scale.ScaleSectionAPI;
import demo.freemarker.core.GsonUtil;
import demo.freemarker.model.scale.ScaleSection;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;
import org.json.JSONObject;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class ScaleSectionRESTfulAPI extends RESTfulAPI {

    public ScaleSectionRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/ScaleSection/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                ScaleSectionAPI.getInstance().getName(),
                ScaleSectionAPI.getInstance().getVersion(),
                ScaleSectionAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(ScaleSection.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "取得所有 ScaleSection 資料")
    private String list(HttpExchange exchange) throws IOException {
        List<ScaleSection> sections = new ArrayList<>();
        try {
            sections = ScaleSectionAPI.getInstance().list();
        } catch (Exception ex) {
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
            return null;
        }
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(sections);
    }

}
