package demo.freemarker.handler.restfulapi.training;

import com.sun.net.httpserver.HttpExchange;

import demo.freemarker.api.training.TrainingAchievementAPI;
import demo.freemarker.model.training.TrainingAchievement;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.List;

public class TrainingAchievementRESTfulAPI extends RESTfulAPI {
    public TrainingAchievementRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/TrainingAchievement/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                TrainingAchievementAPI.getInstance().getName(),
                TrainingAchievementAPI.getInstance().getVersion(),
                TrainingAchievementAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(TrainingAchievement.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有訓練成果")
    private String list(HttpExchange exchange) throws IOException {
        List<TrainingAchievement> achievements = TrainingAchievementAPI.getInstance().listTrainingAchievement();
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(achievements);
    }
}
