package demo.freemarker.handler.restfulapi.healthinsurance;

import com.sun.net.httpserver.HttpExchange;

import demo.freemarker.api.healthinsurance.TherapeuticTreatmentAPI;
import demo.freemarker.model.healthinsurance.TherapeuticTreatment;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.List;

public class TherapeuticTreatmentRESTfulAPI extends RESTfulAPI {
    public TherapeuticTreatmentRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/TherapeuticTreatment/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                TherapeuticTreatmentAPI.getInstance().getName(),
                TherapeuticTreatmentAPI.getInstance().getVersion(),
                TherapeuticTreatmentAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(TherapeuticTreatment.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有治療記錄")
    private String list(HttpExchange exchange) throws IOException {
        List<TherapeuticTreatment> treatments = TherapeuticTreatmentAPI.getInstance().listTreatments();
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(treatments);
    }
}
