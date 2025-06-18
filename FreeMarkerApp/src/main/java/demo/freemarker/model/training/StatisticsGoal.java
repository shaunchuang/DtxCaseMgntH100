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
@Table(name = "\"statistics_goal\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "StatisticsGoal.findByMappingId", query = "SELECT s FROM StatisticsGoal s WHERE s.mappingId = :mappingId"),
    @NamedQuery(name = "StatisticsGoal.findByMappingIdAndApiName", query = "SELECT s FROM StatisticsGoal s WHERE s.mappingId = :mappingId AND s.apiName = :apiName")
})
public class StatisticsGoal implements IntIdDataEntity, Serializable {
    
    private static final long serialVersionUID = 68956514850741351L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "\"mapping_id\"", nullable = false)
    private Long mappingId; // 訓練計畫與課程的對應ID

    @Column(name = "\"api_name\"", nullable = false, length = 1000)
    private String apiName; // API名稱

    @Column(name = "\"value_goal\"", nullable = false)
    private String valueGoal;

    public StatisticsGoal() {
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

    public String getValueGoal() {
        return valueGoal;
    }

    public void setValueGoal(String valueGoal) {
        this.valueGoal = valueGoal;
    }
    
}
