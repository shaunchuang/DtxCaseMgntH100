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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "\"training_record\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TrainingRecord.findByPlanLessonId", query = "SELECT t FROM TrainingRecord t WHERE t.planLessonId = :planLessonId")
})
public class TrainingRecord implements IntIdDataEntity, Serializable {
    private static final long serialVersionUID = 1822843074598309L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "\"planLesson_id\"", nullable = false)
    private Long planLessonId;

    @Column(name = "\"start_time\"")
    private Date startTime;

    @Column(name = "\"end_time\"")
    private Date endTime;

    @Column(name = "\"duration\"")
    private Integer duration;

    @Column(name = "\"created_at\"")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getPlanLessonId() {
        return planLessonId;
    }

    public void setPlanLessonId(Long planLessonId) {
        this.planLessonId = planLessonId;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

}
