package demo.freemarker.model.training;

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
@Table(name = "\"achievement_goal\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AchievementGoal.findAll", query = "SELECT a FROM AchievementGoal a"),
    @NamedQuery(name = "AchievementGoal.findByMappingId", query = "SELECT a FROM AchievementGoal a WHERE a.mappingId = :mappingId")
})
public class AchievementGoal implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 68956514850312351L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "\"mapping_id\"")
    private Long mappingId; // 訓練計畫與課程的對應ID

    @Column(name = "\"api_name\"")
    private String apiName; // API名稱

    public AchievementGoal() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getMappingId() {
        return mappingId;
    }

    public void setMappingId(Long mappingId) {
        this.mappingId = mappingId;
    }

    public String getApiName() {
        return apiName;
    }

    public void setApiName(String apiName) {
        this.apiName = apiName;
    }
}
