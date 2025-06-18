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
@Table(name = "\"training_statistics\"")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TrainingStatistics.findByRecordId", query = "SELECT t FROM TrainingStatistics t WHERE t.recordId = :recordId"),
})
public class TrainingStatistics implements IntIdDataEntity, Serializable {
    
    private static final long serialVersionUID = 68956514850312745L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "\"record_id\"", nullable = false)
    private Long recordId; // 訓練記錄ID

    @Column(name = "\"statistics_apiname\"", nullable = true, length = 1000)
    private String statisticsApiName; // 統計項目ID

    @Column(name = "\"stat_value\"", nullable = false)
    private Double statValue; // 統計值

    public TrainingStatistics() {
    }

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getRecordId() {
        return recordId;
    }

    public void setRecordId(Long recordId) {
        this.recordId = recordId;
    }

    public String getStatisticsApiName() {
        return statisticsApiName;
    }

    public void setStatisticsApiName(String statisticsApiName) {
        this.statisticsApiName = statisticsApiName;
    }

    public Double getStatValue() {
        return statValue;
    }

    public void setStatValue(Double statValue) {
        this.statValue = statValue;
    }

    
}
