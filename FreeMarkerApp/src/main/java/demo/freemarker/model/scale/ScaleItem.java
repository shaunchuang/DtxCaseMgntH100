package demo.freemarker.model.scale;

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
@Table(name = "\"scale_item\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ScaleItem.findByScaleId", query = "SELECT s FROM ScaleItem s WHERE s.scaleId = :scaleId AND s.deleteMark = 0 AND s.evaluationType IS NULL ORDER BY s.id ASC"),
    @NamedQuery(name = "ScaleItem.findByScaleIdAndSectionId", query = "SELECT s FROM ScaleItem s WHERE s.scaleId = :scaleId AND s.deleteMark = 0 AND s.sectionId = :sectionId AND s.evaluationType IS NULL ORDER BY s.id ASC"),
    @NamedQuery(name = "ScaleItem.findByChildScaleItemId", query = "SELECT s FROM ScaleItem s WHERE s.parentItemId = :parentItemId AND s.deleteMark = 0 AND s.evaluationType IS NULL ORDER BY s.id ASC"),
    @NamedQuery(name = "ScaleItem.findById", query = "SELECT s FROM ScaleItem s WHERE s.id = :id AND s.deleteMark = 0"),
    @NamedQuery(name = "ScaleItem.findParentItemNo", query = "SELECT si FROM ScaleItem si  WHERE si.deleteMark=0 AND si.id = :childItemId AND si.parentItemId IS NOT NULL")
})
public class ScaleItem implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 7894652L;

    @Id
    @Column(name = "\"id\"", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "\"scale_id\"", nullable = false)
    private Long scaleId;
    
    @Column(name = "\"scale_section_id\"", nullable = true)
    private Long sectionId;
    
    @Column(name = "\"parent_item_id\"", nullable = true)
    private Long parentItemId;
    
    @Column(name = "\"item_type\"", nullable = true, length=50)
    private String itemType;
    
    @Column(name = "\"item_no\"", nullable=true)
    private Long itemNo;
    
    @Column(name = "\"question\"", nullable=true, length=500)
    private String question;
    
    @Column(name = "\"evaluation_type\"", nullable=true, length=50)
    private String evaluationType;
    
    @Column(name = "\"has_result_level\"", unique = false, nullable = false)
    private Boolean hasResultLevel = false;
    
    @Column(name = "\"score_min\"", unique = false, nullable = true, length = 20)
    private int scoreMin;
    
    @Column(name = "\"score_max\"", unique = false, nullable = true, length = 20)
    private int scoreMax;
    
    @Column(name = "\"label_left\"", nullable=true, length=20)
    private String labelLeft;
    
    @Column(name = "\"label_right\"", nullable=true, length=20)
    private String labelRight;
    
    @Column(name = "\"is_single_choice\"", unique = false, nullable = false)
    private Boolean isSingleChoice;
    
    @Column(name = "\"horizontal_view\"", unique = false, nullable = true)
    private Boolean horizontalView; // 是否為橫向顯示

    @Column(name = "\"note\"", nullable = true, length=200)
    private String note;
            
    @Column(name = "\"create_time\"")
    private Date createTime; // 建立時間

    @Column(name = "\"creator\"")
    private Long creator; // 建立者

    @Column(name = "\"modifier\"")
    private Long modifier;

    @Column(name = "\"modified_time\"")
    private Date modifiedTime; // 更新時間

    @Column(name = "\"delete_mark\"")
    private Integer deleteMark; // 刪除標記


    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getScaleId() {
        return scaleId;
    }

    public void setScaleId(Long scaleId) {
        this.scaleId = scaleId;
    }

    public Long getSectionId() {
        return sectionId;
    }

    public void setSectionId(Long sectionId) {
        this.sectionId = sectionId;
    }

    public Long getParentItemId() {
        return parentItemId;
    }

    public void setParentItemId(Long parentItemId) {
        this.parentItemId = parentItemId;
    }

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
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

    public String getEvaluationType() {
        return evaluationType;
    }

    public void setEvaluationType(String evaluationType) {
        this.evaluationType = evaluationType;
    }

    public Boolean getHasResultLevel() {
        return hasResultLevel;
    }

    public void setHasResultLevel(Boolean hasResultLevel) {
        this.hasResultLevel = hasResultLevel;
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
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

    public Date getModifiedTime() {
        return modifiedTime;
    }

    public void setModifiedTime(Date modifiedTime) {
        this.modifiedTime = modifiedTime;
    }

    public Integer getDeleteMark() {
        return deleteMark;
    }

    public void setDeleteMark(Integer deleteMark) {
        this.deleteMark = deleteMark;
    }

}
