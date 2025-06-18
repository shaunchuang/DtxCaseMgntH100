/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.dto;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author zhush
 */
public class AssessmentResultInfo {

    private Long assessmentId;
    private Long patientId;
    private Long therapistId;
    private String assessmentDate;
    private List<AssessmentScoreResult> itemResults = new ArrayList<AssessmentScoreResult>();
    private List<AssessmentSectionScoreResult> sectionItemResults = new ArrayList<AssessmentSectionScoreResult>();
    private int totalScore;
    private Boolean showList = false;

    public Long getAssessmentId() {
        return assessmentId;
    }

    public void setAssessmentId(Long assessmentId) {
        this.assessmentId = assessmentId;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

    public Long getTherapistId() {
        return therapistId;
    }

    public void setTherapistId(Long therapistId) {
        this.therapistId = therapistId;
    }

    public String getAssessmentDate() {
        return assessmentDate;
    }

    public void setAssessmentDate(String assessmentDate) {
        this.assessmentDate = assessmentDate;
    }

    public List<AssessmentScoreResult> getItemResults() {
        return itemResults;
    }

    public void setItemResults(List<AssessmentScoreResult> itemResults) {
        this.itemResults = itemResults;
    }

    public List<AssessmentSectionScoreResult> getSectionItemResults() {
        return sectionItemResults;
    }

    public void setSectionItemResults(List<AssessmentSectionScoreResult> sectionItemResults) {
        this.sectionItemResults = sectionItemResults;
    }

    public int getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(int totalScore) {
        this.totalScore = totalScore;
    }

    public Boolean getShowList() {
        return showList;
    }

    public void setShowList(Boolean showList) {
        this.showList = showList;
    }

}
