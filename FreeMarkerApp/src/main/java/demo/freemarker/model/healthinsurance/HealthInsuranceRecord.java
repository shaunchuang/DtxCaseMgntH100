package demo.freemarker.model.healthinsurance;

import itri.sstc.framework.core.database.IntIdDataEntity;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "\"health_insurance_record\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "HealthInsuranceRecord.findAll", query = "SELECT h FROM HealthInsuranceRecord h"),
    @NamedQuery(name = "HealthInsuranceRecord.findByPatientId", query = "SELECT h FROM HealthInsuranceRecord h WHERE h.patientId = :patientId"),
    @NamedQuery(name = "HealthInsuranceRecord.findBySerialNum", query = "SELECT h FROM HealthInsuranceRecord h WHERE h.serialNum = :serialNum")
})
public class HealthInsuranceRecord implements IntIdDataEntity, Serializable {
    private static final long serialVersionUID = 1822843074531309L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "\"patient_id\"", nullable = false)
    private Long patientId;

    @Lob
    @Column( name = "\"subjective\"")
    private String subjective;

    @Lob
    @Column( name = "\"objective\"")
    private String objective;

    //主診斷碼
    @Column( name = "\"mainDiagnosisCode\"", length = 50)
    private String mainDiagnosisCode;

    //次診斷碼
    @ElementCollection
    @CollectionTable(name = "health_insurance_secondary_diagnosis", joinColumns = @JoinColumn(name = "record_id"))
    @Column(name = "\"diagnosis_code\"", length = 50, nullable = false)
    private List<String> secondaryDiagnosisCodes = new ArrayList<>();

    //部分負擔代碼
    @Column(name = "\"copayment_code\"", length = 50)
    private String copaymentCode;

    //合計點數
    @Column(name = "\"total_point\"")
    private int totalPoint;

    //部分負擔金額
    @Column(name = "\"copayment\"")
    private int copayment;

    //就醫序號
    @Column(name = "\"serial_num\"", length = 50)
    private String serialNum;

    @Column(name = "\"create_time\"")
    private Date createTime; //建立時間

    @Column(name = "\"creator\"")
    private Long creator;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

    public String getSubjective() {
        return subjective;
    }

    public void setSubjective(String subjective) {
        this.subjective = subjective;
    }

    public String getObjective() {
        return objective;
    }

    public void setObjective(String objective) {
        this.objective = objective;
    }

    public String getMainDiagnosisCode() {
        return mainDiagnosisCode;
    }

    public void setMainDiagnosisCode(String mainDiagnosisCode) {
        this.mainDiagnosisCode = mainDiagnosisCode;
    }

    public List<String> getSecondaryDiagnosisCodes() {
        return secondaryDiagnosisCodes;
    }

    public void setSecondaryDiagnosisCodes(List<String> secondaryDiagnosisCodes) {
        this.secondaryDiagnosisCodes = secondaryDiagnosisCodes;
    }

    public String getCopaymentCode() {
        return copaymentCode;
    }

    public void setCopaymentCode(String copaymentCode) {
        this.copaymentCode = copaymentCode;
    }

    public int getTotalPoint() {
        return totalPoint;
    }

    public void setTotalPoint(int totalPoint) {
        this.totalPoint = totalPoint;
    }

    public int getCopayment() {
        return copayment;
    }

    public void setCopayment(int copayment) {
        this.copayment = copayment;
    }

    public String getSerialNum() {
        return serialNum;
    }

    public void setSerialNum(String serialNum) {
        this.serialNum = serialNum;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Long getCreator() {
        return creator;
    }

    public void setCreator(Long creator) {
        this.creator = creator;
    }
}
