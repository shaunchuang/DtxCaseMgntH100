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
public class HcRecordResp {

    private Long id;
    private String evalDate = "";
    private String subjective = "";
    private String objective = "";
    private CodeItem mainIcdCode;
    private CodeItem subIcdCode1;
    private CodeItem subIcdCode2;
    private CodeItem subIcdCode3;
    private CodeItem subIcdCode4;
    private CodeItem subIcdCode5;
    private CodeItem coPaymentCode;
    private String total_points = "";
    private String part_points = "";
    private String serial_no = "";
    private List<PaymentItem> paymentItems;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEvalDate() {
        return evalDate;
    }

    public void setEvalDate(String evalDate) {
        this.evalDate = evalDate;
    }

    public String getSubjective() {
        return subjective;
    }

    public void setSubjective(String subjective) {
        this.subjective = subjective;
    }

    public String getObjective() {
        return objective;
    }

    public void setObjective(String objective) {
        this.objective = objective;
    }

    public CodeItem getMainIcdCode() {
        return mainIcdCode;
    }

    public void setMainIcdCode(CodeItem mainIcdCode) {
        this.mainIcdCode = mainIcdCode;
    }

    public CodeItem getSubIcdCode1() {
        return subIcdCode1;
    }

    public void setSubIcdCode1(CodeItem subIcdCode1) {
        this.subIcdCode1 = subIcdCode1;
    }

    public CodeItem getSubIcdCode2() {
        return subIcdCode2;
    }

    public void setSubIcdCode2(CodeItem subIcdCode2) {
        this.subIcdCode2 = subIcdCode2;
    }

    public CodeItem getSubIcdCode3() {
        return subIcdCode3;
    }

    public void setSubIcdCode3(CodeItem subIcdCode3) {
        this.subIcdCode3 = subIcdCode3;
    }

    public CodeItem getSubIcdCode4() {
        return subIcdCode4;
    }

    public void setSubIcdCode4(CodeItem subIcdCode4) {
        this.subIcdCode4 = subIcdCode4;
    }

    public CodeItem getSubIcdCode5() {
        return subIcdCode5;
    }

    public void setSubIcdCode5(CodeItem subIcdCode5) {
        this.subIcdCode5 = subIcdCode5;
    }

    public CodeItem getCoPaymentCode() {
        return coPaymentCode;
    }

    public void setCoPaymentCode(CodeItem coPaymentCode) {
        this.coPaymentCode = coPaymentCode;
    }

    public String getTotal_points() {
        return total_points;
    }

    public void setTotal_points(String total_points) {
        this.total_points = total_points;
    }

    public String getPart_points() {
        return part_points;
    }

    public void setPart_points(String part_points) {
        this.part_points = part_points;
    }

    public String getSerial_no() {
        return serial_no;
    }

    public void setSerial_no(String serial_no) {
        this.serial_no = serial_no;
    }

    public List<PaymentItem> getPaymentItems() {
        return paymentItems;
    }

    public void setPaymentItems(List<PaymentItem> paymentItems) {
        this.paymentItems = paymentItems;
    }

    
}
