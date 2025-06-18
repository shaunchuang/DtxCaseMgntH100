package demo.freemarker.handler.restfulapi.training;

import com.sun.net.httpserver.HttpExchange;

import demo.freemarker.api.training.TrainingPlanAPI;
import demo.freemarker.model.training.TrainingPlan;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.List;

public class TrainingPlanRESTfulAPI extends RESTfulAPI {
    public TrainingPlanRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/TrainingPlan/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                TrainingPlanAPI.getInstance().getName(),
                TrainingPlanAPI.getInstance().getVersion(),
                TrainingPlanAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(TrainingPlan.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有訓練計畫")
    private String list(HttpExchange exchange) throws IOException {
        List<TrainingPlan> plans = TrainingPlanAPI.getInstance().listTrainingPlan();
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(plans);
    }
}
