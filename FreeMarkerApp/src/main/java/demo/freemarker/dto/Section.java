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
public class Section {
    private Long id;
	private Long sectionNo;
	private String title = "";
	private String note;
	private List<String> evaluationTypes = new ArrayList<>();
	private List<QuestionItem> items = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getSectionNo() {
        return sectionNo;
    }

    public void setSectionNo(Long sectionNo) {
        this.sectionNo = sectionNo;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public List<String> getEvaluationTypes() {
        return evaluationTypes;
    }

    public void setEvaluationTypes(List<String> evaluationTypes) {
        this.evaluationTypes = evaluationTypes;
    }

    public List<QuestionItem> getItems() {
        return items;
    }

    public void setItems(List<QuestionItem> items) {
        this.items = items;
    }

    		public void format(){
			this.title 		= StringUtils.isEmpty(this.title)?       null: StringUtils.trim(this.title).toLowerCase();
			
			if (this.items != null) {
	            for (QuestionItem item : this.items) {
	                item.format();
	            }
	        }
		}
}
