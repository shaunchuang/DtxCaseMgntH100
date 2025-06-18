package demo.freemarker.handler.restfulapi.training;

import com.sun.net.httpserver.HttpExchange;

import demo.freemarker.api.training.TrainingStatisticsAPI;
import demo.freemarker.model.training.TrainingStatistics;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.List;

public class TrainingStatisticsRESTfulAPI extends RESTfulAPI {
    public TrainingStatisticsRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/TrainingStatistics/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                TrainingStatisticsAPI.getInstance().getName(),
                TrainingStatisticsAPI.getInstance().getVersion(),
                TrainingStatisticsAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(TrainingStatistics.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有訓練統計")
    private String list(HttpExchange exchange) throws IOException {
        List<TrainingStatistics> statistics = TrainingStatisticsAPI.getInstance().listTrainingStatistics();
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(statistics);
    }
}
