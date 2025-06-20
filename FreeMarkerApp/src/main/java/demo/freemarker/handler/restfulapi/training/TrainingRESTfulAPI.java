package demo.freemarker.handler.restfulapi.training;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONObject;

import com.sun.net.httpserver.HttpExchange;

import demo.freemarker.api.PatientAPI;
import demo.freemarker.api.healthinsurance.HealthInsuranceRecordAPI;
import demo.freemarker.api.training.AchievementGoalAPI;
import demo.freemarker.api.training.PlanLessonMappingAPI;
import demo.freemarker.api.training.StatisticsGoalAPI;
import demo.freemarker.api.training.TrainingAchievementAPI;
import demo.freemarker.api.training.TrainingPlanAPI;
import demo.freemarker.api.training.TrainingRecordAPI;
import demo.freemarker.api.training.TrainingStatisticsAPI;
import demo.freemarker.dto.Achievement;
import demo.freemarker.dto.StatsData;
import demo.freemarker.dto.TrainingData;
import demo.freemarker.dto.TrainingPlanDTO;
import demo.freemarker.model.Patient;
import demo.freemarker.model.healthinsurance.HealthInsuranceRecord;
import demo.freemarker.model.training.AchievementGoal;
import demo.freemarker.model.training.PlanLessonMapping;
import demo.freemarker.model.training.StatisticsGoal;
import demo.freemarker.model.training.TrainingAchievement;
import demo.freemarker.model.training.TrainingPlan;
import demo.freemarker.model.training.TrainingRecord;
import demo.freemarker.model.training.TrainingStatistics;
import itri.sstc.framework.core.api.RESTfulAPI;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


public class TrainingRESTfulAPI extends RESTfulAPI {

    // save training Data
    // training data list
    //
    public TrainingRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/Training/api/";
    }

    @RESTfulAPIDefine(url = "savePlan", methods = "post", description = "儲存訓練計畫")
    private String saveTrainingPlan(HttpExchange exchange) throws IOException {
        try {
            JSONObject responseJson = new JSONObject();
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONArray lessons = new JSONObject(requestBody).getJSONArray("lessons");
            JSONObject hrJson = new JSONObject(requestBody).getJSONObject("trainingData");
            TrainingPlan trainingPlan = new TrainingPlan();
            // 取出 trainingData 區塊
            JSONObject td = hrJson;  // 即 new JSONObject(requestBody).getJSONObject("trainingData")

            trainingPlan.setTherapist(td.getLong("therapist"));   // 若欄位是長整數
            trainingPlan.setPatientId(td.getLong("patientId"));
            trainingPlan.setTitle(td.getString("title"));

            DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

            /* ---------- 1. 時間欄位：LocalDateTime → Timestamp ---------- */
            LocalDateTime startLdt = LocalDateTime.parse(td.getString("startDate"), fmt);
            LocalDateTime endLdt   = LocalDateTime.parse(td.getString("endDate"),   fmt);
            trainingPlan.setStartDate(Timestamp.valueOf(startLdt));
            trainingPlan.setEndDate  (Timestamp.valueOf(endLdt));

            /* ---------- 2. frequency 欄位：字串轉 Integer（允許空值） ---------- */
            Integer freqPerWeek = parseNullableInt(td.optString("frequencyPerWeek", null));
            Integer freqPerDay  = parseNullableInt(td.optString("frequencyPerDay",  null));
            trainingPlan.setFrequencyPerWeek(freqPerWeek);
            trainingPlan.setFrequencyPerDay (freqPerDay);

            /* ---------- 3. duration 欄位：字串轉 Integer（允許空值） ---------- */
            Integer durationPerSession = parseNullableInt(td.optString("durationPerSession", null));
            trainingPlan.setDurationPerSession(durationPerSession);

            trainingPlan.setNotes(td.optString("notes", null));
            trainingPlan.setCreateTime(new Date());
            TrainingPlanAPI.getInstance().createTrainingPlan(trainingPlan);
            JSONArray lessonArray = new JSONArray(lessons);

            for (int i = 0; i < lessonArray.length(); i++) {
                JSONObject lessonObject = lessonArray.getJSONObject(i);
                Object keyObj = lessonObject.get("lessonKeyNo");
                long lessonKeyNo = (keyObj instanceof Number)
                                ? ((Number) keyObj).longValue()
                                : Long.parseLong(keyObj.toString());


                PlanLessonMapping mapping = new PlanLessonMapping();
                mapping.setPlanId(trainingPlan.getId());
                mapping.setLessonId(lessonKeyNo);
                PlanLessonMappingAPI.getInstance().createPlanLessonMapping(mapping);

                // 處理成就目標
                if (lessonObject.has("achievementApis")) {
                    JSONArray achievementApis = lessonObject.getJSONArray("achievementApis");
                    for (int j = 0; j < achievementApis.length(); j++) {
                        String api = String.valueOf(achievementApis.get(j));
                        AchievementGoal achievementGoal = new AchievementGoal();
                        achievementGoal.setMappingId(mapping.getId());
                        achievementGoal.setApiName(api);
                        AchievementGoalAPI.getInstance().createAchievementGoal(achievementGoal);
                    }
                }

                // 處理統計目標
                if (lessonObject.has("statisticsGoals")) {
                    JSONArray statisticsGoals = lessonObject.getJSONArray("statisticsGoals");
                    for (int j = 0; j < statisticsGoals.length(); j++) {
                        JSONObject statObject = statisticsGoals.getJSONObject(j);
                        String apiName = statObject.getString("apiName");
                        String valueGoal = statObject.getString("valueGoal");

                        StatisticsGoal statisticsGoal = new StatisticsGoal();
                        statisticsGoal.setMappingId(mapping.getId());
                        statisticsGoal.setApiName(apiName);
                        statisticsGoal.setValueGoal(valueGoal);
                        StatisticsGoalAPI.getInstance().createStatisticsGoal(statisticsGoal);
                    }
                }
            }
            /* 健保紀錄 */
            HealthInsuranceRecord healthInsuranceRecord = new HealthInsuranceRecord();
            healthInsuranceRecord.setCreator(td.getLong("therapist"));
            healthInsuranceRecord.setObjective(hrJson.getString("objective"));
            healthInsuranceRecord.setSubjective(hrJson.getString("subjective"));
            healthInsuranceRecord.setPatientId(hrJson.getLong("patientId"));

            HealthInsuranceRecordAPI.getInstance().createRecord(healthInsuranceRecord);

            responseJson.put("success", Boolean.TRUE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject responseJson = new JSONObject();
            responseJson.put("success", Boolean.FALSE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
            return responseJson.toString();
        }
    }

    @RESTfulAPIDefine(url = "getPlan", methods = "post", description = "取得訓練計畫")
    public String getTrainingPlan(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
        Long planId = new JSONObject(requestBody).getLong("planId");
        TrainingPlan trainingPlan = TrainingPlanAPI.getInstance().getTrainingPlan(planId);
        TrainingPlanDTO dto = TrainingPlanAPI.getInstance().convertPlanDTO(trainingPlan);

        responseJson.put("success", Boolean.TRUE);
        responseJson.put("trainingPlan", dto);
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }

    @RESTfulAPIDefine(url = "listPlan", methods = "post", description = "列出所有訓練計畫")
    public String listTrainingPlan(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
        System.out.println(requestBody);
        
        Long patientId = new JSONObject(requestBody).optLong("patientId");
        if(patientId == 0) {
            Long userId = new JSONObject(requestBody).optLong("userId");
            if(userId == 0){
                responseJson.put("success", Boolean.FALSE);
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
                return responseJson.toString();
            } else {
                Patient patient = PatientAPI.getInstance().getPatientByUserId(userId);
                System.out.println("patient getId: " + patient.getId());
                patientId = patient.getId();
            }
        }
        System.out.println("patientId: " + patientId);
        List<TrainingPlan> trainingPlans = TrainingPlanAPI.getInstance().listByPatient(patientId);
        List<TrainingPlanDTO> trainingPlanDTOs = trainingPlans.stream()
                .map(trainingPlan -> {
                    return TrainingPlanAPI.getInstance().convertPlanDTO(trainingPlan);
                })
                .collect(Collectors.toList());
        responseJson.put("trainingPlans", trainingPlanDTOs);
        responseJson.put("success", Boolean.TRUE);
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }

    @RESTfulAPIDefine(url = "saveData", methods = "post", description = "")
    private String saveTrainingData(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
        String lessonId = new JSONObject(requestBody).getString("lessonId");
        JSONObject recordObj = new JSONObject(requestBody).getJSONObject("data");
        String planId = new JSONObject(requestBody).getString("planId");

        Long startTime = recordObj.getLong("startTime");
        Long endTime = recordObj.getLong("endTime");

        TrainingRecord trainingRecord = new TrainingRecord();
        trainingRecord.setStartTime(new Date(startTime));
        trainingRecord.setEndTime(new Date(endTime));
        long duration = (endTime - startTime) / 1000; // Convert milliseconds to seconds
        trainingRecord.setDuration((int) duration);

        /* 處理 一個 訓練計畫 底下只會有一個 訓練教案 */
        List<PlanLessonMapping> mappings = PlanLessonMappingAPI.getInstance()
                .PlanLessonMappingByLessonIdAndPlanId(Long.parseLong(lessonId), Long.parseLong(planId));
        if (mappings.size() > 0) {
            PlanLessonMapping mapping = mappings.get(0);
            trainingRecord.setPlanLessonId(mapping.getId());
        } else {
            responseJson.put("success", Boolean.FALSE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
            return responseJson.toString();
        }
        trainingRecord.setCreatedAt(new Date());
        TrainingRecordAPI.getInstance().createTrainingRecord(trainingRecord);
        List<AchievementGoal> achList = AchievementGoalAPI.getInstance()
                .listByMappingId(trainingRecord.getPlanLessonId());
        List<StatisticsGoal> statsList = StatisticsGoalAPI.getInstance()
                .listByMappingId(trainingRecord.getPlanLessonId());

        // 取得成就
        JSONArray achArray = recordObj.getJSONArray("unlockedAchievements");
        for (int i = 0; i < achArray.length(); i++) {
            for (AchievementGoal ach : achList) {
                if (ach.getApiName().equals(achArray.getJSONObject(i).getString("apiname"))) {
                    JSONObject achObj = achArray.getJSONObject(i);
                    TrainingAchievement achievement = new TrainingAchievement();
                    achievement.setRecordId(trainingRecord.getId());
                    achievement.setAchievementApiName(ach.getApiName());
                    achievement.setUnlockedTime(new Date(achObj.getLong("unlocktime")));
                    TrainingAchievementAPI.getInstance().createTrainingAchievement(achievement);
                }
            }
        }

        // 取得統計
        JSONObject statsObj = recordObj.getJSONObject("stats");
        Iterator<String> keys = statsObj.keys();
        while (keys.hasNext()) {
            String key = keys.next();
            double difference = statsObj.getDouble(key);
            for (StatisticsGoal stats : statsList) {
                if (stats.getApiName().equals(key)) {
                    TrainingStatistics statsData = new TrainingStatistics();
                    statsData.setRecordId(trainingRecord.getId());
                    statsData.setStatisticsApiName(stats.getApiName());
                    statsData.setStatValue(difference);
                    TrainingStatisticsAPI.getInstance().createTrainingStatistics(statsData);
                }
            }
        }

        responseJson.put("success", Boolean.TRUE);
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }

    @RESTfulAPIDefine(url = "listData", methods = "post", description = "列出所有訓練紀錄")
    private String getTrainingData(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);

        String lessonId = new JSONObject(requestBody).getString("lessonId");
        String planId = new JSONObject(requestBody).getString("planId");

        List<PlanLessonMapping> mappings = PlanLessonMappingAPI.getInstance()
                .PlanLessonMappingByLessonIdAndPlanId(Long.parseLong(lessonId), Long.parseLong(planId));
        PlanLessonMapping mapping = null;
        if (mappings.size() > 0) {
            mapping = mappings.get(0);
        } else {
            responseJson.put("success", Boolean.FALSE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
            return responseJson.toString();
        }
        List<TrainingRecord> trainingList = TrainingRecordAPI.getInstance().listRecordsByPlanLessonId(mapping.getId());
        List<TrainingData> dataList = new ArrayList<>();

        for (TrainingRecord record : trainingList) {
            TrainingData trainingData = new TrainingData();
            trainingData.setStartTime(record.getStartTime().getTime());
            trainingData.setEndTime(record.getEndTime().getTime());
            trainingData.setPeriod(record.getEndTime().getTime() - record.getStartTime().getTime());

            // 成就列表
            List<Achievement> achievementList = new ArrayList<>();
            List<TrainingAchievement> achievementData = TrainingAchievementAPI.getInstance().listTrainingAchievementsByRecordId(record.getId());
            for (TrainingAchievement achievement : achievementData) {
                Achievement ach = new Achievement();
                ach.setApiname(achievement.getAchievementApiName());
                ach.setUnlocktime(achievement.getUnlockedTime().getTime());
                achievementList.add(ach);
            }

            // 統計列表
            List<StatsData> statsList = new ArrayList<>();
            List<TrainingStatistics> statsData = TrainingStatisticsAPI.getInstance().listByRecordId(record.getId());
            for (TrainingStatistics stats : statsData) {
                StatsData statsObj = new StatsData();
                statsObj.setApiName(stats.getStatisticsApiName());
                statsObj.setStatsValue(String.valueOf(stats.getStatValue()));
                statsList.add(statsObj);
            }
            trainingData.setAchievement(achievementList);
            trainingData.setStatsData(statsList);
            dataList.add(trainingData);
        }
        responseJson.put("data", dataList);
        responseJson.put("success", Boolean.TRUE);

        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }

    @RESTfulAPIDefine(url = "monitor", methods = "post", description = "取得病人資訊")
    private String getPatientInfo(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
        String lessonId = new JSONObject(requestBody).getString("lessonId");
        
    }

    /* ---------- 輔助函式 ---------- */
    private Integer parseNullableInt(String s) {
        if (s == null || s.isBlank()) {
            return null;
        }
        return Integer.valueOf(s);   // 會自動 unbox 成 int 或用 Integer 視欄位型別而定
    }
}
