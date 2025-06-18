package demo.freemarker.dao.training;

import itri.sstc.framework.core.database.IntIdBaseDAO;
import javax.persistence.EntityManager;
import javax.persistence.Query;

import demo.freemarker.model.training.AchievementGoal;

import java.util.List;
import java.util.ArrayList;

public class AchievementGoalDAO extends IntIdBaseDAO {

    final static AchievementGoalDAO instance = new AchievementGoalDAO("DTXCASEMGNT_PU");

    public final static AchievementGoalDAO getInstance() {
        return instance;
    }

    private AchievementGoalDAO(String puName) {
        super(puName, AchievementGoal.class);
    }

    @Override
    public String getTableName() {
        return "AchievementGoal";
    }

    /**
     * 透過訓練計畫ID查詢所有對應的課程
     * @param planId 訓練計畫ID
     * @return 訓練計畫課程映射清單
     */
    public List<AchievementGoal> findByfindByMappingId(Long mappingId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("AchievementGoal.findByMappingId");
            q.setParameter("mappingId", mappingId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
