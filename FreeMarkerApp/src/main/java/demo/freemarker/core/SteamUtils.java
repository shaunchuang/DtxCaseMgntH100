package demo.freemarker.core;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import demo.freemarker.api.ConfigPropertyAPI;
import demo.freemarker.dto.Achievement;
import demo.freemarker.dto.StatsData;
import java.util.Optional;

public class SteamUtils {

    public static String getAchievement(String steamID, String AppId) {
        try {
            String apiKey = ConfigPropertyAPI.getInstance().getValueByKey("SteamAPIKey");
            String requestURL = String.format(
                    "http://api.steampowered.com/ISteamUserStats/GetPlayerAchievements/v1/?appid=%s&key=%s&steamid=%s&format=json",
                    AppId, apiKey, steamID);
            HashMap<String, String> params = new HashMap<>();
                                params.put("User-Agent",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) " +
            "AppleWebKit/537.36 (KHTML, like Gecko) " +
            "Chrome/125.0.0.0 Safari/537.36");
            params.put("Accept", "application/json");
            params.put("Accept", "application/json");
            String response = HttpClientUtil.sendGetRequest(requestURL, params);
            System.out.println("get Achievement response: " + response);
            return response;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String getUserStatsForGame(String steamID, String AppId) {
        try {
            String apiKey = ConfigPropertyAPI.getInstance().getValueByKey("SteamAPIKey");
            String requestURL = String.format(
                    "http://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v2/?appid=%s&key=%s&steamid=%s&format=json",
                    AppId, apiKey, steamID);
            HashMap<String, String> params = new HashMap<>();
                    params.put("User-Agent",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) " +
            "AppleWebKit/537.36 (KHTML, like Gecko) " +
            "Chrome/125.0.0.0 Safari/537.36");
            params.put("Accept", "application/json");
            String response = HttpClientUtil.sendGetRequest(requestURL, params);
            return response;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Optional<String> getPlayerSummary(String steamID) {
        try {
            String apiKey = ConfigPropertyAPI.getInstance().getValueByKey("SteamAPIKey");

            String requestURL = String.format(
                    "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key=%s&steamids=%s&format=json", apiKey,
                    steamID);
                    Map<String, String> headers = new HashMap<>();
        headers.put("User-Agent",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) " +
            "AppleWebKit/537.36 (KHTML, like Gecko) " +
            "Chrome/125.0.0.0 Safari/537.36");
        headers.put("Accept", "application/json");
        headers.put("Accept-Language", "en-US,en;q=0.9");
        headers.put("Accept-Charset", "utf-8");
        headers.put("Accept-Encoding", "gzip, deflate, br"); // 支援壓縮
        headers.put("Connection", "keep-alive");
        headers.put("Cache-Control", "no-cache");
        headers.put("Pragma", "no-cache");
        headers.put("Referer", "https://steamcommunity.com/");
            headers.put("User-Agent", "Mozilla/5.0");
            headers.put("Accept", "application/json");
            return Optional.of( HttpClientUtil.sendGetRequest(requestURL, headers));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public static HashMap<String, Achievement> parseAchievements(String json) {
        try {
            HashMap<String, Achievement> achievements = new HashMap<>();
            JSONObject jsonObj = new JSONObject(json);
            JSONObject achObj = jsonObj.getJSONObject("playerstats");
            JSONArray achArray = achObj.getJSONArray("achievements");

            for (int i = 0; i < achArray.length(); i++) {
                JSONObject ach = achArray.getJSONObject(i);
                String apiName = ach.getString("apiname");
                int achieved = ach.getInt("achieved");
                long unlockTime = ach.getLong("unlocktime");
                achievements.put(apiName, new Achievement(apiName, achieved, unlockTime));
            }
            return achievements;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<Achievement> parseJsonToAchievementList(String jsonString) {
        List<Achievement> achievements = new ArrayList<>();

        JSONObject jsonObject;
        try {
            jsonObject = new JSONObject(jsonString);
            JSONObject playerStats = jsonObject.getJSONObject("playerstats");
            JSONArray achievementsArray = playerStats.getJSONArray("achievements");
            for (int i = 0; i < achievementsArray.length(); i++) {
                JSONObject achievementJson = achievementsArray.getJSONObject(i);

                String apiname = achievementJson.getString("apiname");
                int achieved = achievementJson.getInt("achieved");
                long unlocktime = achievementJson.getLong("unlocktime");
                Achievement achievement = new Achievement(apiname, achieved, unlocktime);
                achievements.add(achievement);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return achievements;
    }

    /**
     * 解析 JSON 字串並回傳 StatsData 清單
     *
     * @param json 從 API 取得的原始 JSON
     * @return List<StatsData>；若解析失敗則回傳空 List
     */
    public static List<StatsData> parseStats(String json) {
        List<StatsData> result = new ArrayList<>();
        try {
            JSONObject jsonObj = new JSONObject(json);
            JSONObject playerStats = jsonObj.getJSONObject("playerstats");

            if (playerStats.has("stats")) {
                JSONArray statsArray = playerStats.getJSONArray("stats");
                for (int i = 0; i < statsArray.length(); i++) {
                    JSONObject stat = statsArray.getJSONObject(i);
                    String name = stat.getString("name");      // API 名稱
                    double value = stat.getDouble("value");    // 數值

                    StatsData data = new StatsData();
                    data.setApiName(name);
                    data.setStatsValue(String.valueOf(value)); // 轉成字串存入

                    result.add(data);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 若有例外，這裡可以視需求改成回傳 null 或直接丟出自訂例外
        }
        return result;
    }

    public static List<Achievement> compareAchievements(List<Achievement> oldList, List<Achievement> newList) {
        List<Achievement> unlockedAchievements = new ArrayList<>();

        for (Achievement newAch : newList) {
            if (newAch.getAchieved() == 1) {
                boolean found = false;
                for (Achievement oldAch : oldList) {
                    if (newAch.getApiname().equals(oldAch.getApiname())) {
                        if (oldAch.getAchieved() == 0 && newAch.getAchieved() == 1) {
                            unlockedAchievements.add(newAch);
                        }
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    unlockedAchievements.add(newAch); // 新增的成就
                }
            }
        }

        return unlockedAchievements;
    }

    /**
     * 比較兩組 StatsData，回傳「只含差異值」的清單
     *
     * @param start 起始 List<StatsData>
     * @param end 結束 List<StatsData>
     * @return List<StatsData> 只包含差異 (end - start) ≠ 0 的項目
     */
    public static List<StatsData> compareStats(List<StatsData> start, List<StatsData> end) {

        // 1. 將起始資料轉成 Map 方便查詢
        Map<String, Double> startMap = new HashMap<>();
        for (StatsData s : start) {
            // 轉 double；若 statsValue 可能為 null / 空字串，需先行判斷
            double val = parseDoubleSafe(s.getStatsValue());
            startMap.put(s.getApiName(), val);
        }

        // 2. 計算差異，將非零差放入結果
        List<StatsData> changedList = new ArrayList<>();
        for (StatsData e : end) {
            double endVal = parseDoubleSafe(e.getStatsValue());
            double startVal = startMap.getOrDefault(e.getApiName(), 0.0);
            double diff = endVal - startVal;

            if (diff != 0) {
                StatsData diffData = new StatsData();
                diffData.setApiName(e.getApiName());
                diffData.setStatsValue(String.valueOf(diff));
                changedList.add(diffData);
            }
        }
        return changedList;
    }

    /**
     * 安全轉型：將字串轉 double，失敗時回傳 0
     */
    private static double parseDoubleSafe(String str) {
        try {
            return str == null || str.isBlank() ? 0.0 : Double.parseDouble(str);
        } catch (NumberFormatException ex) {
            return 0.0;
        }
    }

    public static int getPlaytime(String steamID, String AppId) {
        String apiKey = ConfigPropertyAPI.getInstance().getValueByKey("SteamAPIKey");
        String requestURL = String.format(
                "http://api.steampowered.com/IPlayerService/GetOwnedGames/v1/?key=%s&steamid=%s&format=json", apiKey,
                steamID);
        try {
            HashMap<String, String> params = new HashMap<>();
                                params.put("User-Agent",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) " +
            "AppleWebKit/537.36 (KHTML, like Gecko) " +
            "Chrome/125.0.0.0 Safari/537.36");
            params.put("Accept", "application/json");
            params.put("Accept", "application/json");
            String response = HttpClientUtil.sendGetRequest(requestURL, params);
            JSONObject obj = new JSONObject(response);
            JSONArray games = obj.getJSONObject("response").getJSONArray("games");
            for (int i = 0; i < games.length(); i++) {
                JSONObject game = games.getJSONObject(i);
                if (game.getInt("appid") == Integer.parseInt(AppId)) {
                    return game.getInt("playtime_forever");
                }
            }
            return 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static boolean checkIfUserIsPlaying(String jsonResponse) {
        try {

            JSONObject obj = new JSONObject(jsonResponse);
            JSONObject response = obj.getJSONObject("response");
            JSONArray players = response.getJSONArray("players");

            if (players != null && players.length() > 0) {
                JSONObject player = ((JSONArray) players).getJSONObject(0);
                // 檢查是否包含gameid或gameextrainfo字段，這表明用戶正在遊戲中
                return player.has("gameid") || player.has("gameextrainfo");
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return false;
    }
}
