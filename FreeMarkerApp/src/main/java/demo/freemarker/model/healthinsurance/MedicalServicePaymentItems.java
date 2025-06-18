package demo.freemarker.model.healthinsurance;

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

import itri.sstc.framework.core.database.IntIdDataEntity;

@Entity
@Table(name = "\"medical_service_payment_items\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MedicalServicePaymentItems.findAll", query = "SELECT m FROM MedicalServicePaymentItems m"),
    @NamedQuery(name = "MedicalServicePaymentItems.findById", query = "SELECT m FROM MedicalServicePaymentItems m WHERE m.id = :id"),
    @NamedQuery(name = "MedicalServicePaymentItems.findByCode", query = "SELECT m FROM MedicalServicePaymentItems m WHERE m.code LIKE :code AND m.deleteMark = false ORDER BY m.id ASC"),
    @NamedQuery(name = "MedicalServicePaymentItems.findInfoByCode", query = "SELECT m FROM MedicalServicePaymentItems m WHERE m.deleteMark = 0 AND m.code = :code"),
    @NamedQuery(name = "MedicalServicePaymentItems.findByItem", query = "SELECT m FROM MedicalServicePaymentItems m WHERE (m.zhItem LIKE :item OR m.enItem LIKE :item) AND m.deleteMark = false ORDER BY m.id ASC"),
    @NamedQuery(name = "MedicalServicePaymentItems.findByCodeAndItem", 
            query = "SELECT m FROM MedicalServicePaymentItems m WHERE (m.code LIKE :code OR m.zhItem LIKE :item) AND m.deleteMark = false ORDER BY m.id ASC")
})
public class MedicalServicePaymentItems implements IntIdDataEntity, Serializable {
    
    private static final long serialVersionUID = 18451238465132L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(name = "\"code\"", length = 20)
    String code;

    @Column(name = "\"points\"")
    int points;

    @Column(name = "\"begin_date\"", length = 20)
    String beginDate;

    @Column(name = "\"end_date\"", length = 20)
    String endDate;

    @Column(name = "\"zh_item\"")
    String zhItem;

    @Column(name = "\"en_item\"")
    String enItem;
    
    @Column(name = "\"note\"")
    String note;

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

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getZhItem() {
        return zhItem;
    }

    public void setZhItem(String zhItem) {
        this.zhItem = zhItem;
    }

    public String getEnItem() {
        return enItem;
    }

    public void setEnItem(String enItem) {
        this.enItem = enItem;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
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

}
