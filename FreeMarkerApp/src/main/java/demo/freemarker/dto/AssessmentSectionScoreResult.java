/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.dto;

import java.util.List;

/**
 *
 * @author zhush
 */
public class AssessmentSectionScoreResult {
    private Long section;
    private List<AssessmentScoreResult> sectionResults;
    private int sectionScore;

    public Long getSection() {
        return section;
    }

    public void setSection(Long section) {
        this.section = section;
    }

    public List<AssessmentScoreResult> getSectionResults() {
        return sectionResults;
    }

    public void setSectionResults(List<AssessmentScoreResult> sectionResults) {
        this.sectionResults = sectionResults;
    }

    public int getSectionScore() {
        return sectionScore;
    }

    public void setSectionScore(int sectionScore) {
        this.sectionScore = sectionScore;
    }
    
    
}
