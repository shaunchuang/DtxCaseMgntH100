/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.model.assessment;

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

/**
 *
 * @author zhush
 */
@Entity
@Table(name = "\"assessment\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Assessment.findByTherapistId", query = "SELECT a FROM Assessment a WHERE a.therapistId = :therapistId ORDER BY a.id ASC"),
    @NamedQuery(name = "Assessment.findByPatientId", query = "SELECT a FROM Assessment a WHERE a.patientId = :patientId"),
    @NamedQuery(name = "Assessment.findByScaleId", query = "SELECT a FROM Assessment a WHERE a.scaleId = :scaleId"),
    @NamedQuery(name = "Assessment.findByIdAndPatientIdAndTherapistId", query = "SELECT a FROM Assessment a WHERE a.id = :id AND a.patientId = :patientId AND a.therapistId = :therapistId"),
    @NamedQuery(name = "Assessment.findByIdAndPatientId", query = "SELECT a FROM Assessment a WHERE a.id = :id AND a.patientId = :patientId"),
    @NamedQuery(name = "Assessment.findByPatientIdAndScaleId", query = "SELECT a FROM Assessment a WHERE a.patientId = :patientId AND a.scaleId = :scaleId"),
    @NamedQuery(name = "Assessment.findByPatientIdAndScaleIdAndStatus", query = "SELECT a FROM Assessment a WHERE a.patientId = :patientId AND a.scaleId = :scaleId AND a.status = :status"),
    @NamedQuery(name = "Assessment.findByPatientIdParamAndEndDate", query = "SELECT a FROM Assessment a JOIN Scale s ON a.scaleId = s.id WHERE a.patientId = :patientId AND s.name LIKE :param AND a.assessmentDate <= :assessmentDate ORDER BY a.assessmentDate DESC"),
    @NamedQuery(name = "Assessment.findByPatientIdParamAndStartEndDate", query = "SELECT a FROM Assessment a JOIN Scale s ON a.scaleId = s.id WHERE a.patientId = :patientId AND s.name LIKE :param AND a.assessmentDate BETWEEN :startDate AND :endDate ORDER BY a.assessmentDate DESC"),
    @NamedQuery(name = "Assessment.findBypatientIdTherapistIdParamAndEndDate", query = "SELECT a FROM Assessment a JOIN Scale s ON a.scaleId = s.id WHERE a.patientId = :patientId AND a.therapistId = :therapistId AND s.name LIKE :param AND a.assessmentDate <= :assessmentDate ORDER BY a.assessmentDate DESC"),
    @NamedQuery(name = "Assessment.findBypatientIdTherapistIdParamAndStartEndDate", query = "SELECT a FROM Assessment a JOIN Scale s ON a.scaleId = s.id WHERE a.patientId = :patientId AND a.therapistId = :therapistId AND s.name LIKE :param AND a.assessmentDate BETWEEN :startDate AND :endDate ORDER BY a.assessmentDate DESC"),
    @NamedQuery(name = "Assessment.findLatestAssessment", query = "SELECT a FROM Assessment a WHERE a.patientId = :patientId AND a.assessmentDate = (SELECT MAX(a2.assessmentDate) FROM Assessment a2 WHERE a2.patientId = :patientId) ORDER BY a.assessmentDate DESC"),
    @NamedQuery(name = "Assessment.findLastAssessment", query = "SELECT a FROM Assessment a WHERE a.patientId = :patientId AND a.scaleId = :scaleId AND a.assessmentDate < :assessmentDate AND a.status = true ORDER BY a.assessmentDate DESC"),
    @NamedQuery(name = "Assessment.listByTodateAddScale", query = "SELECT a FROM Assessment a WHERE a.assessmentDate >= :startDate AND a.assessmentDate < :startOfNextDay AND a.patientId = :patientId ORDER BY a.id ASC")
})
public class Assessment implements IntIdDataEntity, Serializable {
    
    private static final long serialVersionUID = 78985274123L;

    @Id
    @Column(name = "\"id\"", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "\"therapist_id\"", nullable = true)
    private Long therapistId;
    
    @Column(name = "\"patient_id\"", nullable = false)
    private Long patientId;
    
    @Column(name = "\"scale_id\"", nullable = false)
    private Long scaleId;
    
    @Column(name = "\"assessment_date\"", nullable = false)
    private Date assessmentDate;
    
    @Column(name = "\"scale_level_id\"", nullable = true)
    private Long scaleLevevlId;
    
    @Column(name = "\"total_score\"", unique = false, nullable = true)
    private Integer totalScore = 0;
    
    @Column(name = "\"status\"", nullable = false)
    private boolean status = false;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getTherapistId() {
        return therapistId;
    }

    public void setTherapistId(Long therapistId) {
        this.therapistId = therapistId;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

    public Long getScaleId() {
        return scaleId;
    }

    public void setScaleId(Long scaleId) {
        this.scaleId = scaleId;
    }

    public Date getAssessmentDate() {
        return assessmentDate;
    }

    public void setAssessmentDate(Date assessmentDate) {
        this.assessmentDate = assessmentDate;
    }

    public Long getScaleLevevlId() {
        return scaleLevevlId;
    }

    public void setScaleLevevlId(Long scaleLevevlId) {
        this.scaleLevevlId = scaleLevevlId;
    }

    public Integer getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Integer totalScore) {
        this.totalScore = totalScore;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Assessment{" + "id=" + id + ", therapistId=" + therapistId + ", patientId=" + patientId + ", scaleId=" + scaleId + ", assessmentDate=" + assessmentDate + ", scaleLevevlId=" + scaleLevevlId + ", totalScore=" + totalScore + ", status=" + status + '}';
    }

}
