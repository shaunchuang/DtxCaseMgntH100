package demo.freemarker.handler.restfulapi.training;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONObject;

import com.sun.net.httpserver.HttpExchange;

import demo.freemarker.api.ConfigPropertyAPI;
import demo.freemarker.api.PatientAPI;
import demo.freemarker.api.healthinsurance.HealthInsuranceRecordAPI;
import demo.freemarker.api.training.AchievementGoalAPI;
import demo.freemarker.api.training.PlanLessonMappingAPI;
import demo.freemarker.api.training.StatisticsGoalAPI;
import demo.freemarker.api.training.TrainingAchievementAPI;
import demo.freemarker.api.training.TrainingPlanAPI;
import demo.freemarker.api.training.TrainingRecordAPI;
import demo.freemarker.api.training.TrainingStatisticsAPI;
import demo.freemarker.core.SteamUtils;
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
import java.util.Optional;

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
            LocalDateTime endLdt = LocalDateTime.parse(td.getString("endDate"), fmt);
            trainingPlan.setStartDate(Timestamp.valueOf(startLdt));
            trainingPlan.setEndDate(Timestamp.valueOf(endLdt));

            /* ---------- 2. frequency 欄位：字串轉 Integer（允許空值） ---------- */
            Integer freqPerWeek = parseNullableInt(td.optString("frequencyPerWeek", null));
            Integer freqPerDay = parseNullableInt(td.optString("frequencyPerDay", null));
            trainingPlan.setFrequencyPerWeek(freqPerWeek);
            trainingPlan.setFrequencyPerDay(freqPerDay);

            /* ---------- 3. duration 欄位：字串轉 Integer（允許空值） ---------- */
            Integer durationPerSession = parseNullableInt(td.optString("durationPerSession", null));
            trainingPlan.setDurationPerSession(durationPerSession);

            trainingPlan.setTrainingWeekDay(td.optString("trainingDays", null));

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
        if (patientId == 0) {
            Long userId = new JSONObject(requestBody).optLong("userId");
            if (userId == 0) {
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
        JSONObject req = new JSONObject(requestBody);
        System.out.println("Request Body: " + requestBody);

        /* 1️⃣ 讀取基本欄位 ---------------------------------------------------- */
        Long lessonId = req.getLong("lessonId");   // 假設仍在 payload 中
        Long planId = req.getLong("planId");     // 同上

        long startTime = req.getLong("startTime");
        long endTime = req.getLong("endTime");

        /* 2️⃣ 建立 TrainingRecord ------------------------------------------- */
        TrainingRecord trainingRecord = new TrainingRecord();
        trainingRecord.setStartTime(new Date(startTime));
        trainingRecord.setEndTime(new Date(endTime));
        trainingRecord.setDuration((int) ((endTime - startTime) / 1000)); // 秒
        trainingRecord.setCreatedAt(new Date());

        /* 3️⃣ 取得對應的 PlanLessonMapping ----------------------------------- */
        List<PlanLessonMapping> mappings = PlanLessonMappingAPI.getInstance()
                .PlanLessonMappingByLessonIdAndPlanId(lessonId, planId);

        if (mappings.isEmpty()) {
            responseJson.put("success", Boolean.FALSE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_BAD_REQUEST, 0);
            return responseJson.toString();
        }
        trainingRecord.setPlanLessonId(mappings.get(0).getId());

        TrainingRecordAPI.getInstance().createTrainingRecord(trainingRecord);

        /* 4️⃣ 保留目標清單（若日後要用到） ---------------------------------- */
        List<AchievementGoal> achList = AchievementGoalAPI.getInstance()
                .listByMappingId(trainingRecord.getPlanLessonId());
        List<StatisticsGoal> statsList = StatisticsGoalAPI.getInstance()
                .listByMappingId(trainingRecord.getPlanLessonId());

        /* 5️⃣ 直接寫入所有成就資料（不再過濾 achList） ----------------------- */
        JSONArray achArr = req.optJSONArray("unlockedAchievements");
        if (achArr != null) {
            for (int i = 0; i < achArr.length(); i++) {
                JSONObject achObj = achArr.getJSONObject(i);

                TrainingAchievement ta = new TrainingAchievement();
                ta.setRecordId(trainingRecord.getId());
                ta.setAchievementApiName(achObj.getString("apiname"));
                ta.setUnlockedTime(new Date(achObj.getLong("unlocktime")));
                TrainingAchievementAPI.getInstance().createTrainingAchievement(ta);
            }
        }

        /* 6️⃣ 直接寫入所有統計資料（不再過濾 statsList） --------------------- */
        JSONArray statsArr = req.optJSONArray("stats");
        if (statsArr != null) {
            for (int i = 0; i < statsArr.length(); i++) {
                JSONObject sObj = statsArr.getJSONObject(i);

                TrainingStatistics ts = new TrainingStatistics();
                ts.setRecordId(trainingRecord.getId());
                ts.setStatisticsApiName(sObj.getString("apiName"));

                double diff;
                try {
                    diff = Double.parseDouble(sObj.getString("statsValue"));
                } catch (NumberFormatException e) {
                    diff = sObj.optDouble("statsValue", 0.0);
                }
                ts.setStatValue(diff);
                TrainingStatisticsAPI.getInstance().createTrainingStatistics(ts);
            }
        }

        /* 7️⃣ 回應 ----------------------------------------------------------- */
        responseJson.put("success", Boolean.TRUE);
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }

    @RESTfulAPIDefine(url = "listData", methods = "post", description = "列出所有訓練紀錄")
    private String getTrainingData(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);

        Long lessonId = new JSONObject(requestBody).getLong("lessonId");
        String planId = new JSONObject(requestBody).getString("planId");

        List<PlanLessonMapping> mappings = PlanLessonMappingAPI.getInstance()
                .PlanLessonMappingByLessonIdAndPlanId(lessonId, Long.parseLong(planId));
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
        try {
            JSONObject responseJson = new JSONObject();
            String steamId = ConfigPropertyAPI.getInstance().getValueByKey("SteamId");
            System.out.println(steamId);
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            String appId = new JSONObject(requestBody).getString("appId");
            System.out.println("appId: " + appId);
            // 初始遊玩資料
            String firstAch = SteamUtils.getAchievement(steamId, appId);
            String firstStats = SteamUtils.getUserStatsForGame(steamId, appId);

            System.out.println("firstAch： " + firstAch);
            System.out.println("firstStats： " + firstStats);
            // 解析成就和統計資料
            List<Achievement> starAchievements = SteamUtils.parseJsonToAchievementList(firstAch);
            List<StatsData> starStatsDatas = SteamUtils.parseStats(firstStats);

            Long startTime = new Date().getTime();
            responseJson.put("startTime", startTime);
            boolean wasPlaying = false;
            while (true) {
                Optional<String> summaryOpt = SteamUtils.getPlayerSummary(steamId);
                if (summaryOpt.isEmpty()) {
                // 取得失敗 => 等久一點再試，或計數後放棄
                Thread.sleep(15000);
                continue;
}
                boolean isPlaying = SteamUtils.checkIfUserIsPlaying(summaryOpt.get());
                if (wasPlaying && !isPlaying) {
                    String endAch = SteamUtils.getAchievement(steamId, appId);
                    String endStats = SteamUtils.getUserStatsForGame(steamId, appId);
                    List<Achievement> endAchievements = SteamUtils.parseJsonToAchievementList(endAch);
                    List<StatsData> endStatsDatas = SteamUtils.parseStats(endStats);

                    List<Achievement> unlockedAchievements = SteamUtils.compareAchievements(starAchievements, endAchievements);
                    List<StatsData> statsDiff = SteamUtils.compareStats(starStatsDatas, endStatsDatas);

                    responseJson.put("unlockedAchievements", unlockedAchievements);
                    responseJson.put("currentAchievements", endAchievements);
                    responseJson.put("stats", statsDiff);
                    Long endTime = new Date().getTime();
                    responseJson.put("endTime", endTime);
                    break;
                }
                wasPlaying = isPlaying;
                System.out.println("User is playing: " + isPlaying);
                try {
                    Thread.sleep(7000); // 每秒檢查一次
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
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

    @RESTfulAPIDefine(url = "monitorTest", methods = "post", description = "監控測試")
    private String monitorTest(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        responseJson.put("startTime", new Date().getTime());
        String firstAch = "{\"playerstats\":{\"achievements\":[{\"achieved\":1,\"apiname\":\"ACH.SURVIVE_CONTAINER_RIDE\",\"unlocktime\":1387547763},{\"achieved\":1,\"apiname\":\"ACH.WAKE_UP\",\"unlocktime\":1387550063},{\"achieved\":1,\"apiname\":\"ACH.LASER\",\"unlocktime\":1390448067},{\"achieved\":0,\"apiname\":\"ACH.BRIDGE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.BREAK_OUT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.STALEMATE_ASSOCIATE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.ADDICTED_TO_SPUDS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.BLUE_GEL\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.ORANGE_GEL\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.WHITE_GEL\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.TRACTOR_BEAM\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.TRIVIAL_TEST\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.WHEATLEY_TRIES_TO\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.SHOOT_THE_MOON\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.BOX_HOLE_IN_ONE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.SPEED_RUN_LEVEL\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.COMPLIANT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.SAVE_CUBE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.LAUNCH_TURRET\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.CLEAN_UP\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.REENTER_TEST_CHAMBERS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.NOT_THE_DROID\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.SAVE_REDEMPTION_TURRET\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.CATCH_CRAZY_BOX\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.NO_BOAT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.A3_DOORS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.PORTRAIT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.DEFIANT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.BREAK_MONITORS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.HI_FIVE_YOUR_PARTNER\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.TEAM_BUILDING\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.MASS_AND_VELOCITY\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.HUG_NAME\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.EXCURSION_FUNNELS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.NEW_BLOOD\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.NICE_CATCH\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.TAUNTS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.YOU_MONSTER\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.PARTNER_DROP\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.PARTY_OF_THREE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.PORTAL_TAUNT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.TEACHER\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.WITH_STYLE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.LIMITED_PORTALS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.FOUR_PORTALS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.SPEED_RUN_COOP\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.STAYING_ALIVE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.TAUNT_CAMERA\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.ROCK_CRUSHES_ROBOT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.SPREAD_THE_LOVE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.SUMMER_SALE\",\"unlocktime\":0}],\"gameName\":\"Portal 2\",\"steamID\":\"76561198057493703\",\"success\":true}}";
        System.out.println("firstAch： " + firstAch);
        List<Achievement> startAchievements = SteamUtils.parseJsonToAchievementList(firstAch);

        String endAch = "{\"playerstats\":{\"achievements\":[{\"achieved\":1,\"apiname\":\"ACH.SURVIVE_CONTAINER_RIDE\",\"unlocktime\":1387547763},{\"achieved\":1,\"apiname\":\"ACH.WAKE_UP\",\"unlocktime\":1387550063},{\"achieved\":1,\"apiname\":\"ACH.LASER\",\"unlocktime\":1390448067},{\"achieved\":0,\"apiname\":\"ACH.BRIDGE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.BREAK_OUT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.STALEMATE_ASSOCIATE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.ADDICTED_TO_SPUDS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.BLUE_GEL\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.ORANGE_GEL\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.WHITE_GEL\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.TRACTOR_BEAM\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.TRIVIAL_TEST\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.WHEATLEY_TRIES_TO\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.SHOOT_THE_MOON\",\"unlocktime\":0},{\"achieved\":1,\"apiname\":\"ACH.BOX_HOLE_IN_ONE\",\"unlocktime\":1390449077},{\"achieved\":0,\"apiname\":\"ACH.SPEED_RUN_LEVEL\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.COMPLIANT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.SAVE_CUBE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.LAUNCH_TURRET\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.CLEAN_UP\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.REENTER_TEST_CHAMBERS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.NOT_THE_DROID\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.SAVE_REDEMPTION_TURRET\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.CATCH_CRAZY_BOX\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.NO_BOAT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.A3_DOORS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.PORTRAIT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.DEFIANT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.BREAK_MONITORS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.HI_FIVE_YOUR_PARTNER\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.TEAM_BUILDING\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.MASS_AND_VELOCITY\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.HUG_NAME\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.EXCURSION_FUNNELS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.NEW_BLOOD\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.NICE_CATCH\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.TAUNTS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.YOU_MONSTER\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.PARTNER_DROP\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.PARTY_OF_THREE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.PORTAL_TAUNT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.TEACHER\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.WITH_STYLE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.LIMITED_PORTALS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.FOUR_PORTALS\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.SPEED_RUN_COOP\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.STAYING_ALIVE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.TAUNT_CAMERA\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.ROCK_CRUSHES_ROBOT\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.SPREAD_THE_LOVE\",\"unlocktime\":0},{\"achieved\":0,\"apiname\":\"ACH.SUMMER_SALE\",\"unlocktime\":0}],\"gameName\":\"Portal 2\",\"steamID\":\"76561198057493703\",\"success\":true}}";
        System.out.println("endAch： " + endAch);
        List<Achievement> endAchievements = SteamUtils.parseJsonToAchievementList(endAch);

        List<Achievement> unlockedAch = SteamUtils.compareAchievements(startAchievements, endAchievements);

        responseJson.put("unlockedAchievements", unlockedAch);
//		result.put("currentAchievements", endAchievements);

        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        // 模擬之前的 stats 資料
        String oldJsonString = "{ \"playerstats\": { \"stats\": [ { \"name\": \"SP.progress\", \"value\": 2 }, { \"name\": \"GI.lesson.version_number\", \"value\": 15 }, { \"name\": \"GI.lesson.create_left_portal\", \"value\": 16 }, { \"name\": \"GI.lesson.create_right_portal\", \"value\": 15 } ] } }";

        // 新的 JSON 字串
        String newJsonString = "{ \"playerstats\": { \"stats\": [ { \"name\": \"SP.progress\", \"value\": 3 }, { \"name\": \"GI.lesson.version_number\", \"value\": 16 }, { \"name\": \"GI.lesson.create_left_portal\", \"value\": 16 }, { \"name\": \"GI.lesson.create_right_portal\", \"value\": 16 } , { \"name\": \"GI.lesson.create_center_portal\", \"value\": 16 } ] } }";

        // 解析舊的 stats
        List<StatsData> oldStatsMap = SteamUtils.parseStats(oldJsonString);

        // 解析新的 stats
        List<StatsData> newStatsMap = SteamUtils.parseStats(newJsonString);

        // 比較 stats
        List<StatsData> statsResult = SteamUtils.compareStats(oldStatsMap, newStatsMap);
        responseJson.put("stats", statsResult);
        responseJson.put("success", Boolean.TRUE);
        responseJson.put("endTime", new Date().getTime());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }

    @RESTfulAPIDefine(url = "monitorTest2", methods = "post", description = "監控測試")
    private String monitorTest2(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        // 這裡可以加入監控測試的邏輯
        responseJson.put("message", "監控測試成功");
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return responseJson.toString();
    }


    /* ---------- 輔助函式 ---------- */
    private Integer parseNullableInt(String s) {
        if (s == null || s.isBlank()) {
            return null;
        }
        return Integer.valueOf(s);   // 會自動 unbox 成 int 或用 Integer 視欄位型別而定
    }
}
