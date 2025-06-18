package demo.freemarker.dao.assessment;

import demo.freemarker.model.assessment.AssessmentSectionResult;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

public class AssessmentSectionResultDAO  extends IntIdBaseDAO  {

    final static AssessmentSectionResultDAO instance = new AssessmentSectionResultDAO("DTXCASEMGNT_PU");

    public final static AssessmentSectionResultDAO getInstance() {
        return instance;
    }

    private AssessmentSectionResultDAO(String puName) {
        super(puName, AssessmentSectionResult.class);
    }

    @Override
    public String getTableName() {
        return "AssessmentResult";
    }

    public List<AssessmentSectionResult> findByAssId(Long assessmentId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("AssessmentSectionResult.findByAssId");
            q.setParameter("assessmentId", assessmentId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<AssessmentSectionResult>();
        } finally {
            em.close();
        }
    }
}
