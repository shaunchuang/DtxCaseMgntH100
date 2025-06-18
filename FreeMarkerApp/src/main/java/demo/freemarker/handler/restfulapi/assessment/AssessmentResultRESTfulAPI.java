package demo.freemarker.handler.restfulapi.assessment;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.assessment.AssessmentResultAPI;
import demo.freemarker.model.assessment.AssessmentResult;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.ArrayList;
import java.util.List;

public class AssessmentResultRESTfulAPI extends RESTfulAPI {

    public AssessmentResultRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/AssessmentResult/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                AssessmentResultAPI.getInstance().getName(),
                AssessmentResultAPI.getInstance().getVersion(),
                AssessmentResultAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(AssessmentResult.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "取得所有 AssessmentResult 資料")
    private String list(HttpExchange exchange) throws IOException {
        List<AssessmentResult> results = new ArrayList<>();
        try {
            results = AssessmentResultAPI.getInstance().list();
        } catch (Exception ex) {
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
            return null;
        }
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(results);
    }

}
