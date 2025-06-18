package demo.freemarker.model.assessment;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

import itri.sstc.framework.core.database.IntIdDataEntity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

@Entity
@Table(name = "\"assessment_result\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AssessmentResult.findByAssessmentId", query = "SELECT a FROM AssessmentResult a WHERE a.assessmentId = :assessmentId"),
    @NamedQuery(name = "AssessmentResult.findByAssIdItemIdOpId", query = "SELECT a FROM AssessmentResult a WHERE a.assessmentId = :assessmentId AND a.scaleItemId = :scaleItemId AND a.scaleItemOptionId = :scaleItemOptionId ORDER BY a.id ASC"),
    @NamedQuery(name = "AssessmentResult.findByAssIdItemId", query = "SELECT a FROM AssessmentResult a WHERE a.assessmentId = :assessmentId AND a.scaleItemId = :scaleItemId ORDER BY a.id ASC")
})
public class AssessmentResult implements IntIdDataEntity, Serializable {
    
    private static final long serialVersionUID = 774174123L;

    @Id
    @Column(name = "\"id\"", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "\"assessment_id\"", nullable = false)
    private Long assessmentId;

    @Column(name = "\"createTime\"")
    private Date createTime;

    @Column(name = "\"scale_scection_id\"", nullable = true)
    private Long scaleSectionId;

    @Column(name = "\"scale_item_id\"", nullable = false)
    private Long scaleItemId;
    
    @Column(name = "\"scale_item_option_id\"", nullable = true)
    private Long scaleItemOptionId;

    @Column(name = "\"score\"", unique = false, nullable = false)
    private Integer score;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getAssessmentId() {
        return assessmentId;
    }

    public void setAssessmentId(Long assessmentId) {
        this.assessmentId = assessmentId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Long getScaleSectionId() {
        return scaleSectionId;
    }

    public void setScaleSectionId(Long scaleSectionId) {
        this.scaleSectionId = scaleSectionId;
    }

    public Long getScaleItemId() {
        return scaleItemId;
    }

    public void setScaleItemId(Long scaleItemId) {
        this.scaleItemId = scaleItemId;
    }

    public Long getScaleItemOptionId() {
        return scaleItemOptionId;
    }

    public void setScaleItemOptionId(Long scaleItemOptionId) {
        this.scaleItemOptionId = scaleItemOptionId;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    
}
