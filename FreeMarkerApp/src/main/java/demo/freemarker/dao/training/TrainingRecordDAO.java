package demo.freemarker.dao.training;

import itri.sstc.framework.core.database.IntIdBaseDAO;
import javax.persistence.EntityManager;
import javax.persistence.Query;

import demo.freemarker.model.training.TrainingRecord;

import java.util.List;
import java.util.ArrayList;
import java.util.Date;

public class TrainingRecordDAO extends IntIdBaseDAO {

    final static TrainingRecordDAO instance = new TrainingRecordDAO("DTXCASEMGNT_PU");

    public final static TrainingRecordDAO getInstance() {
        return instance;
    }

    private TrainingRecordDAO(String puName) {
        super(puName, TrainingRecord.class);
    }

    @Override
    public String getTableName() {
        return "TrainingRecord";
    }

    public List<TrainingRecord> findByPatientId(Long patientId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("TrainingRecord.findByPatientId");
            q.setParameter("patientId", patientId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<TrainingRecord>();
        } finally {
            em.close();
        }
    }

    public List<TrainingRecord> findByDate(Date trainingDate) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("TrainingRecord.findByDate");
            q.setParameter("trainingDate", trainingDate);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<TrainingRecord>();
        } finally {
            em.close();
        }
    }

    public List<TrainingRecord> findByPatientIdAndDate(Long patientId, Date trainingDate) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("TrainingRecord.findByPatientIdAndDate");
            q.setParameter("patientId", patientId);
            q.setParameter("trainingDate", trainingDate);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<TrainingRecord>();
        } finally {
            em.close();
        }
    }

    public List<TrainingRecord> findByPlanLessonId(Long planLessonId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("TrainingRecord.findByPlanLessonId");
            q.setParameter("planLessonId", planLessonId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<TrainingRecord>();
        } finally {
            em.close();
        }
    }
}
