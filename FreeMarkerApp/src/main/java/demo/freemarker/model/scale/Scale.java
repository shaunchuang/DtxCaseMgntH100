package demo.freemarker.model.scale;

import demo.freemarker.core.MessageSource;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.io.Serializable;
import java.util.Arrays;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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
@Table(name = "\"scale\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Scale.findByName", query = "SELECT a FROM Scale a WHERE a.name = :name"),
    @NamedQuery(name = "Scale.findByType", query = "SELECT a FROM Scale a WHERE a.type = :type"),
    @NamedQuery(name = "Scale.findByParam", query = "SELECT a FROM Scale a WHERE a.deleteMark = 0 AND (a.name LIKE :param OR a.description LIKE :param) ORDER BY a.id ASC"),
    @NamedQuery(name = "Scale.findByCategory", query = "SELECT a FROM Scale a WHERE a.deleteMark = 0 AND a.category = :category ORDER BY a.id ASC"),
    @NamedQuery(name = "Scale.findByParam", query = "SELECT a FROM Scale a WHERE a.deleteMark = 0 AND (a.name LIKE :param OR a.description LIKE :param) ORDER BY a.id ASC"),
    @NamedQuery(name = "Scale.listWithoutDeleteMark", query = "SELECT a FROM Scale a WHERE a.deleteMark = 0 ORDER BY a.id ASC") ,
    @NamedQuery(name = "Scale.listByIds", query = "SELECT a FROM Scale a WHERE a.deleteMark = 0 AND a.id IN :ids ORDER BY a.id ASC"),
    @NamedQuery(name = "Scale.listNotInIds", query = "SELECT a FROM Scale a WHERE a.deleteMark = 0 AND a.id NOT IN :ids ORDER BY a.id ASC"),
    @NamedQuery(name = "Scale.listSortByCat", query = "SELECT a FROM Scale a WHERE a.deleteMark = :deleteMark ORDER BY a.category ASC")
})
public class Scale implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 4152387452L;

    @Id
    @Column(name = "\"id\"", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "\"category\"", nullable = false, length = 5)
    private String category; // 治療類別

    @Column(name = "\"name\"", nullable = false, length = 50 )
    private String name; // 評估名稱

    @Column(name = "\"type\"", nullable = false, length = 20 )
    private String type; // 評估類型

    @Column(name = "\"description\"", nullable = true, length = 500)
    private String description;

    @Column(name = "\"evaluator\"", nullable = false, length = 5)
    private String evaluator; // 評估者
    
    @Column(name = "\"version\"", nullable = false, length = 10)
    private String version;

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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEvaluator() {
        return evaluator;
    }

    public void setEvaluator(String evaluator) {
        this.evaluator = evaluator;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
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
    
    	public static final class TreatmentType {
        public static final String TYPE_PT = "PT";  //物理治療
        public static final String TYPE_OT = "OT";  //職能治療
        public static final String TYPE_PS = "PS";  //心理治療
        public static final String TYPE_ST = "ST";  //語言治療
        public static final List<String> LIST_TYPE = Arrays.asList(new String[] { TYPE_PT, TYPE_OT, TYPE_PS, TYPE_ST});

        public static final Map<String, String> getListMap(Locale locale) {
            Map<String, String> _data = new LinkedHashMap<String, String>();
            _data.put(TYPE_PT, MessageSource.getMessage("treatment.pt", locale));
            _data.put(TYPE_OT, MessageSource.getMessage("treatment.ot", locale));
            _data.put(TYPE_PS, MessageSource.getMessage("treatment.ps", locale));
            _data.put(TYPE_ST, MessageSource.getMessage("treatment.st", locale));
            return _data;
        }
        
        public static final Map<String, String> getAbbrListMap(Locale locale) {
            Map<String, String> _data = new LinkedHashMap<String, String>();
            _data.put(TYPE_PT, MessageSource.getMessage("treatment.abbr.pt", locale));
            _data.put(TYPE_OT, MessageSource.getMessage("treatment.abbr.ot", locale));
            _data.put(TYPE_PS, MessageSource.getMessage("treatment.abbr.ps", locale));
            _data.put(TYPE_ST, MessageSource.getMessage("treatment.abbr.st", locale));
            return _data;
        }

    }
}
