/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author zhush
 */
public class AssessmentInfo {

    private Long assessmentId;
    private Long patientId;
    private Long therapistId;
    private String param;
    private Boolean isFromPatient = false;
    private Date assessmentBeginDate;
    private Date assessmentEndDate;
    private List<Long> scaleIds = new ArrayList<Long>();
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

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

    public Boolean getIsFromPatient() {
        return isFromPatient;
    }

    public void setIsFromPatient(Boolean isFromPatient) {
        this.isFromPatient = isFromPatient;
    }

    public Date getAssessmentBeginDate() {
        return assessmentBeginDate;
    }

    public void setAssessmentBeginDate(Date assessmentBeginDate) {
        this.assessmentBeginDate = assessmentBeginDate;
    }

    public Date getAssessmentEndDate() {
        return assessmentEndDate;
    }

    public void setAssessmentEndDate(Date assessmentEndDate) {
        this.assessmentEndDate = assessmentEndDate;
    }

    public List<Long> getScaleIds() {
        return scaleIds;
    }

    public void setScaleIds(List<Long> scaleIds) {
        this.scaleIds = scaleIds;
    }

    public Boolean getShowList() {
        return showList;
    }

    public void setShowList(Boolean showList) {
        this.showList = showList;
    }

}
