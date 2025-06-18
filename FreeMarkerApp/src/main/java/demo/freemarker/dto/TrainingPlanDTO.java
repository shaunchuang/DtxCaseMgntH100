package demo.freemarker.dto;

import java.util.Date;
import java.util.List;

public class TrainingPlanDTO {
    private Long planId;
    private Long therapistId; 
    private String therapistName; 
    private String patientId;
    private String patientName;
    private String title;
    private Date startDate;
    private Date endDate;
    private Integer frequencyPerWeek;
    private Integer frequencyPerDay;
    private Integer durationPerSession;
    private String notes;
    private Date createTime;
    private List<LessonDTO> lessons;
    public Long getPlanId() {
        return planId;
    }
    public void setPlanId(Long planId) {
        this.planId = planId;
    }
    public Long getTherapistId() {
        return therapistId;
    }
    public void setTherapistId(Long therapistId) {
        this.therapistId = therapistId;
    }
    public String getTherapistName() {
        return therapistName;
    }
    public void setTherapistName(String therapistName) {
        this.therapistName = therapistName;
    }
    public String getPatientId() {
        return patientId;
    }
    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }
    public String getPatientName() {
        return patientName;
    }
    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public Date getStartDate() {
        return startDate;
    }
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    public Date getEndDate() {
        return endDate;
    }
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    public Integer getFrequencyPerWeek() {
        return frequencyPerWeek;
    }
    public void setFrequencyPerWeek(Integer frequencyPerWeek) {
        this.frequencyPerWeek = frequencyPerWeek;
    }
    public Integer getFrequencyPerDay() {
        return frequencyPerDay;
    }
    public void setFrequencyPerDay(Integer frequencyPerDay) {
        this.frequencyPerDay = frequencyPerDay;
    }
    public Integer getDurationPerSession() {
        return durationPerSession;
    }
    public void setDurationPerSession(Integer durationPerSession) {
        this.durationPerSession = durationPerSession;
    }
    public String getNotes() {
        return notes;
    }
    public void setNotes(String notes) {
        this.notes = notes;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public List<LessonDTO> getLessons() {
        return lessons;
    }
    public void setLessons(List<LessonDTO> lessons) {
        this.lessons = lessons;
    }

    
}
