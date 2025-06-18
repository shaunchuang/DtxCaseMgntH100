package demo.freemarker.dto;

import demo.freemarker.api.PatientAPI;
import demo.freemarker.api.UserAPI;
import demo.freemarker.core.MessageSource;
import demo.freemarker.model.Patient;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

public class PatientInfo{
    private String idno;
    private String charno;    
    private String name;
    private String gender;
    private String genderName;
    private String maritalStatus;
    private String birth;
    private String age;
    private Long indicationId;
    private String indication;
    private List<String> diseaseNames;
    private String otherDiseaseName;
    private List<String> medicalHistory;
    private String otherMedicalHistory;
    private List<String> drugUsageHistory;
    private String otherDrugUsageHistory;
    private String phone;
    private String emergencyContact;
    private String emergencyRelation;
    private String emergencyPhone;
    private String email;
    private String city;
    private String district;
    private String address;

    public PatientInfo(Long patientId, Locale locale) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        Patient patient = PatientAPI.getInstance().getPatient(patientId);
        this.charno = String.valueOf(patientId);        this.idno = patient.getIdno();
        this.name = patient.getName();
        this.gender = patient.getGender();
        this.genderName = getGenderName(patient.getGender(), locale);
        this.maritalStatus = patient.getMaritalStatus();
        this.age = String.valueOf(patient.getAge());
        this.birth = sdf.format(patient.getBirth());
        this.indicationId = patient.getDiseaseId();
        this.indication = patient.getDiseaseName();
        // 1. 疾病類別的多語系名稱列表
        this.diseaseNames = patient.getDiseaseCategories().stream()
            .map(dc -> dc.getLocaleName(locale))
            .collect(Collectors.toList());
        this.otherDiseaseName = patient.getOtherHistoryDisease();
        // 2. 用藥史
        this.medicalHistory = patient.getMedicalCategories().stream()
            .map(mc -> mc.getLocaleName(locale))
            .collect(Collectors.toList());
        this.otherMedicalHistory = patient.getOtherMedicalHistory();
        // 3. 用藥狀態
        this.drugUsageHistory = patient.getDrugUseStatusCategory().stream()
            .map(du -> du.getName())
            .collect(Collectors.toList());
        this.otherDrugUsageHistory = patient.getOtherDrugUseStatus();
        this.maritalStatus = getmaritalStatusName(maritalStatus, locale);
        
        // 新增欄位
        this.phone = patient.getPhone();
        this.emergencyContact = patient.getEmergencyContact();
        this.emergencyRelation = patient.getEmergencyRelation();
        this.emergencyPhone = patient.getEmergencyPhone();
        this.email = patient.getEmail();
        this.city = patient.getCity();
        this.district = patient.getDistrict();
        this.address = patient.getAddress();
    }

    public String getIdno() {
        return idno;
    }

    public void setIdno(String idno) {
        this.idno = idno;
    }

    public String getGenderName() {
        return genderName;
    }

    public void setGenderName(String genderName) {
        this.genderName = genderName;
    }

    public String getCharno() {
        return charno;
    }

    public void setCharno(String charno) {
        this.charno = charno;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public Long getIndicationId() {
        return indicationId;
    }

    public void setIndicationId(Long indicationId) {
        this.indicationId = indicationId;
    }

    public String getIndication() {
        return indication;
    }

    public void setIndication(String indication) {
        this.indication = indication;
    }

    public List<String> getDiseaseNames() {
        return diseaseNames;
    }

    public List<String> getMedicalHistory() {
        return medicalHistory;
    }

    public void setMedicalHistory(List<String> medicalHistory) {
        this.medicalHistory = medicalHistory;
    }

    public List<String> getDrugUsageHistory() {
        return drugUsageHistory;
    }

    public void setDrugUsageHistory(List<String> drugUsageHistory) {
        this.drugUsageHistory = drugUsageHistory;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmergencyContact() {
        return emergencyContact;
    }

    public void setEmergencyContact(String emergencyContact) {
        this.emergencyContact = emergencyContact;
    }

    public String getEmergencyRelation() {
        return emergencyRelation;
    }

    public void setEmergencyRelation(String emergencyRelation) {
        this.emergencyRelation = emergencyRelation;
    }

    public String getEmergencyPhone() {
        return emergencyPhone;
    }

    public void setEmergencyPhone(String emergencyPhone) {
        this.emergencyPhone = emergencyPhone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getOtherDiseaseName() {
        return otherDiseaseName;
    }

    public void setOtherDiseaseName(String otherDiseaseName) {
        this.otherDiseaseName = otherDiseaseName;
    }

    public String getOtherMedicalHistory() {
        return otherMedicalHistory;
    }

    public void setOtherMedicalHistory(String otherMedicalHistory) {
        this.otherMedicalHistory = otherMedicalHistory;
    }

    public String getOtherDrugUsageHistory() {
        return otherDrugUsageHistory;
    }

    public void setOtherDrugUsageHistory(String otherDrugUsageHistory) {
        this.otherDrugUsageHistory = otherDrugUsageHistory;
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
    
    public static PatientInfo getPatientInfo(Long patientId, Locale locale) {
        return new PatientInfo(patientId, locale);
    }

    public static String getGenderName(String gender, Locale locale){
        if(gender.toLowerCase().equals("m")) {
            gender = MessageSource.getMessage("caseList.label.male", locale);
        } else if(gender.toLowerCase().equals("f")) {
            gender = MessageSource.getMessage("caseList.label.female", locale);
        } else {
            gender = MessageSource.getMessage("caseList.label.unknown", locale);        }
        return gender;
    }
    
    public static String getmaritalStatusName(String ms, Locale locale) {
        if(ms.toLowerCase().equals("y")){
            ms = MessageSource.getMessage("caseList.label.married", locale);
        } else {
            ms = MessageSource.getMessage("caseList.label.single", locale);
        }
        return ms;
    }
    
}
