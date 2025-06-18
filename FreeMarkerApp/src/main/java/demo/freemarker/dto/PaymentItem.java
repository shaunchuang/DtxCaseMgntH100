/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.dto;

/**
 *
 * @author zhush
 */
public class PaymentItem {

    private Long keyno;
    private CodeItem paymentItemCode;
    private String amount = "";
    private String points = "";
    private CodeItem executor;
    private String beginTime = "";
    private String endTime = "";

    public Long getKeyno() {
        return keyno;
    }

    public void setKeyno(Long keyno) {
        this.keyno = keyno;
    }

    public CodeItem getPaymentItemCode() {
        return paymentItemCode;
    }

    public void setPaymentItemCode(CodeItem paymentItemCode) {
        this.paymentItemCode = paymentItemCode;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getPoints() {
        return points;
    }

    public void setPoints(String points) {
        this.points = points;
    }

    public CodeItem getExecutor() {
        return executor;
    }

    public void setExecutor(CodeItem executor) {
        this.executor = executor;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
    
    
}
