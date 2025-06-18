package demo.freemarker.model.training;

import itri.sstc.framework.core.database.IntIdDataEntity;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "\"training_plan\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TrainingPlan.findAll", query = "SELECT m FROM TrainingPlan m "),
    @NamedQuery(name = "TrainingPlan.findByPatientId", query = "SELECT m FROM TrainingPlan m WHERE m.patientId = :patientId")
})
public class TrainingPlan implements IntIdDataEntity, Serializable {
    
    private static final long serialVersionUID = -6385265004137515063L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "\"therapist_id\"", nullable = false)
    private Long therapist;

    @Column(name = "\"patient_id\"", nullable = false)
    private Long patientId;

    @Column(name = "\"title\"", nullable = true, length = 200)
    private String title;

    @Column(name = "\"start_date\"", nullable = false)
    private Date startDate;

    @Column(name = "\"end_date\"", nullable = false)
    private Date endDate;

    @Column(name = "\"frequency_per_week\"")
    private Integer frequencyPerWeek;

    @Column(name = "\"frequency_per_day\"")
    private Integer frequencyPerDay;

    @Column(name = "\"duration_per_session\"")
    private Integer durationPerSession;

    @Column(name = "\"notes\"")
    private String notes;

    @Column(name = "\"create_time\"")
    private Date createTime;

    /**
     * 訓練的星期，格式為 JSON array 字串，例如 ['1','2'] 代表星期一、二。
     */
    @Column(name = "training_week_day")
    private String trainingWeekDay;

    /**
     *  訓練的時間
     */
    @Column(name = "\"training_time\"")
    private String trainingTime;

    /*
     * 訓練日期
     */
    @Column(name = "\"scheduled_date\"")
    private Date scheduledDate;

    public TrainingPlan() {

    }
    
    @Override
    public Long getId() {
        return id;
    }
    
    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getTherapist() {
        return therapist;
    }

    public void setTherapist(Long therapist) {
        this.therapist = therapist;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
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

    public String getTrainingWeekDay() {
        return trainingWeekDay;
    }

    public void setTrainingWeekDay(String trainingWeekDay) {
        this.trainingWeekDay = trainingWeekDay;
    }

    public String getTrainingTime() {
        return trainingTime;
    }

    public void setTrainingTime(String trainingTime) {
        this.trainingTime = trainingTime;
    }

    public Date getScheduledDate() {
        return scheduledDate;
    }

    public void setScheduledDate(Date scheduledDate) {
        this.scheduledDate = scheduledDate;
    }
    
}
