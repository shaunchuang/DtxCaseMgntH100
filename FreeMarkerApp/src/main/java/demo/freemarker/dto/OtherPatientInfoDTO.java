package demo.freemarker.dto;

import java.util.List;

public class OtherPatientInfoDTO {
    
    private Long patientId;
    private String mainIssueDesc;       // 主要問題描述
    private String difficultyDesc;      // 主關陳述/自述困難（個案/家屬）
    private String educationLevel;      // 教育程度
    private String occupation;          // 職業別
    private String familyLanguage;      // 家庭主要使用語言
    private String preeducationExp;     // 接受學前教育經驗
    private String fatherEducation;     // 父親教育程度
    private String motherEducation;     // 母親教育程度
    private List<Long> speechDevIssueIds; // 語言發展問題類別ID列表
    private String communicationMtd;    // 溝通方式
    private String swallowDifficulty;   // 吞嚥困難程度
    private String psychologicalState;  // 情緒與心理狀態
    private String otherRemarks;        // 其他備註
    private String fatherOccupation;    // 父親職業別
    private String motherOccupation;    // 母親職業別
    private String developmentalDelay;  // 有無發展遲緩或身心障礙
    private String suspectedSpeechIssues; // 有無疑似語言發展問題
    private String comprehensionAbility; // 理解能力
    private String expressionAbility;    // 表達能力
    private String recentStressEvents;   // 最近生活壓力事件
    private String familySupportLevel;   // 家庭支持程度
    private String psychologicalTreatment; // 是否曾接受心理治療
    private String treatmentDetails;     // 心理治療時間與原因
    private String suicidalThoughts;     // 是否曾有自殺想法
    private String selfHarmBehavior;     // 是否曾有自傷行為

    // Getters and Setters
    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

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

    public List<Long> getSpeechDevIssueIds() {
        return speechDevIssueIds;
    }

    public void setSpeechDevIssueIds(List<Long> speechDevIssueIds) {
        this.speechDevIssueIds = speechDevIssueIds;
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
}
