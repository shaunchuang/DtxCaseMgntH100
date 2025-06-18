package demo.freemarker.model.scale;

import itri.sstc.framework.core.database.IntIdDataEntity;
import java.io.Serializable;

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
@Table(name = "\"scale_item_option\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ScaleItemOption.findByScaleItemId", query = "SELECT s FROM ScaleItemOption s WHERE s.scaleItemId = :scaleItemId ORDER BY s.id ASC")
})
public class ScaleItemOption implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 17846578465L;

    @Id
    @Column(name = "\"id\"", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "\"scale_item_id\"", nullable = false)
    private Long scaleItemId;

    @Column(name = "\"option_no\"", nullable = true)
    private Long optionNo;
    
    @Column(name = "\"option_text\"", nullable = false, length = 500)
    private String optionText;
   
    @Column(name = "\"score\"", nullable = false)
    private Integer score;
    
    @Column(name = "\"is_desc_option\"", nullable = false)
    private Boolean isDescOption = false;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getScaleItemId() {
        return scaleItemId;
    }

    public void setScaleItemId(Long scaleItemId) {
        this.scaleItemId = scaleItemId;
    }

    public Long getOptionNo() {
        return optionNo;
    }

    public void setOptionNo(Long optionNo) {
        this.optionNo = optionNo;
    }

    public String getOptionText() {
        return optionText;
    }

    public void setOptionText(String optionText) {
        this.optionText = optionText;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Boolean getIsDescOption() {
        return isDescOption;
    }

    public void setIsDescOption(Boolean isDescOption) {
        this.isDescOption = isDescOption;
    }



}
