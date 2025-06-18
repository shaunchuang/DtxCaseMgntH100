/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.dto;

/**
 *
 * @author zhush
 */
public class CodeItem {
    private String code = "";	//代碼
    private String codeTxt = "";	//代碼對應內容
    private String viewTxt = "";	//檢視專用文字

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCodeTxt() {
        return codeTxt;
    }

    public void setCodeTxt(String codeTxt) {
        this.codeTxt = codeTxt;
    }

    public String getViewTxt() {
        return viewTxt;
    }

    public void setViewTxt(String viewTxt) {
        this.viewTxt = viewTxt;
    }
    
    
}
