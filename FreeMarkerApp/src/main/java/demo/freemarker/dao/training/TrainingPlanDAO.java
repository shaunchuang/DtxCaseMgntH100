package demo.freemarker.dao.training;

import itri.sstc.framework.core.database.IntIdBaseDAO;
import javax.persistence.EntityManager;
import javax.persistence.Query;

import demo.freemarker.model.training.TrainingPlan;

import java.util.List;
import java.util.ArrayList;

public class TrainingPlanDAO extends IntIdBaseDAO {

    final static TrainingPlanDAO instance = new TrainingPlanDAO("DTXCASEMGNT_PU");

    public final static TrainingPlanDAO getInstance() {
        return instance;
    }

    private TrainingPlanDAO(String puName) {
        super(puName, TrainingPlan.class);
    }

    @Override
    public String getTableName() {
        return "TrainingPlan";
    }

    public List<TrainingPlan> findByPatient(Long patientId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("TrainingPlan.findByPatientId");
            q.setParameter("patientId", patientId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<TrainingPlan>();
        } finally {
            em.close();
        }
    }
}
