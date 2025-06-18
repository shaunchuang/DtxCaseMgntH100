package demo.freemarker.handler.restfulapi.healthinsurance;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.healthinsurance.HealthInsuranceRecordAPI;
import demo.freemarker.api.healthinsurance.TherapeuticTreatmentAPI;
import demo.freemarker.model.healthinsurance.HealthInsuranceRecord;
import demo.freemarker.model.healthinsurance.TherapeuticTreatment;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.stream.Collectors;
import org.json.JSONArray;
import org.json.JSONObject;

public class HealthInsuranceRecordRESTfulAPI extends RESTfulAPI {

    public HealthInsuranceRecordRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/HealthInsuranceRecord/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                HealthInsuranceRecordAPI.getInstance().getName(),
                HealthInsuranceRecordAPI.getInstance().getVersion(),
                HealthInsuranceRecordAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(HealthInsuranceRecord.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有健保紀錄")
    private String list(HttpExchange exchange) throws IOException {
        List<HealthInsuranceRecord> records = HealthInsuranceRecordAPI.getInstance().listRecords();
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(records);
    }

    @RESTfulAPIDefine(url = "save", methods = "post", description = "儲存健保紀錄")
    private String save(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);

            JSONObject requestJson = new JSONObject(requestBody);
            JSONObject hrJson = requestJson.getJSONObject("healthRecord");

            HealthInsuranceRecord record = new HealthInsuranceRecord();
            record.setCopayment(hrJson.getInt("copayment"));
            record.setCopaymentCode(hrJson.getString("copaymentCode"));
            record.setMainDiagnosisCode(hrJson.getString("mainDiagnosisCode"));
            record.setObjective(hrJson.getString("objective"));
            record.setSubjective(hrJson.getString("subjective"));
            record.setPatientId(hrJson.getLong("patientId"));
            record.setSerialNum(hrJson.getString("serialNum"));
            record.setTotalPoint(hrJson.getInt("totalPoint"));

            // 處理 secondaryDiagnosisCodes
            if (hrJson.has("secondaryDiagnosisCodes")) {
                List<String> secondaryDiagnosisCodes = hrJson.getJSONArray("secondaryDiagnosisCodes").toList()
                        .stream()
                        .map(Object::toString)
                        .collect(Collectors.toList());
                record.setSecondaryDiagnosisCodes(secondaryDiagnosisCodes);
            }
            
            HealthInsuranceRecordAPI.getInstance().createRecord(record);

            JSONArray treatments = requestJson.getJSONArray("treatments");
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm"); // 定義時間格式

            for (int i = 0; i < treatments.length(); i++) {
                JSONObject treatmentJson = treatments.getJSONObject(i);
                TherapeuticTreatment treatment = new TherapeuticTreatment();

                // 設置處置代碼
                treatment.setTreatmentCode(treatmentJson.getString("treatmentCode"));

                // 設置總量
                treatment.setTotalMount(treatmentJson.getString("totalMount"));

                // 設置點數
                treatment.setPoint(treatmentJson.getInt("point"));

                // 設置執行人員ID
                treatment.setExecutiveId(treatmentJson.getLong("executiveId"));

                // 設置開始時間
                treatment.setStartTime(timeFormat.parse(treatmentJson.getString("startTime")));

                // 設置結束時間
                treatment.setEndTime(timeFormat.parse(treatmentJson.getString("endTime")));

                treatment.setHiRecordId(record.getId());
                
                TherapeuticTreatmentAPI.getInstance().createTreatment(treatment);
            }

            responseJson.put("success", true);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();
        } catch (Exception e) {
            e.printStackTrace();
            responseJson.put("success", false);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();
        }
    }
}
