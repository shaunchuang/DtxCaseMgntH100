package demo.freemarker.dao;

import demo.freemarker.model.OtherPatientInfo;
import demo.freemarker.model.Patient;
import itri.sstc.framework.core.database.IntIdBaseDAO;

import java.util.List;
import javax.persistence.EntityManager;

public class OtherPatientInfoDAO extends IntIdBaseDAO {
    final static OtherPatientInfoDAO instance = new OtherPatientInfoDAO("DTXCASEMGNT_PU");

    public final static OtherPatientInfoDAO getInstance() {
        return instance;
    }

    private OtherPatientInfoDAO(String puName) {
        super(puName, OtherPatientInfo.class);
    }

    @Override
    public String getTableName() {
        return "other_patient_info";
    }

    /**
     * 專門為 OtherPatientInfo 設計的創建方法
     * 確保正確處理 Patient 關聯
     */
    public void createOtherPatientInfo(OtherPatientInfo info, Patient patient) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            
            // 確保 Patient 是 managed 狀態
            Patient managedPatient = em.find(Patient.class, patient.getId());
            if (managedPatient == null) {
                throw new RuntimeException("Patient not found with ID: " + patient.getId());
            }
            
            // 設置關聯
            info.setPatient(managedPatient);
            info.setPatientId(managedPatient.getId()); // 這會自動由 @MapsId 處理
            
            em.persist(info);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Failed to create OtherPatientInfo", ex);
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }


    /**
     * 專門為 OtherPatientInfo 設計的更新方法
     * 避免修改 patientId
     */
    public void editOtherPatientInfo(OtherPatientInfo info) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            
            // 查找現有實體
            OtherPatientInfo existing = em.find(OtherPatientInfo.class, info.getPatientId());
            if (existing == null) {
                throw new RuntimeException("OtherPatientInfo not found with patient ID: " + info.getPatientId());
            }
            
            // 確保不修改 patientId 和 patient 關聯
            info.setPatientId(existing.getPatientId());
            info.setPatient(existing.getPatient());
            
            em.merge(info);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Failed to edit OtherPatientInfo", ex);
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

        /**
     * 根據 Patient ID 查找 OtherPatientInfo
     */
    public OtherPatientInfo findByPatientId(Long patientId) {
        EntityManager em = getEntityManager();
        try {
            return em.find(OtherPatientInfo.class, patientId);
        } finally {
            em.close();
        }
    }


    @SuppressWarnings("unchecked")
    public List<OtherPatientInfo> listOtherPatientInfo() {
        javax.persistence.EntityManager em = null;
        try {
            em = (javax.persistence.EntityManager) super.getEntityManager();
            javax.persistence.Query q = em.createQuery("SELECT o FROM OtherPatientInfo o");
            return q.getResultList();
        } catch (Exception ex) {
            return new java.util.ArrayList<OtherPatientInfo>();
        } finally {
            if (em != null) em.close();
        }
    }
}
