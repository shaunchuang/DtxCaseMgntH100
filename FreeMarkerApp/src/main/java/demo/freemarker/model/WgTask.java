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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "\"wg_task\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "WgTask.findByCreator", query = "SELECT task FROM WgTask task WHERE task.creator = :creator"),
    @NamedQuery(name = "WgTask.findByCaseNoAndCreator", query = "SELECT task FROM WgTask task WHERE task.caseNo = :caseNo AND task.creator = :creator"),
    @NamedQuery(name = "WgTask.findByCaseNoAndCreatorAndisChecked", query = "SELECT task FROM WgTask task WHERE task.caseNo = :caseNo AND task.creator = :creator AND task.checkinTime IS NOT NULL"),
    @NamedQuery(name = "WgTask.findBySlotId", query = "SELECT task FROM WgTask task WHERE task.availableSlotId = :availableSlotId"),
    @NamedQuery(name = "WgTask.findByUserAndCat", query = "SELECT task FROM WgTask task WHERE task.cat = :cat AND task.creator = :creator")
})
public class WgTask implements IntIdDataEntity, Serializable {
    private static final long serialVersionUID = 6895651421520312351L;
	
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

    @Column(name = "\"create_time\"")
	private Date createTime; //建立時間

    @Column(name = "\"modify_time\"")
	private Date modifyTime; //更新時間

    @Column(name = "\"creator_id\"")
	private Long creator; //建立者

    @Column(name = "\"modifier_id\"")
	private Long modifier; //更新者

    @Column(name = "\"delete_mark\"")
	private Boolean deleteMark; //刪除註記

    @Column(name = "\"cat\"")
	private int cat; //任務類型(醫師/治療師)

    @Column(name = "\"case_no\"")
	private Long caseNo;	//個案表單號

    @Column(name = "\"collaborate_ids\"")
	private String collaborateIds; //協同人員

    @Column(name = "\"note\"")
	private String note;	//相關備註

    @Column(name = "\"available_slot_id\"")
	private Long availableSlotId; //預約時段id
    
    @Column(name = "\"checkin_time\"")
    @Temporal(TemporalType.TIME)
	private Date checkinTime; //實際報到時間

    public WgTask() {
    }

    public WgTask(Long id) {
        this.id = id;
    }

    public WgTask(Date createTime, Date modifyTime, Long creator, Long modifier, Boolean deleteMark, int cat, Long caseNo, String collaborateIds, String note, Long availableSlotId, Date checkinTime) {
        this.createTime = createTime;
        this.modifyTime = modifyTime;
        this.creator = creator;
        this.modifier = modifier;
        this.deleteMark = deleteMark;
        this.cat = cat;
        this.caseNo = caseNo;
        this.collaborateIds = collaborateIds;
        this.note = note;
        this.availableSlotId = availableSlotId;
        this.checkinTime = checkinTime;
    }

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
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

    public int getCat() {
        return cat;
    }

    public void setCat(int cat) {
        this.cat = cat;
    }

    public Long getCaseNo() {
        return caseNo;
    }

    public void setCaseNo(Long caseNo) {
        this.caseNo = caseNo;
    }

    public String getCollaborateIds() {
        return collaborateIds;
    }

    public void setCollaborateIds(String collaborateIds) {
        this.collaborateIds = collaborateIds;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Long getAvailableSlotId() {
        return availableSlotId;
    }
    
    public void setAvailableSlotId(Long availableSlotId) {
        this.availableSlotId = availableSlotId;
    }

    public Date getCheckinTime() {
        return checkinTime;
    }

    public void setCheckinTime(Date checkinTime) {
        this.checkinTime = checkinTime;
    }

    public String toString() {
        return "WgTask [id=" + id + ", createTime=" + createTime + ", modifyTime=" + modifyTime + ", creator=" + creator + ", modifier=" + modifier + ", deleteMark=" + deleteMark + ", cat=" + cat + ", caseNo=" + caseNo + ", collaborateIds=" + collaborateIds + ", note=" + note + ", availableSlotId=" + availableSlotId + ", checkinTime=" + checkinTime + "]";
    }
}