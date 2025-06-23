package demo.freemarker.dto;

public class QryPtInfoDTO {
    public Long userId;
	public String charno = ""; /* 搜尋條件--病歷號 */
	public String idno = ""; /* 搜尋條件--身份證 */
	public String name = ""; /* 搜尋條件--姓名 */
	public String carer = ""; /* 搜尋條件--管案人 */
	public Integer page_num;
	public String limit = "";
	public String sort = "";
	public String order = "";
}
