package demo.freemarker.dto;

public class StatisticsDTO {
    private Long statisticsId;
    private String apiName;
    private String valueGoal;
    
    public Long getStatisticsId() {
        return statisticsId;
    }
    public void setStatisticsId(Long statisticsId) {
        this.statisticsId = statisticsId;
    }
    public String getApiName() {
        return apiName;
    }
    public void setApiName(String apiName) {
        this.apiName = apiName;
    }
    public String getValueGoal() {
        return valueGoal;
    }
    public void setValueGoal(String valueGoal) {
        this.valueGoal = valueGoal;
    }
}
