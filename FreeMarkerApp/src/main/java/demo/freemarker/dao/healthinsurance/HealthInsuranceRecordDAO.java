package demo.freemarker.dao.healthinsurance;
 
import itri.sstc.framework.core.database.IntIdBaseDAO;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;


import demo.freemarker.model.healthinsurance.HealthInsuranceRecord;

public class HealthInsuranceRecordDAO extends IntIdBaseDAO {
    
    final static HealthInsuranceRecordDAO instance = new HealthInsuranceRecordDAO("DTXCASEMGNT_PU");

    public final static HealthInsuranceRecordDAO getInstance() {
        return instance;
    }

    private HealthInsuranceRecordDAO(String puName) {
        super(puName, HealthInsuranceRecord.class);
    }

    @Override
    public String getTableName() {
        return "HealthInsuranceRecord";
    }
    
    public List<HealthInsuranceRecord> findByPatientId(Long patientId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("HealthInsuranceRecord.findByPatientId");
            q.setParameter("patientId", patientId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<HealthInsuranceRecord>();
        } finally {
            em.close();
        }
    }

    public HealthInsuranceRecord findBySerialNum(String serialNum) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("HealthInsuranceRecord.findBySerialNum");
            q.setParameter("serialNum", serialNum);
            return (HealthInsuranceRecord) q.getSingleResult();
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }
    
    public HealthInsuranceRecord findLatestRecordByPateintId(Long patientId){
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("HealthInsuranceRecord.findLatestRecordByPatientId");
            q.setParameter("patientId", patientId);
            return (HealthInsuranceRecord) q.getSingleResult();
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }

    public HealthInsuranceRecord findLatestRecordByPatientAndCreator(Long patientId, Long creatorId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("HealthInsuranceRecord.findLatestRecordByPatientAndCreator");
            q.setParameter("patientId", patientId);
            q.setParameter("creatorId", creatorId);
            q.setMaxResults(1);
            return (HealthInsuranceRecord) q.getSingleResult();
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }
    
    /**
     * 查詢指定病患的醫師最後看診記錄 (角色ID = 3)
     */
    public HealthInsuranceRecord findLatestDoctorRecordByPatient(Long patientId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("HealthInsuranceRecord.findLatestRecordByPatientAndDoctorRole");
            q.setParameter("patientId", patientId);
            q.setMaxResults(1);
            return (HealthInsuranceRecord) q.getSingleResult();
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }
    
    /**
     * 查詢指定病患的治療師最後看診記錄 (角色ID = 4,5,6,7)
     */
    public HealthInsuranceRecord findLatestTherapistRecordByPatient(Long patientId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("HealthInsuranceRecord.findLatestRecordByPatientAndTherapistRoles");
            q.setParameter("patientId", patientId);
            q.setMaxResults(1);
            return (HealthInsuranceRecord) q.getSingleResult();
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }
    
    /**
     * 查詢指定病患的特定角色最後看診記錄
     */
    public HealthInsuranceRecord findLatestRecordByPatientAndRole(Long patientId, Long roleId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("HealthInsuranceRecord.findLatestRecordByPatientAndSpecificRole");
            q.setParameter("patientId", patientId);
            q.setParameter("roleId", roleId);
            q.setMaxResults(1);
            return (HealthInsuranceRecord) q.getSingleResult();
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }
    
    /**
     * 查詢指定病患的所有醫師看診記錄 (角色ID = 3)
     */
    public List<HealthInsuranceRecord> findDoctorRecordsByPatient(Long patientId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("HealthInsuranceRecord.findLatestRecordByPatientAndDoctorRole");
            q.setParameter("patientId", patientId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<HealthInsuranceRecord>();
        } finally {
            em.close();
        }
    }
    
    /**
     * 查詢指定病患的所有治療師看診記錄 (角色ID = 4,5,6,7)
     */
    public List<HealthInsuranceRecord> findTherapistRecordsByPatient(Long patientId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("HealthInsuranceRecord.findLatestRecordByPatientAndTherapistRoles");
            q.setParameter("patientId", patientId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<HealthInsuranceRecord>();
        } finally {
            em.close();
        }
    }
}
