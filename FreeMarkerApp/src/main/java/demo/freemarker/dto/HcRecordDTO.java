package demo.freemarker.dto;

public class HcRecordDTO {
    private Long id;
    private Long serialno;
    private String keyno = "";
    private String diagDate;
    private String mainIcdCode = "";
    private String visitDate = "";
    private String visitCat = "";
    private String indication;
    private String doctorName;
    private String doctorAlias;

    public HcRecordDTO() {
    }

    public HcRecordDTO(Long id, String keyno, String mainIcdCode, String visitDate, String visitCat) {
        this.id = id;
        this.keyno = keyno;
        this.mainIcdCode = mainIcdCode;
        this.visitDate = visitDate;
        this.visitCat = visitCat;
    }

    public HcRecordDTO(Long serialno, Long id, String keyno, String diagDate, String indication, String doctorName, String doctorAlias) {
        this.serialno = serialno;
        this.id = id;
        this.keyno = keyno;
        this.diagDate = diagDate;
        this.indication = indication;
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

    public String getKeyno() {
        return keyno;
    }

    public void setKeyno(String keyno) {
        this.keyno = keyno;
    }

    public String getDiagDate() {
        return diagDate;
    }

    public void setDiagDate(String diagDate) {
        this.diagDate = diagDate;
    }

    public String getMainIcdCode() {
        return mainIcdCode;
    }

    public void setMainIcdCode(String mainIcdCode) {
        this.mainIcdCode = mainIcdCode;
    }

    public String getVisitDate() {
        return visitDate;
    }

    public void setVisitDate(String visitDate) {
        this.visitDate = visitDate;
    }

    public String getVisitCat() {
        return visitCat;
    }

    public void setVisitCat(String visitCat) {
        this.visitCat = visitCat;
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

}
