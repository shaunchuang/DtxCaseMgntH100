package demo.freemarker.handler.restfulapi.training;

import com.sun.net.httpserver.HttpExchange;

import demo.freemarker.api.training.AchievementGoalAPI;
import demo.freemarker.model.training.AchievementGoal;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.List;

public class AchievementGoalRESTfulAPI extends RESTfulAPI {
    public AchievementGoalRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/AchievementGoal/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                AchievementGoalAPI.getInstance().getName(),
                AchievementGoalAPI.getInstance().getVersion(),
                AchievementGoalAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(AchievementGoal.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有目標")
    private String list(HttpExchange exchange) throws IOException {
        List<AchievementGoal> goals = AchievementGoalAPI.getInstance().listAchievementGoal();
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(goals);
    }
}
