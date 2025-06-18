package demo.freemarker.model;

import itri.sstc.framework.core.database.IntIdDataEntity;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "\"wg_icd_code\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "WgIcdCode.findByCode", query = "SELECT icd FROM WgIcdCode icd WHERE icd.code = :code"),
    @NamedQuery(name = "WgIcdCode.findByPureCode", query = "SELECT icd FROM WgIcdCode icd WHERE icd.deleteMark = false AND icd.pureCode LIKE :pureCode ORDER BY icd.id ASC"),
    @NamedQuery(name = "WgIcdCode.findByName", query = "SELECT icd FROM WgIcdCode icd WHERE icd.name = :name"),
})
public class WgIcdCode implements Serializable, IntIdDataEntity {
    private static final long serialVersionUID = 6895103528391102351L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "\"code\"")
    private String code; //診斷碼

    @Column(name = "\"pure_code\"")
	private String pureCode; //診斷碼(去除.)

    @Column(name = "\"name\"")
	private String name;  //診斷中文名稱

    @Column(name = "\"en_name\"")
	private String enName; //診斷英文名稱

    @Column(name = "\"create_time\"")
    private Date createTime; //建立時間

    @Column(name = "\"modify_time\"")
    private Date modifyTime; //更新時間

    @Column(name = "\"creator_id\"")
    private Long creator; //建立者

    @Column(name = "\"modifier_id\"")
    private Long modifier; //更新者

    @Column(name = "\"deletemark\"")
    private Boolean deleteMark; //刪除註記

    public WgIcdCode() {
    }

    public WgIcdCode(Long id) {
        this.id = id;
    }

    public WgIcdCode(String code, String pureCode, String name, String enName, Date createTime, Date modifyTime, Long creator, Long modifier, Boolean deleteMark) {
        this.code = code;
        this.pureCode = pureCode;
        this.name = name;
        this.enName = enName;
        this.createTime = createTime;
        this.modifyTime = modifyTime;
        this.creator = creator;
        this.modifier = modifier;
        this.deleteMark = deleteMark;
    }

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getPureCode() {
        return pureCode;
    }

    public void setPureCode(String pureCode) {
        this.pureCode = pureCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEnName() {
        return enName;
    }

    public void setEnName(String enName) {
        this.enName = enName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public Long getCreator() {
        return creator;
    }

    public void setCreator(Long creator) {
        this.creator = creator;
    }

    public Long getModifier() {
        return modifier;
    }

    public void setModifier(Long modifier) {
        this.modifier = modifier;
    }

    public Boolean getDeleteMark() {
        return deleteMark;
    }

    public void setDeleteMark(Boolean deleteMark) {
        this.deleteMark = deleteMark;
    }

    @Override
    public String toString() {
        return "WgIcdCode{" + "id=" + id + ", code=" + code + ", pureCode=" + pureCode + ", name=" + name + ", enName=" + enName + ", createTime=" + createTime + ", modifyTime=" + modifyTime + ", creator=" + creator + ", modifier=" + modifier + ", deleteMark=" + deleteMark + '}';
    }
}
