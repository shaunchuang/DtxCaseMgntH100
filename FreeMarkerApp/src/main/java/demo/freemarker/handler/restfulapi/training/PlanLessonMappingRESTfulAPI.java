package demo.freemarker.handler.restfulapi.training;

import com.sun.net.httpserver.HttpExchange;

import demo.freemarker.api.training.PlanLessonMappingAPI;
import demo.freemarker.model.training.PlanLessonMapping;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.List;

public class PlanLessonMappingRESTfulAPI extends RESTfulAPI {
    public PlanLessonMappingRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/PlanLessonMapping/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                PlanLessonMappingAPI.getInstance().getName(),
                PlanLessonMappingAPI.getInstance().getVersion(),
                PlanLessonMappingAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(PlanLessonMapping.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有計畫課程對應")
    private String list(HttpExchange exchange) throws IOException {
        List<PlanLessonMapping> mappings = PlanLessonMappingAPI.getInstance().listPlanLessonMappings();
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(mappings);
    }
}
