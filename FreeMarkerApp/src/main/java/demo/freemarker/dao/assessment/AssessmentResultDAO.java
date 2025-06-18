package demo.freemarker.dao.assessment;

import demo.freemarker.model.assessment.AssessmentResult;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

public class AssessmentResultDAO extends IntIdBaseDAO {
    
    final static AssessmentResultDAO instance = new AssessmentResultDAO("DTXCASEMGNT_PU");

    public final static AssessmentResultDAO getInstance() {
        return instance;
    }

    private AssessmentResultDAO(String puName) {
        super(puName, AssessmentResult.class);
    }

    @Override
    public String getTableName() {
        return "AssessmentResult";
    }

    public List<AssessmentResult> findByAssIdItemIdOpId(Long assessmentId, Long scaleItemId, Long scaleItemOptionId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("AssessmentResult.findByAssIdItemIdOpId");
            q.setParameter("assessmentId", assessmentId);
            q.setParameter("scaleItemId", scaleItemId);
            q.setParameter("scaleItemOptionId", scaleItemOptionId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<AssessmentResult>();
        } finally {
            em.close();
        }
    }

    public List<AssessmentResult> findByAssIdItemId(Long assessmentId, Long scaleItemId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("AssessmentResult.findByAssIdItemId");
            q.setParameter("assessmentId", assessmentId);
            q.setParameter("scaleItemId", scaleItemId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<AssessmentResult>();
        } finally {
            em.close();
        }
    }

    
}
