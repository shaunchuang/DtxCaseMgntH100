package demo.freemarker.dto;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;

public class StatsData {
    String apiName;
    String statsValue;

    public String getApiName() {
        return apiName;
    }

    public void setApiName(String apiName) {
        this.apiName = apiName;
    }

    public String getStatsValue() {
        return statsValue;
    }

    public void setStatsValue(String statsValue) {
        this.statsValue = statsValue;
    }

    @Override
    public String toString() {
        Map<String, Object> map = new HashMap<>();
        map.put("apiName", apiName);
        map.put("statsValue", statsValue);
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(map);
        } catch (Exception e) {
            e.printStackTrace();
            return "{}";
        }
    }
}
