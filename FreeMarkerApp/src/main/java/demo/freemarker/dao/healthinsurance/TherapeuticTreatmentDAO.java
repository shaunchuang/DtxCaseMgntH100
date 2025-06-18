package demo.freemarker.dao.healthinsurance;
 
import itri.sstc.framework.core.database.IntIdBaseDAO;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

import demo.freemarker.model.healthinsurance.TherapeuticTreatment;

public class TherapeuticTreatmentDAO extends IntIdBaseDAO {
    
    final static TherapeuticTreatmentDAO instance = new TherapeuticTreatmentDAO("DTXCASEMGNT_PU");

    public final static TherapeuticTreatmentDAO getInstance() {
        return instance;
    }

    private TherapeuticTreatmentDAO(String puName) {
        super(puName, TherapeuticTreatment.class);
    }

    @Override
    public String getTableName() {
        return "TherapeuticTreatment";
    }
    
    public List<TherapeuticTreatment> findByHiRecordId(Long hiRecordId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("TherapeuticTreatment.findByHiRecordId");
            q.setParameter("hiRecordId", hiRecordId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<TherapeuticTreatment>();
        } finally {
            em.close();
        }
    }

    public List<TherapeuticTreatment> findByExecutiveId(Long executiveId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("TherapeuticTreatment.findByExecutiveId");
            q.setParameter("executiveId", executiveId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<TherapeuticTreatment>();
        } finally {
            em.close();
        }
    }
}
