package demo.freemarker.model;

import demo.freemarker.api.UserAPI;
import demo.freemarker.core.CrossPlatformUtil;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.io.Serializable;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Table(name = "\"patient\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Patient.findByIdno", query = "SELECT p FROM Patient p WHERE p.idno = :idno"),
    @NamedQuery(name = "Patient.findByUserId", query = "SELECT p FROM Patient p WHERE p.userId = :userId")
})
public class Patient implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 1822843074531976309L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "\"user_id\"", nullable = true)
    private Long userId;

    @Column(name = "\"idno\"", nullable = false, unique = true, length = 50)
    private String idno;
    
    @Column(name = "\"gender\"", length = 10)
    private String gender;

    @Column(name = "\"marital_status\"", nullable = true, length=10)
    private String maritalStatus;

    @Column(name = "\"birth\"", length = 50)
    @Temporal(TemporalType.DATE)
    private Date birth;

    @Column(name = "\"city\"", length = 50)
    private String city;

    @Column(name = "\"district\"", length = 50)
    private String district;

    @Column(name = "\"address\"", length = 255)
    private String address;

    @Column(name = "\"emergency_contact\"", length = 50)
    private String emergencyContact;

    @Column(name = "\"emergency_phone\"", length = 50)
    private String emergencyPhone;

    @Column(name = "\"emergency_relation\"", length = 50)
    private String emergencyRelation;

    @ManyToMany
    @JoinTable(
            name = "patient_disease",
            joinColumns = @JoinColumn(name = "patient_id"),
            inverseJoinColumns = @JoinColumn(name = "disease_category_id")
    )
    @OnDelete(action = OnDeleteAction.CASCADE)
    private List<DiseaseCategory> diseaseCategories;

    @Column(name = "\"other_history_disease\"", length = 255)
    private String otherHistoryDisease;

    @ManyToMany
    @JoinTable(
        name = "\"patient_medical_history\"",
        joinColumns = @JoinColumn(name = "patient_id"),
        inverseJoinColumns = @JoinColumn(name = "medical_category_id")
    )
    @OnDelete(action = OnDeleteAction.CASCADE)
    private List<MedicationCategory> medicalCategories;

    @Column(name = "\"other_medical_history\"", nullable = true, length = 255)
    private String otherMedicalHistory;
    
    @ManyToMany
    @JoinTable(
        name = "\"patient_drug_use_status\"",
        joinColumns = @JoinColumn(name = "patient_id"),
        inverseJoinColumns = @JoinColumn(name = "drug_use_status_category_id")
    )
    @OnDelete(action = OnDeleteAction.CASCADE)
    private List<DrugUseStatusCategory> drugUseStatusCategory;

    @Column(name = "\"other_drug_use_status\"", nullable = true, length = 255)
    private String otherDrugUseStatus;

    @Column(name = "\"disease_id\"")
    private Long diseaseId;
    
    @OneToOne(mappedBy = "patient",
              cascade = CascadeType.ALL,
              orphanRemoval = true,
              fetch = FetchType.LAZY)
    private OtherPatientInfo otherPatientInfo;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getIdno() {
        return idno;
    }

    public void setIdno(String idno) {
        this.idno = idno;
    }

    public String getGender() {
        return gender;
    }    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmergencyContact() {
        return emergencyContact;
    }

    public void setEmergencyContact(String emergencyContact) {
        this.emergencyContact = emergencyContact;
    }

    public String getEmergencyPhone() {
        return emergencyPhone;
    }

    public void setEmergencyPhone(String emergencyPhone) {
        this.emergencyPhone = emergencyPhone;
    }

    public String getEmergencyRelation() {
        return emergencyRelation;
    }

    public void setEmergencyRelation(String emergencyRelation) {
        this.emergencyRelation = emergencyRelation;
    }

    public List<DiseaseCategory> getDiseaseCategories() {
        return diseaseCategories;
    }

    public void setDiseaseCategories(List<DiseaseCategory> diseaseCategories) {
        this.diseaseCategories = diseaseCategories;
    }

    public String getOtherHistoryDisease() {
        return otherHistoryDisease;
    }

    public void setOtherHistoryDisease(String otherHistoryDisease) {
        this.otherHistoryDisease = otherHistoryDisease;
    }

    public List<MedicationCategory> getMedicalCategories() {
        return medicalCategories;
    }

    public void setMedicalCategories(List<MedicationCategory> medicalCategories) {
        this.medicalCategories = medicalCategories;
    }

    public String getOtherMedicalHistory() {
        return otherMedicalHistory;
    }

    public void setOtherMedicalHistory(String otherMedicalHistory) {
        this.otherMedicalHistory = otherMedicalHistory;
    }

    public Long getDiseaseId() {
        return diseaseId;
    }

    public void setDiseaseId(Long diseaseId) {
        this.diseaseId = diseaseId;
    }

    public String getDiseaseName() {
        try {
            return CrossPlatformUtil.getInstance().findSyndromeById(this.diseaseId);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public List<DrugUseStatusCategory> getDrugUseStatusCategory() {
        return drugUseStatusCategory;
    }

    public void setDrugUseStatusCategory(List<DrugUseStatusCategory> drugUseStatusCategory) {
        this.drugUseStatusCategory = drugUseStatusCategory;
    }

    public String getOtherDrugUseStatus() {
        return otherDrugUseStatus;
    }

    public void setOtherDrugUseStatus(String otherDrugUseStatus) {
        this.otherDrugUseStatus = otherDrugUseStatus;
    }

    public int getAge() {
        if (birth == null) {
            return 0;
        }
        LocalDate birthDate = Instant.ofEpochMilli(birth.getTime())
                .atZone(ZoneId.systemDefault())
                .toLocalDate();
        LocalDate today = LocalDate.now(ZoneId.systemDefault());
        return (int) ChronoUnit.YEARS.between(birthDate, today);
    }

    public String getName() {
        return userId != null ? UserAPI.getInstance().getUser(this.userId).getUsername() : null;
    }
    
    public String getEmail() {
        return userId != null ? UserAPI.getInstance().getUser(this.userId).getEmail() : null;
    }
    
    public String getPhone() {
        return userId != null ? UserAPI.getInstance().getUser(this.userId).getTelCell() : null;
    }
    
    @Override
    public String toString() {
        return "Patient{"
                + "id=" + id
                + ", idno='" + idno + '\''
                + ", name='" + this.getName() + '\''
                + ", gender='" + gender + '\''
                + ", maritalStatus=" + maritalStatus
                + ", birth=" + birth
                + ", city='" + city + '\''
                + ", district='" + district + '\''
                + ", address='" + address + '\''
                + ", emergencyContact='" + emergencyContact + '\''
                + ", emergencyPhone='" + emergencyPhone + '\''
                + ", emergencyRelation='" + emergencyRelation + '\''
                + ", diseaseCategories=" + diseaseCategories
                + ", otherHistoryDisease='" + otherHistoryDisease + '\''
                + ", medicalCategories=" + medicalCategories
                + ", otherMedicalHistory='" + otherMedicalHistory + '\''
                + ", diseaseId=" + diseaseId
                + '}';
    }

    public OtherPatientInfo getOtherPatientInfo() {
        return otherPatientInfo;
    }

    public void setOtherPatientInfo(OtherPatientInfo otherPatientInfo) {
        this.otherPatientInfo = otherPatientInfo;
    }
}
