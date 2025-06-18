package demo.freemarker.dao;
 
import demo.freemarker.model.Patient;
import itri.sstc.framework.core.database.IntIdBaseDAO;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

public class PatientDAO extends IntIdBaseDAO {
    
    final static PatientDAO instance = new PatientDAO("DTXCASEMGNT_PU");

    public final static PatientDAO getInstance() {
        return instance;
    }

    private PatientDAO(String puName) {
        super(puName, Patient.class);
    }

    @Override
    public String getTableName() {
        return "Patient";
    }
    
    public List<Patient> listPatient(String param) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Patient.findAll");
            q.setParameter("name", param);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<Patient>();
        } finally {
            em.close();
        }
    }

    public Patient findByIdno(String param) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Patient.findByIdno");
            q.setParameter("idno", param);
            return (Patient) q.getSingleResult();
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }

    public Patient findByUserId(Long id) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Patient.findByUserId");
            q.setParameter("userId", id);
            return (Patient) q.getSingleResult();
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }
}
