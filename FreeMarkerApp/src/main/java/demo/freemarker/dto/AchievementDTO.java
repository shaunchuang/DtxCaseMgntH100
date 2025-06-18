package demo.freemarker.dto;

public class AchievementDTO {
    private Long achievementId;
    private String apiName;
    
    public Long getAchievementId() {
        return achievementId;
    }
    public void setAchievementId(Long achievementId) {
        this.achievementId = achievementId;
    }
    public String getApiName() {
        return apiName;
    }
    public void setApiName(String apiName) {
        this.apiName = apiName;
    }
}
