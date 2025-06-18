package demo.freemarker.dao.training;

import itri.sstc.framework.core.database.IntIdBaseDAO;
import javax.persistence.EntityManager;
import javax.persistence.Query;

import demo.freemarker.model.training.TrainingAchievement;

import java.util.List;
import java.util.ArrayList;

public class TrainingAchievementDAO extends IntIdBaseDAO {

    final static TrainingAchievementDAO instance = new TrainingAchievementDAO("DTXCASEMGNT_PU");

    public final static TrainingAchievementDAO getInstance() {
        return instance;
    }

    private TrainingAchievementDAO(String puName) {
        super(puName, TrainingAchievement.class);
    }

    @Override
    public String getTableName() {
        return "TrainingAchievement";
    }

    public List<TrainingAchievement> findByRecordId(Long recordId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("TrainingAchievement.findByRecordId");
            q.setParameter("recordId", recordId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
