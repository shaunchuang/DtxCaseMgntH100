package demo.freemarker.dto;

import java.util.List;

public class TodayReviewInfo{
    private Integer waitCheckinNum = 0;
    private Integer trainingUpdateCaseNum = 0;
    private Integer abnormalCaseNum = 0;
    private List<CaseAppoEvent> appoEvents;
    private List<TrainingEvent> trainingEvents;

    public Integer getWaitCheckinNum() {
        return waitCheckinNum;
    }

    public void setWaitCheckinNum(Integer waitCheckinNum) {
        this.waitCheckinNum = waitCheckinNum;
    }

    public Integer getTrainingUpdateCaseNum() {
        return trainingUpdateCaseNum;
    }

    public void setTrainingUpdateCaseNum(Integer trainingUpdateCaseNum) {
        this.trainingUpdateCaseNum = trainingUpdateCaseNum;
    }

    public Integer getAbnormalCaseNum() {
        return abnormalCaseNum;
    }

    public void setAbnormalCaseNum(Integer abnormalCaseNum) {
        this.abnormalCaseNum = abnormalCaseNum;
    }

    public List<CaseAppoEvent> getAppoEvents() {
        return appoEvents;
    }

    public void setAppoEvents(List<CaseAppoEvent> appoEvents) {
        this.appoEvents = appoEvents;
    }

    public List<TrainingEvent> getTrainingEvents() {
        return trainingEvents;
    }

    public void setTrainingEvents(List<TrainingEvent> trainingEvents) {
        this.trainingEvents = trainingEvents;
    }
    

}