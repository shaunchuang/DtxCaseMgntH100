package demo.freemarker.dao.training;

import itri.sstc.framework.core.database.IntIdBaseDAO;
import javax.persistence.EntityManager;
import javax.persistence.Query;

import demo.freemarker.model.training.StatisticsGoal;

import java.util.List;
import java.util.ArrayList;

public class StatisticsGoalDAO extends IntIdBaseDAO {

    final static StatisticsGoalDAO instance = new StatisticsGoalDAO("DTXCASEMGNT_PU");

    public final static StatisticsGoalDAO getInstance() {
        return instance;
    }

    private StatisticsGoalDAO(String puName) {
        super(puName, StatisticsGoal.class);
    }

    @Override
    public String getTableName() {
        return "StatisticsGoal";
    }

    /**
     * 透過訓練計畫ID查詢所有對應的課程
     * @param planId 訓練計畫ID
     * @return 訓練計畫課程映射清單
     */
    public List<StatisticsGoal> findByMappingId(Long mappingId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("StatisticsGoal.findByMappingId");
            q.setParameter("mappingId", mappingId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
