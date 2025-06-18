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
}
