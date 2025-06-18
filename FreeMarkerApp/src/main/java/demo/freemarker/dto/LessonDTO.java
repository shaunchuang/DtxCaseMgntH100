package demo.freemarker.dto;

import java.util.List;

public class LessonDTO {
    private Long lessonId;
    private List<AchievementDTO> achievements;
    private List<StatisticsDTO> statistics;
    
    public Long getLessonId() {
        return lessonId;
    }
    public void setLessonId(Long lessonId) {
        this.lessonId = lessonId;
    }
    public List<AchievementDTO> getAchievements() {
        return achievements;
    }
    public void setAchievements(List<AchievementDTO> achievements) {
        this.achievements = achievements;
    }
    public List<StatisticsDTO> getStatistics() {
        return statistics;
    }
    public void setStatistics(List<StatisticsDTO> statistics) {
        this.statistics = statistics;
    }
    
}
