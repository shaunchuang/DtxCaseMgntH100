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
@Table(name = "\"scale_section\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ScaleSection.findByScaleId", query = "SELECT s FROM ScaleSection s WHERE s.deleteMark = 0 AND s.scaleId = :scaleId ORDER BY s.id ASC")
})
public class ScaleSection implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 1234747890L;

    @Id
    @Column(name = "\"id\"", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "\"section_no\"", nullable = true)
    private Long sectionNo;

    @Column(name = "\"name\"", nullable = false)
    private String name;
    
    @Column(name = "\"note\"", length = 4000, nullable = true)
    private String note;

    @Column(name = "\"scale_id\"", nullable = false)
    private Long scaleId;
    
    @Column(name = "\"create_time\"", nullable = true)
    private Date createTime; // 建立時間

    @Column(name = "\"creator\"", nullable = true)
    private Long creator; // 建立者

    @Column(name = "\"modifier\"", nullable = true)
    private Long modifier;

    @Column(name = "\"modified_time\"", nullable = true)
    private Date modifiedTime; // 更新時間

    @Column(name = "\"delete_mark\"", nullable = true)
    private Integer deleteMark; // 刪除標記

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getSectionNo() {
        return sectionNo;
    }

    public void setSectionNo(Long sectionNo) {
        this.sectionNo = sectionNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Long getScaleId() {
        return scaleId;
    }

    public void setScaleId(Long scaleId) {
        this.scaleId = scaleId;
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
