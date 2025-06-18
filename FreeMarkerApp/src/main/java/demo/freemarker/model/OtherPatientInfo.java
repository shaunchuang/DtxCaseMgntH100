/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.model;

import itri.sstc.framework.core.database.IntIdDataEntity;
import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

/**
 *
 * @author zhush
 */
@Entity
@Table(name = "other_patient_info")
@XmlRootElement
public class OtherPatientInfo implements IntIdDataEntity, Serializable {
    
    private static final long serialVersionUID = 18276309L;
    
    @Id
    private Long patientId;
    
    @OneToOne
    @MapsId
    @JoinColumn(name = "patient_id")
    private Patient patient;
    
    @Column(name = "main_issue_desc", length = 500)
    private String mainIssueDesc;       // 主要問題描述

    @Column(name = "difficulty_description", length = 500)
    private String difficultyDesc;      // 主關陳述/自述困難（個案/家屬）
    
    @Column(name = "education_level", length = 50)
    private String educationLevel;      // 教育程度

    @Column(name = "occupation", length = 50)
    private String occupation;          // 職業別

    @Column(name = "family_language", length = 50)
    private String familyLanguage;      // 家庭主要使用語言
    
    @Column(name = "preeducation_exp", length = 50)
    private String preeducationExp;     // 接受學前教育經驗
    
    @Column(name = "father_education", length = 50)
    private String fatherEducation;     // 父親教育程度
    
    @Column(name = "mother_education", length = 50)
    private String motherEducation;     // 母親教育程度
    
    @ManyToMany
    @JoinTable(
        name = "\"patient_speech_issue\"",
        joinColumns = @JoinColumn(name = "patient_id"),
        inverseJoinColumns = @JoinColumn(name = "speech_dev_issue_id")
    )
    @OnDelete(action = OnDeleteAction.CASCADE)
    private List<SpeechDevIssueCategory> speechDevIssues; // 語言發展問題類別
    
    @Column(name = "communication_mtd", length = 50)
    private String communicationMtd;    // 溝通方式

    @Column(name = "swallow_difficulty", length = 50)
    private String swallowDifficulty;   // 吞嚥困難程度

    @Column(name = "psychological_state", length = 50)
    private String psychologicalState;  // 情緒與心理狀態
    
    @Column(name = "other_remarks", length = 500)
    private String otherRemarks;        // 其他備註
    
    @Column(name = "father_occupation", length = 50)
    private String fatherOccupation;    // 父親職業別
    
    @Column(name = "mother_occupation", length = 50)
    private String motherOccupation;    // 母親職業別
    
    @Column(name = "developmental_delay", length = 50)
    private String developmentalDelay;  // 有無發展遲緩或身心障礙
    
    @Column(name = "suspected_speech_issues", length = 50)
    private String suspectedSpeechIssues; // 有無疑似語言發展問題
    
    @Column(name = "comprehension_ability", length = 50)
    private String comprehensionAbility; // 理解能力
    
    @Column(name = "expression_ability", length = 50)
    private String expressionAbility;    // 表達能力
    
    @Column(name = "recent_stress_events", length = 100)
    private String recentStressEvents;   // 最近生活壓力事件
    
    @Column(name = "family_support_level", length = 50)
    private String familySupportLevel;   // 家庭支持程度
    
    @Column(name = "psychological_treatment", length = 50)
    private String psychologicalTreatment; // 是否曾接受心理治療
    
    @Column(name = "treatment_details", length = 200)
    private String treatmentDetails;     // 心理治療時間與原因
    
    @Column(name = "suicidal_thoughts", length = 50)
    private String suicidalThoughts;     // 是否曾有自殺想法
    
    @Column(name = "self_harm_behavior", length = 50)
    private String selfHarmBehavior;     // 是否曾有自傷行為
    
    public String getMainIssueDesc() {
        return mainIssueDesc;
    }

    public void setMainIssueDesc(String mainIssueDesc) {
        this.mainIssueDesc = mainIssueDesc;
    }

    public String getDifficultyDesc() {
        return difficultyDesc;
    }

    public void setDifficultyDesc(String difficultyDesc) {
        this.difficultyDesc = difficultyDesc;
    }

    public String getEducationLevel() {
        return educationLevel;
    }

    public void setEducationLevel(String educationLevel) {
        this.educationLevel = educationLevel;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public String getFamilyLanguage() {
        return familyLanguage;
    }

    public void setFamilyLanguage(String familyLanguage) {
        this.familyLanguage = familyLanguage;
    }

    public String getPreeducationExp() {
        return preeducationExp;
    }

    public void setPreeducationExp(String preeducationExp) {
        this.preeducationExp = preeducationExp;
    }

    public String getFatherEducation() {
        return fatherEducation;
    }

    public void setFatherEducation(String fatherEducation) {
        this.fatherEducation = fatherEducation;
    }

    public String getMotherEducation() {
        return motherEducation;
    }

    public void setMotherEducation(String motherEducation) {
        this.motherEducation = motherEducation;
    }

    public String getCommunicationMtd() {
        return communicationMtd;
    }

    public void setCommunicationMtd(String communicationMtd) {
        this.communicationMtd = communicationMtd;
    }

    public String getSwallowDifficulty() {
        return swallowDifficulty;
    }

    public void setSwallowDifficulty(String swallowDifficulty) {
        this.swallowDifficulty = swallowDifficulty;
    }

    public String getPsychologicalState() {
        return psychologicalState;
    }

    public void setPsychologicalState(String psychologicalState) {
        this.psychologicalState = psychologicalState;
    }

    public String getOtherRemarks() {
        return otherRemarks;
    }

    public void setOtherRemarks(String otherRemarks) {
        this.otherRemarks = otherRemarks;
    }

    public String getFatherOccupation() {
        return fatherOccupation;
    }

    public void setFatherOccupation(String fatherOccupation) {
        this.fatherOccupation = fatherOccupation;
    }

    public String getMotherOccupation() {
        return motherOccupation;
    }

    public void setMotherOccupation(String motherOccupation) {
        this.motherOccupation = motherOccupation;
    }

    public String getDevelopmentalDelay() {
        return developmentalDelay;
    }

    public void setDevelopmentalDelay(String developmentalDelay) {
        this.developmentalDelay = developmentalDelay;
    }

    public String getSuspectedSpeechIssues() {
        return suspectedSpeechIssues;
    }

    public void setSuspectedSpeechIssues(String suspectedSpeechIssues) {
        this.suspectedSpeechIssues = suspectedSpeechIssues;
    }

    public String getComprehensionAbility() {
        return comprehensionAbility;
    }

    public void setComprehensionAbility(String comprehensionAbility) {
        this.comprehensionAbility = comprehensionAbility;
    }

    public String getExpressionAbility() {
        return expressionAbility;
    }

    public void setExpressionAbility(String expressionAbility) {
        this.expressionAbility = expressionAbility;
    }

    public String getRecentStressEvents() {
        return recentStressEvents;
    }

    public void setRecentStressEvents(String recentStressEvents) {
        this.recentStressEvents = recentStressEvents;
    }

    public String getFamilySupportLevel() {
        return familySupportLevel;
    }

    public void setFamilySupportLevel(String familySupportLevel) {
        this.familySupportLevel = familySupportLevel;
    }

    public String getPsychologicalTreatment() {
        return psychologicalTreatment;
    }

    public void setPsychologicalTreatment(String psychologicalTreatment) {
        this.psychologicalTreatment = psychologicalTreatment;
    }

    public String getTreatmentDetails() {
        return treatmentDetails;
    }

    public void setTreatmentDetails(String treatmentDetails) {
        this.treatmentDetails = treatmentDetails;
    }

    public String getSuicidalThoughts() {
        return suicidalThoughts;
    }

    public void setSuicidalThoughts(String suicidalThoughts) {
        this.suicidalThoughts = suicidalThoughts;
    }

    public String getSelfHarmBehavior() {
        return selfHarmBehavior;
    }

    public void setSelfHarmBehavior(String selfHarmBehavior) {
        this.selfHarmBehavior = selfHarmBehavior;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }    public List<SpeechDevIssueCategory> getSpeechDevIssues() {
        return speechDevIssues;
    }

    public void setSpeechDevIssues(List<SpeechDevIssueCategory> speechDevIssues) {
        this.speechDevIssues = speechDevIssues;
    }
    
    @Override
    public Long getId() {
        return patientId;
    }

    @Override
    public void setId(Long id) {
        this.patientId = id;
    }
    
}
