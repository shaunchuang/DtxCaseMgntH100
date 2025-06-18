/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.dto;

import demo.freemarker.core.StringUtils;


/**
 *
 * @author zhush
 */
public class QuestionOpt {
    private Long id;
    private Long optionNo;
    private String optionText;
    private int score;
    private Boolean isDescOption = false;
    private Boolean checked = false;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getOptionNo() {
        return optionNo;
    }

    public void setOptionNo(Long optionNo) {
        this.optionNo = optionNo;
    }

    public String getOptionText() {
        return optionText;
    }

    public void setOptionText(String optionText) {
        this.optionText = optionText;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public Boolean getIsDescOption() {
        return isDescOption;
    }

    public void setIsDescOption(Boolean isDescOption) {
        this.isDescOption = isDescOption;
    }

    public Boolean getChecked() {
        return checked;
    }

    public void setChecked(Boolean checked) {
        this.checked = checked;
    }
    
    public void format() {
	    this.optionText = StringUtils.isEmpty(this.optionText) ? null : StringUtils.trim(this.optionText);
	}
    
}
