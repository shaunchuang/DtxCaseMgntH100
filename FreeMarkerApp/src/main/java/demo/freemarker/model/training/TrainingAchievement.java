package demo.freemarker.model.training;

import itri.sstc.framework.core.database.IntIdDataEntity;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;

@Entity
@XmlRootElement
@Table(name = "\"training_achievement\"")
@NamedQueries({
    @NamedQuery(name = "TrainingAchievement.findByRecordId", query = "SELECT t FROM TrainingAchievement t WHERE t.recordId = :recordId"),
})
public class TrainingAchievement implements IntIdDataEntity, Serializable {
    private static final long serialVersionUID = -1009539150250204165L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "\"record_id\"", nullable = false)
    private Long recordId; // 訓練記錄ID

    @Column(name = "\"achievement_apiname\"", nullable = true)
    private String achievementApiName; // 成就API名稱

    @Column(name = "\"unlock_time\"")
    private Date unlockedTime;

    public TrainingAchievement() {}

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

    public String getAchievementApiName() {
        return achievementApiName;
    }

    public void setAchievementApiName(String achievementApiName) {
        this.achievementApiName = achievementApiName;
    }

    public Date getUnlockedTime() {
        return unlockedTime;
    }

    public void setUnlockedTime(Date unlockedTime) {
        this.unlockedTime = unlockedTime;
    }

    
}
