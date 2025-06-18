package demo.freemarker.model.healthinsurance;

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
@Table(name = "\"therapeutic_treatment\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TherapeuticTreatment.findAll", query = "SELECT t FROM TherapeuticTreatment t"),
    @NamedQuery(name = "TherapeuticTreatment.findByHiRecordId", query = "SELECT t FROM TherapeuticTreatment t WHERE t.hiRecordId = :hiRecordId"),
    @NamedQuery(name = "TherapeuticTreatment.findByExecutiveId", query = "SELECT t FROM TherapeuticTreatment t WHERE t.executiveId = :executiveId")
})
public class TherapeuticTreatment implements IntIdDataEntity, Serializable {
    private static final long serialVersionUID = 1822843031309L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    // 對應診斷紀錄ID
    @Column(name = "\"hiRecord_id\"", nullable = false)
    Long hiRecordId;

    // 處置代碼
    @Column(name = "\"treatment_code\"", length = 50)
    String treatmentCode;

    // 總量?天數
    @Column(name = "\"total_mount\"", length = 50)
    String totalMount;

    // 點數
    @Column(name = "\"point\"")
    int point;

    // 執行人員ID
    @Column(name = "\"executive_id\"", nullable = false)
    Long executiveId;

    // 開始時間
    @Column(name = "\"start_time\"")
    @Temporal(TemporalType.TIME)
    Date startTime;

    // 結束時間
    @Column(name = "\"end_time\"")
    @Temporal(TemporalType.TIME)
    Date endTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getHiRecordId() {
        return hiRecordId;
    }

    public void setHiRecordId(Long hiRecordId) {
        this.hiRecordId = hiRecordId;
    }

    public String getTreatmentCode() {
        return treatmentCode;
    }

    public void setTreatmentCode(String treatmentCode) {
        this.treatmentCode = treatmentCode;
    }

    public String getTotalMount() {
        return totalMount;
    }

    public void setTotalMount(String totalMount) {
        this.totalMount = totalMount;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public Long getExecutiveId() {
        return executiveId;
    }

    public void setExecutiveId(Long executiveId) {
        this.executiveId = executiveId;
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
    
    
}
