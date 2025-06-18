package demo.freemarker.handler.restfulapi.training;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.training.TrainingAchievementAPI;

import demo.freemarker.api.training.TrainingRecordAPI;
import demo.freemarker.api.training.TrainingStatisticsAPI;
import demo.freemarker.core.SecurityUtils;
import demo.freemarker.dto.UserRoleDTO;
import demo.freemarker.model.training.TrainingAchievement;
import demo.freemarker.model.training.TrainingRecord;
import demo.freemarker.model.training.TrainingStatistics;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.time.Instant;
import java.util.Date;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

public class TrainingRecordRESTfulAPI extends RESTfulAPI {

    public TrainingRecordRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/TrainingRecord/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                TrainingRecordAPI.getInstance().getName(),
                TrainingRecordAPI.getInstance().getVersion(),
                TrainingRecordAPI.getInstance().getDescription());

        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(TrainingRecord.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有訓練記錄")
    private String list(HttpExchange exchange) throws IOException {
        List<TrainingRecord> records = TrainingRecordAPI.getInstance().listTrainingRecords();

        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(records);
    }
    
    @RESTfulAPIDefine(url = "scratchUpload", methods = "post", description = "scratchTrainingDataUploadAPI")
    private String scratchUpload(HttpExchange exchange) throws IOException {
        // 1. 從 Header 取出 JWT
        try {
            List<String> auth = exchange.getRequestHeaders().get("Authorization");

            
            if (auth == null || auth.isEmpty() || !auth.get(0).startsWith("Bearer ")) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, -1);
                return null;
            }
            String jwtToken = auth.get(0).substring("Bearer ".length());

            // 2. 驗證並解析使用者
            UserRoleDTO userDTO;
            userDTO = SecurityUtils.extractUserIdFromToken(jwtToken);

            Long userId = userDTO.getId();

            // 3. 讀取並解析 JSON body
            String body = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject json = new JSONObject(body);

            // 4. 將 JSON 欄位映射到 TrainingRecord
            TrainingRecord record = new TrainingRecord();
            record.setCreatedAt(new Date());

            // …若有其他欄位，也一併設定…
            record.setPlanLessonId(json.getLong("planLessonId"));
            Instant startInst = Instant.parse(json.getString("startTime"));
            record.setStartTime(Date.from(startInst));
            Instant endInst = Instant.parse(json.getString("endTime"));
            record.setEndTime(Date.from(endInst));

            // 4.1 計算並設定 duration（單位：秒）
            long seconds = Duration.between(startInst, endInst).getSeconds();
            record.setDuration((int) seconds);
            // 5. 建立訓練記錄
            TrainingRecordAPI.getInstance().createTrainingRecord(record);

            JSONArray achievementArray = json.optJSONArray("achievement");
            JSONArray statisticsArray = json.optJSONArray("statistics");

            if (achievementArray != null && achievementArray.length() > 0) {
                for (int i = 0; i < achievementArray.length(); i++) {
                    JSONObject ach = achievementArray.getJSONObject(i);
                    TrainingAchievement trainingAchievement = new TrainingAchievement();
                    // 取出成就 API 名稱
                    String apiName = ach.getString("key");
                    trainingAchievement.setAchievementApiName(apiName);

                    // 只對 "value" 欄位 parse 時間
                    String timeStr = ach.getString("value");
                    Instant unlockedInst = Instant.parse(timeStr);
                    trainingAchievement.setUnlockedTime(Date.from(unlockedInst));

                    trainingAchievement.setRecordId(record.getId());
                    TrainingAchievementAPI.getInstance().createTrainingAchievement(trainingAchievement);

                }
            }

            if (statisticsArray != null && statisticsArray.length() > 0) {
                for (int i = 0; i < statisticsArray.length(); i++) {
                    JSONObject stat = statisticsArray.getJSONObject(i);
                    TrainingStatistics trainingStatistics = new TrainingStatistics();
                    // 取出統計 API 名稱
                    String apiName = stat.getString("key");
                    trainingStatistics.setStatisticsApiName(apiName);

                    // 只對 "value" 欄位 parse 時間
                    Double statValue = stat.getDouble("value");
                    trainingStatistics.setStatValue(statValue);

                    trainingStatistics.setRecordId(record.getId());
                    TrainingStatisticsAPI.getInstance().createTrainingStatistics(trainingStatistics);
                }
            }

            // 6. 回傳結果
            JSONObject resp = new JSONObject();
            resp.put("status", "success");
            resp.put("recordId", record.getId());
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_CREATED, 0);
            return resp.toString();
        } catch (Exception e) {
            e.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_UNAUTHORIZED, -1);
            return null;
        }
    }
}
