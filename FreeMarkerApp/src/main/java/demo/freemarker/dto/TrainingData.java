package demo.freemarker.dto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;

public class TrainingData {

    Long startTime;
    Long endTime;
    Long period;
    List<Achievement> achievement;
    List<StatsData> statsData;

    public List<Achievement> getAchievement() {
        return achievement;
    }

    public void setAchievement(List<Achievement> achievement) {
        this.achievement = achievement;
    }

    public List<StatsData> getStatsData() {
        return statsData;
    }

    public void setStatsData(List<StatsData> statsData) {
        this.statsData = statsData;
    }

    public Long getStartTime() {
        return startTime;
    }

    public void setStartTime(Long startTime) {
        this.startTime = startTime;
    }

    public Long getEndTime() {
        return endTime;
    }

    public void setEndTime(Long endTime) {
        this.endTime = endTime;
    }

    public Long getPeriod() {
        return period;
    }

    public void setPeriod(Long period) {
        this.period = period;
    }

    @Override
    public String toString() {
        Map<String, Object> map = new HashMap<>();
        map.put("startTime", startTime);
        map.put("endTime", endTime);
        map.put("period", period);
        map.put("achievement", achievement);
        map.put("stats", statsData);
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(map);
        } catch (Exception e) {
            e.printStackTrace();
            return "{}";
        }
    }
}