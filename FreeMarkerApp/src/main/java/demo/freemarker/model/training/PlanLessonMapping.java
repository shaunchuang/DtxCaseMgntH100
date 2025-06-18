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
@Table(name = "\"plan_lesson_mapping\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PlanLessonMapping.findByPlanId", query = "SELECT p FROM PlanLessonMapping p WHERE p.planId = :planId"),
    @NamedQuery(name = "PlanLessonMapping.findLessonIdsByPlanId", query = "SELECT p.lessonId FROM PlanLessonMapping p WHERE p.planId = :planId"),
    @NamedQuery(name = "PlanLessonMapping.findPlanLessonMappingByLessonIdAndPlanId", query = "SELECT p FROM PlanLessonMapping p WHERE p.lessonId = :lessonId AND p.planId = :planId Order By p.orderIndex ASC"),
})
public class PlanLessonMapping implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "\"plan_id\"", nullable = false)
    private Long planId;

    @Column(name = "\"lesson_id\"", nullable = false)
    private Long lessonId;

    @Column(name = "\"order_index\"")  // order index of the lesson in the plan
    private Integer orderIndex;
    
    @Column(name = "\"status\"", length = 20)
    private String status;

    @Column(name = "\"create_time\"")
    private Date createTime;

    public PlanLessonMapping() {

    }

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getPlanId() {
        return planId;
    }

    public void setPlanId(Long planId) {
        this.planId = planId;
    }

    public Long getLessonId() {
        return lessonId;
    }

    public void setLessonId(Long lessonId) {
        this.lessonId = lessonId;
    }

    public Integer getOrderIndex() {
        return orderIndex;
    }

    public void setOrderIndex(Integer orderIndex) {
        this.orderIndex = orderIndex;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
