package demo.freemarker.dao.training;

import itri.sstc.framework.core.database.IntIdBaseDAO;
import javax.persistence.EntityManager;
import javax.persistence.Query;

import demo.freemarker.model.training.PlanLessonMapping;

import java.util.List;
import java.util.ArrayList;

public class PlanLessonMappingDAO extends IntIdBaseDAO {

    private static final PlanLessonMappingDAO instance = new PlanLessonMappingDAO("DTXCASEMGNT_PU");

    public static PlanLessonMappingDAO getInstance() {
        return instance;
    }

    private PlanLessonMappingDAO(String puName) {
        super(puName, PlanLessonMapping.class);
    }

    @Override
    public String getTableName() {
        return "PlanLessonMapping";
    }

    /**
     * 透過訓練計畫ID查詢所有對應的課程
     * @param planId 訓練計畫ID
     * @return 訓練計畫課程映射清單
     */
    public List<PlanLessonMapping> findByPlanId(Long planId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("PlanLessonMapping.findByPlanId");
            q.setParameter("planId", planId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
    
    /**
     * 透過訓練計畫ID查詢所有課程ID
     * @param planId 訓練計畫ID
     * @return 課程ID清單
     */
    public List<Long> findLessonIdsByPlanId(Long planId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("PlanLessonMapping.findLessonIdsByPlanId");
            q.setParameter("planId", planId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    public List<PlanLessonMapping> findPlanLessonMappingByLessonIdAndPlanId(Long lessonId, Long planId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("PlanLessonMapping.findPlanLessonMappingByLessonIdAndPlanId");
            q.setParameter("lessonId", lessonId);
            q.setParameter("planId", planId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
