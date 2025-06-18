/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.dto;

/**
 *
 * @author zhush
 */
public class CaseAssessment {

    public Long id;
    public String lastAssessmentDate; //前次評量日期
    public String assessmentDate; //評量日期
    public String editor; //填寫人
    public String cat; //治療類別
    public String scaleName; //量表名稱
    public int score; //評量分數
    public String level; //檢測結果等級
    public String result; //評量分數結果
    public String totalResult; //評量分數+等級結果
    public String subfuncList; //附屬功能
    public String mode; //模式(編輯or檢視)

    // 建構子
    public CaseAssessment(Long id, String lastAssessmentDate, String assessmentDate, String editor, String cat,
            String scaleName, int score, String level, String result, String totalResult, String subfuncList, String mode) {
        this.id = id;
        this.lastAssessmentDate = lastAssessmentDate;
        this.assessmentDate = assessmentDate;
        this.editor = editor;
        this.cat = cat;
        this.scaleName = scaleName;
        this.score = score;
        this.level = level;
        this.result = result;
        this.totalResult = totalResult;
        this.subfuncList = subfuncList;
        this.mode = mode;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLastAssessmentDate() {
        return lastAssessmentDate;
    }

    public void setLastAssessmentDate(String lastAssessmentDate) {
        this.lastAssessmentDate = lastAssessmentDate;
    }

    public String getAssessmentDate() {
        return assessmentDate;
    }

    public void setAssessmentDate(String assessmentDate) {
        this.assessmentDate = assessmentDate;
    }

    public String getEditor() {
        return editor;
    }

    public void setEditor(String editor) {
        this.editor = editor;
    }

    public String getCat() {
        return cat;
    }

    public void setCat(String cat) {
        this.cat = cat;
    }

    public String getScaleName() {
        return scaleName;
    }

    public void setScaleName(String scaleName) {
        this.scaleName = scaleName;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getTotalResult() {
        return totalResult;
    }

    public void setTotalResult(String totalResult) {
        this.totalResult = totalResult;
    }

    public String getSubfuncList() {
        return subfuncList;
    }

    public void setSubfuncList(String subfuncList) {
        this.subfuncList = subfuncList;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }



    @Override
    public String toString() {
        return "CaseAssessment{id=" + id
                + ", lastAssessmentDate='" + lastAssessmentDate + '\''
                + ", assessmentDate='" + assessmentDate + '\''
                + ", editor='" + editor + '\''
                + ", cat='" + cat + '\''
                + ", scaleName='" + scaleName + '\''
                + ", score='" + score + '\''
                + ", level='" + level + '\''
                + ", result='" + result + '\''
                + ", totalResult='" + totalResult + '\''
                + ", subfuncList='" + subfuncList + '\''
                + ", mode='" + mode + '\''
                + '}';
    }
}
