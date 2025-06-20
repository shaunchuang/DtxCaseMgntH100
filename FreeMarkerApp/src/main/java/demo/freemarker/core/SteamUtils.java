package demo.freemarker.core;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.sun.net.httpserver.Headers;
import demo.freemarker.api.ConfigPropertyAPI;
import demo.freemarker.dto.Achievement;

public class SteamUtils {

    public static String getAchievement(String steamID, String AppId) {
        try {
            String apiKey = ConfigPropertyAPI.getInstance().getValueByKey("SteamAPIKey");
            String requestURL = String.format(
                    "http://api.steampowered.com/ISteamUserStats/GetPlayerAchievements/v1/?appid=%s&key=%s&steamid=%s&format=json",
                    AppId, apiKey, steamID);
            HashMap<String, String> params = new HashMap<>();
            params.put("User-Agent", "Mozilla/5.0");
            params.put("Accept", "application/json");
            String response = HttpClientUtil.sendGetRequest(requestURL, params);
            System.out.println("get Achievement response: " + response);
            return response;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public HashMap<String, Achievement> parseAchievements(String json) {
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

    public static HashMap<String, Double> parseStats(String json) {
        try {
            HashMap<String, Double> stats = new HashMap<>();
            JSONObject jsonObj = new JSONObject(json);
            JSONObject playerStats = jsonObj.getJSONObject("playerstats");

            if (playerStats.has("stats")) {
                JSONArray statsArray = playerStats.getJSONArray("stats");
                for (int i = 0; i < statsArray.length(); i++) {
                    JSONObject stat = statsArray.getJSONObject(i);
                    String name = stat.getString("name");
                    double value = stat.getDouble("value");
                    stats.put(name, value);
                }
            }
            return stats;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Achievement> compareAchievements(List<Achievement> oldList, List<Achievement> newList) {
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
}
