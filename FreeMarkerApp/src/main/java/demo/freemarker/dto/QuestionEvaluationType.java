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
public class QuestionEvaluationType {
    private String evaluationType;
    private Boolean isSingleChoice = true;
    private List<QuestionOpt> opts = new ArrayList<>();

    public String getEvaluationType() {
        return evaluationType;
    }

    public void setEvaluationType(String evaluationType) {
        this.evaluationType = evaluationType;
    }

    public Boolean getIsSingleChoice() {
        return isSingleChoice;
    }

    public void setIsSingleChoice(Boolean isSingleChoice) {
        this.isSingleChoice = isSingleChoice;
    }

    public List<QuestionOpt> getOpts() {
        return opts;
    }

    public void setOpts(List<QuestionOpt> opts) {
        this.opts = opts;
    }
    
    
}
