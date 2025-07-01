package demo.freemarker.dto;

public class TrainingTrack {
    private Long planId;
    private String trainingDate;
    private String trainingTimes;
    private String description;
    private String status; // 正常/異常
    
    public TrainingTrack() {
    }
    
    public TrainingTrack(Long planId, String trainingDate, String trainingTimes, String description) {
        this.planId = planId;
        this.trainingDate = trainingDate;
        this.trainingTimes = trainingTimes;
        this.description = description;
        this.status = "正常";
    }

    public Long getPlanId() {
        return planId;
    }

    public void setPlanId(Long planId) {
        this.planId = planId;
    }

    public String getTrainingDate() {
        return trainingDate;
    }

    public void setTrainingDate(String trainingDate) {
        this.trainingDate = trainingDate;
    }

    public String getTrainingTimes() {
        return trainingTimes;
    }

    public void setTrainingTimes(String trainingTimes) {
        this.trainingTimes = trainingTimes;
    }
    
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}