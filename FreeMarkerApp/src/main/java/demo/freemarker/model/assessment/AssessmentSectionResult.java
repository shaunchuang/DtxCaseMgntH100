package demo.freemarker.model.assessment;

import itri.sstc.framework.core.database.IntIdDataEntity;
import java.io.Serializable;
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
@Table(name = "\"assessment_section_result\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AssessmentSectionResult.findByAssessmentId", query = "SELECT a FROM AssessmentSectionResult a WHERE a.assessmentId = :assessmentId"),
})
public class AssessmentSectionResult implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 123874651290L;

    @Id
    @Column(name = "\"id\"", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "\"assessment_id\"")
    private Long assessmentId;

    @Column(name = "\"section_id\"")
    private Long sectionId;

    @Column(name = "\"section_name\"",nullable = false, length=50)
    private String sectionName;

    @Column(name = "\"evaluationType\"",nullable = true, length=50)
    private String evaluationType;

    @Column(name = "\"scale_level_id\"", nullable = true)
    private String scaleLevelId;

    @Column(name = "\"total_score\"", unique = false, nullable = false)
    private Integer totalScore = 0;

    @Column(name = "\"descResult\"", nullable = true, length=50)
    private String descResult;

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

    public Long getSectionId() {
        return sectionId;
    }

    public void setSectionId(Long sectionId) {
        this.sectionId = sectionId;
    }

    public String getSectionName() {
        return sectionName;
    }

    public void setSectionName(String sectionName) {
        this.sectionName = sectionName;
    }

    public String getEvaluationType() {
        return evaluationType;
    }

    public void setEvaluationType(String evaluationType) {
        this.evaluationType = evaluationType;
    }

    public String getScaleLevelId() {
        return scaleLevelId;
    }

    public void setScaleLevelId(String scaleLevelId) {
        this.scaleLevelId = scaleLevelId;
    }

    public Integer getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Integer totalScore) {
        this.totalScore = totalScore;
    }

    public String getDescResult() {
        return descResult;
    }

    public void setDescResult(String descResult) {
        this.descResult = descResult;
    }

    
}