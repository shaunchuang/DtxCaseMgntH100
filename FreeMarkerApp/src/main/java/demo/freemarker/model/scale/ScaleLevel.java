/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.model.scale;

import demo.freemarker.core.StringUtils;
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

/**
 *
 * @author zhush
 */
@Entity
@Table(name = "\"scale_level\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ScaleLevel.findByScaleId", query = "SELECT s FROM ScaleLevel s WHERE s.scaleId = :scaleId ORDER BY s.id ASC"),
    @NamedQuery(name = "ScaleLevel.findByScore", query = "SELECT s FROM ScaleLevel s WHERE s.scaleId = :scaleId AND :score BETWEEN s.lowScore AND s.highScore ORDER BY s.id ASC"),
})
public class ScaleLevel implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 78454523L;

    @Id
    @Column(name = "\"id\"", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "\"scale_id\"", nullable = false)
    private Long scaleId;

    @Column(name = "\"scale_item_id\"", nullable = true)
    private Long scaleItemId;

    @Column(name = "\"low_score\"", nullable = false)
    private Integer lowScore;

    @Column(name = "\"high_score\"", nullable = false)
    private Integer highScore;

    @Column(name = "\"level\"", length = 30, nullable = false)
    private String level;

    @Column(name = "\"color\"", length = 10, nullable = false)
    private String color;

    @Column(name = "\"bg_color\"", length = 10, nullable = true)
    private String bgColor;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getScaleId() {
        return scaleId;
    }

    public void setScaleId(Long scaleId) {
        this.scaleId = scaleId;
    }

    public Integer getLowScore() {
        return lowScore;
    }

    public void setLowScore(Integer lowScore) {
        this.lowScore = lowScore;
    }

    public Integer getHighScore() {
        return highScore;
    }

    public void setHighScore(Integer highScore) {
        this.highScore = highScore;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getBgColor() {
        return bgColor;
    }

    public void setBgColor(String bgColor) {
        this.bgColor = bgColor;
    }

    public void format() {
        this.level = StringUtils.isEmpty(this.level) ? null : StringUtils.trim(this.level);
    }
}
