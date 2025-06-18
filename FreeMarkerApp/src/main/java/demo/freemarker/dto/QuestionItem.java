/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.dto;

import demo.freemarker.core.StringUtils;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author zhush
 */
public class QuestionItem {
    private Long id;
    private Long parentItemNo;
    private Long itemNo;
    private String question;
    private String itemType;
    private Integer score;
    private int scoreMin;
    private int scoreMax;
    private String labelLeft;
    private String labelRight;
    private Boolean hasParentQues = false;
    private Boolean isSingleChoice= true;
    private Boolean horizontalView;
    private String note;
    private List<QuestionEvaluationType> questionEvaluationTypes = new ArrayList<>();
    private List<QuestionOpt> opts = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getParentItemNo() {
        return parentItemNo;
    }

    public void setParentItemNo(Long parentItemNo) {
        this.parentItemNo = parentItemNo;
    }

    public Long getItemNo() {
        return itemNo;
    }

    public void setItemNo(Long itemNo) {
        this.itemNo = itemNo;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public int getScoreMin() {
        return scoreMin;
    }

    public void setScoreMin(int scoreMin) {
        this.scoreMin = scoreMin;
    }

    public int getScoreMax() {
        return scoreMax;
    }

    public void setScoreMax(int scoreMax) {
        this.scoreMax = scoreMax;
    }

    public String getLabelLeft() {
        return labelLeft;
    }

    public void setLabelLeft(String labelLeft) {
        this.labelLeft = labelLeft;
    }

    public String getLabelRight() {
        return labelRight;
    }

    public void setLabelRight(String labelRight) {
        this.labelRight = labelRight;
    }

    public Boolean getHasParentQues() {
        return hasParentQues;
    }

    public void setHasParentQues(Boolean hasParentQues) {
        this.hasParentQues = hasParentQues;
    }

    public Boolean getIsSingleChoice() {
        return isSingleChoice;
    }

    public void setIsSingleChoice(Boolean isSingleChoice) {
        this.isSingleChoice = isSingleChoice;
    }

    public Boolean getHorizontalView() {
        return horizontalView;
    }

    public void setHorizontalView(Boolean horizontalView) {
        this.horizontalView = horizontalView;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public List<QuestionEvaluationType> getQuestionEvaluationTypes() {
        return questionEvaluationTypes;
    }

    public void setQuestionEvaluationTypes(List<QuestionEvaluationType> questionEvaluationTypes) {
        this.questionEvaluationTypes = questionEvaluationTypes;
    }

    public List<QuestionOpt> getOpts() {
        return opts;
    }

    public void setOpts(List<QuestionOpt> opts) {
        this.opts = opts;
    }
    
    		public void format() {
	        this.question 	= StringUtils.isEmpty(this.question) ? 		null : StringUtils.trim(this.question);
	        this.labelLeft 	= StringUtils.isEmpty(this.labelLeft) ? 	null : StringUtils.trim(this.labelLeft);
	        this.labelRight = StringUtils.isEmpty(this.labelRight) ? 	null : StringUtils.trim(this.labelRight);

	        if (this.opts != null) {
	            for (QuestionOpt opt : this.opts) {
	                opt.format();
	            }
	        }
	    }
}
