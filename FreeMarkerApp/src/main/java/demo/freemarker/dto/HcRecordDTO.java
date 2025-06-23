package demo.freemarker.dto;

public class HcRecordDTO {

    private Long id;
    private Long serialno;
    private String keyNo;
    private Long patientId;
    private String diagDate;
    private String diagDateTime;
    private String mainIcdCode = "";
    private String visitCat = "";
    private String icdCode = "";
    private String indication = "";
    private String doctorName = "";
    private String doctorAlias = "";
    private Boolean isFirstDiag = false;
    private int diagTimes;

    public HcRecordDTO() {
    }

    public HcRecordDTO(Long serialNo, Long id, Long patientId, String mainIcdCode, String diagDate, String visitCat) {
        this.serialno = serialNo;
        this.id = id;
        this.patientId = patientId;
        this.mainIcdCode = mainIcdCode;
        this.diagDate = diagDate;
        this.visitCat = visitCat;
    }

    public HcRecordDTO(Long serialno, Long id, Long patientId, String diagDate, String icdCode, String doctorName, String doctorAlias) {
        this.serialno = serialno;
        this.id = id;
        this.patientId = patientId;
        this.diagDate = diagDate;
        this.icdCode = icdCode;
        this.doctorName = doctorName;
        this.doctorAlias = doctorAlias;
    }

    public HcRecordDTO(Long serialno, Long id, Long patientId, String diagDateTime, Boolean isFirstDiag, int diagTimes, String icdCode,
            String doctorName, String doctorAlias) {
        this.serialno = serialno;
        this.id = id;
        this.patientId = patientId;
        this.diagDateTime = diagDateTime;
        this.isFirstDiag = isFirstDiag;
        this.diagTimes = diagTimes;
        this.icdCode = icdCode;
        this.doctorName = doctorName;
        this.doctorAlias = doctorAlias;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getSerialno() {
        return serialno;
    }

    public void setSerialno(Long serialno) {
        this.serialno = serialno;
    }

    public String getKeyNo() {
        return keyNo;
    }

    public void setKeyNo(String keyNo) {
        this.keyNo = keyNo;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

    public String getDiagDate() {
        return diagDate;
    }

    public void setDiagDate(String diagDate) {
        this.diagDate = diagDate;
    }

    public String getDiagDateTime() {
        return diagDateTime;
    }

    public void setDiagDateTime(String diagDateTime) {
        this.diagDateTime = diagDateTime;
    }

    public String getMainIcdCode() {
        return mainIcdCode;
    }

    public void setMainIcdCode(String mainIcdCode) {
        this.mainIcdCode = mainIcdCode;
    }

    public String getVisitCat() {
        return visitCat;
    }

    public void setVisitCat(String visitCat) {
        this.visitCat = visitCat;
    }

    public String getIcdCode() {
        return icdCode;
    }

    public void setIcdCode(String icdCode) {
        this.icdCode = icdCode;
    }

    public String getIndication() {
        return indication;
    }

    public void setIndication(String indication) {
        this.indication = indication;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getDoctorAlias() {
        return doctorAlias;
    }

    public void setDoctorAlias(String doctorAlias) {
        this.doctorAlias = doctorAlias;
    }

    public Boolean getIsFirstDiag() {
        return isFirstDiag;
    }

    public void setIsFirstDiag(Boolean isFirstDiag) {
        this.isFirstDiag = isFirstDiag;
    }

    public int getDiagTimes() {
        return diagTimes;
    }

    public void setDiagTimes(int diagTimes) {
        this.diagTimes = diagTimes;
    }

}
