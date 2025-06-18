package demo.freemarker.dao.assessment;

import demo.freemarker.model.assessment.Assessment;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Date;

public class AssessmentDAO extends IntIdBaseDAO {

    final static AssessmentDAO instance = new AssessmentDAO("DTXCASEMGNT_PU");

    public final static AssessmentDAO getInstance() {
        return instance;
    }

    private AssessmentDAO(String puName) {
        super(puName, Assessment.class);
    }

    @Override
    public String getTableName() {
        return "Assessment";
    }

    public Assessment findByIdAndPatientIdAndTherapistId(Long id, Long patientId, Long therapistId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Assessment.findByIdAndPatientIdAndTherapistId");
            q.setParameter("id", id);
            q.setParameter("patientId", patientId);
            q.setParameter("therapistId", therapistId);
            return (Assessment) q.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public Assessment findByIdAndPatientId(Long id, Long patientId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Assessment.findByIdAndPatientId");
            q.setParameter("id", id);
            q.setParameter("patientId", patientId);
            return (Assessment) q.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public List<Assessment> findByPatientIdAndScaleId(Long patientId, Long scaleId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Assessment.findByPatientIdAndScaleId");
            q.setParameter("patientId", patientId);
            q.setParameter("scaleId", scaleId);
            return q.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<Assessment>();
        } finally {
            em.close();
        }
        
    }

    public List<Assessment> findByScaleId(Long scaleId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Assessment.findByScaleId");
            q.setParameter("scaleId", scaleId);
            return q.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<Assessment>();
        } finally {
            em.close();
        }
    }

    public List<Assessment> findByTherapistId(Long therapistId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Assessment.findByTherapistId");
            q.setParameter("therapistId", therapistId);
            return q.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<Assessment>();
        } finally {
            em.close();
        }
    }

    public List<Assessment> findByPatientIdParamAndEndDate(Long patientId, String param, Date endDate) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Assessment.findByPatientIdParamAndEndDate");
            q.setParameter("patientId", patientId);
            q.setParameter("param", "%" + param + "%");
            q.setParameter("assessmentDate", endDate);
            return q.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<Assessment>();
        } finally {
            em.close();
        }
    }

    public List<Assessment> findByPatientIdParamAndStartEndDate(Long patientId, String param, Date startDate, Date endDate) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Assessment.findByPatientIdParamAndStartEndDate");
            q.setParameter("patientId", patientId);
            q.setParameter("param", "%" + param + "%");
            q.setParameter("startDate", startDate);
            q.setParameter("endDate", endDate);
            return q.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<Assessment>();
        } finally {
            em.close();
        }
    }

    public List<Assessment> findBypatientIdTherapistIdParamAndEndDate(Long patientId, Long therapistId, String param, Date endDate) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Assessment.findBypatientIdTherapistIdParamAndEndDate");
            q.setParameter("patientId", patientId);
            q.setParameter("therapistId", therapistId);
            q.setParameter("param", "%" + param + "%");
            q.setParameter("assessmentDate", endDate);
            return q.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<Assessment>();
        } finally {
            em.close();
        }
    }

    public List<Assessment> findBypatientIdTherapistIdParamAndStartEndDate(Long patientId, Long therapistId, String param, Date startDate, Date endDate) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Assessment.findBypatientIdTherapistIdParamAndStartEndDate");
            q.setParameter("patientId", patientId);
            q.setParameter("therapistId", therapistId);
            q.setParameter("param", "%" + param + "%");
            q.setParameter("startDate", startDate);
            q.setParameter("endDate", endDate);
            return q.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<Assessment>();
        } finally {
            em.close();
        }
    }

    public List<Assessment> listLatestAssessment(Long patientId, Date today) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Assessment.findLatestAssessment");
            q.setParameter("patientId", patientId);
            q.setParameter("today", today);
            return q.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<Assessment>();
        } finally {
            em.close();
        }
    }
    
    public Assessment findLastAssessment(Long patientId, Long scaleId, Date assessmentDate) {
        EntityManager em = getEntityManager();
        try {
            Instant instant = assessmentDate.toInstant();
            ZoneId zone = ZoneId.systemDefault();
            LocalDate localDate = instant.atZone(zone).toLocalDate();
            Timestamp startOfAssDate = Timestamp.valueOf(localDate.atStartOfDay());
            Query q = em.createNamedQuery("Assessment.findLastAssessment");
            q.setParameter("patientId", patientId);
            q.setParameter("scaleId", scaleId);
            q.setParameter("assessmentDate", startOfAssDate);
            List<Assessment> result = q.getResultList();
            if (result != null && !result.isEmpty()) {
                return result.get(0);
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
    
    public List<Assessment> listByTodateAddScale(Long patientId, Date evalDate) {
        EntityManager em = getEntityManager();
        // 建立該天的「00:00:00」
        Calendar cal = Calendar.getInstance();
        cal.setTime(evalDate);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date startOfDay = cal.getTime();

        // 建立隔天的「00:00:00」
        cal.add(Calendar.DAY_OF_MONTH, 1);
        Date startOfNextDay = cal.getTime();
        try {
            Query q = em.createNamedQuery("Assessment.listByTodateAddScale");
            q.setParameter("patientId", patientId);
            q.setParameter("startOfDay", startOfDay);
            q.setParameter("startOfNextDay", startOfNextDay);
            return q.getResultList();
        } catch (Exception e) {
            return new ArrayList<Assessment>();
        } finally {
            em.close();
        }
    }
}