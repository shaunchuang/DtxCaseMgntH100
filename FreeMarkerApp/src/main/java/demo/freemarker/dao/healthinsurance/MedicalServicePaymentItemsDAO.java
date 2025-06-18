package demo.freemarker.dao.healthinsurance;

import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

import demo.freemarker.model.healthinsurance.MedicalServicePaymentItems;

public class MedicalServicePaymentItemsDAO extends IntIdBaseDAO {

    final static MedicalServicePaymentItemsDAO instance = new MedicalServicePaymentItemsDAO("DTXCASEMGNT_PU");

    public final static MedicalServicePaymentItemsDAO getInstance() {
        return instance;
    }

    private MedicalServicePaymentItemsDAO(String puName) {
        super(puName, MedicalServicePaymentItems.class);
    }

    @Override
    public String getTableName() {
        return "MedicalServicePaymentItems";
    }

    public List<MedicalServicePaymentItems> listMedicalServicePaymentItems() {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("MedicalServicePaymentItems.findAll");
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<MedicalServicePaymentItems>();
        } finally {
            em.close();
        }
    }

    public List<MedicalServicePaymentItems> searchByCode(String code) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("MedicalServicePaymentItems.findByCode");
            q.setParameter("code", "%" + code + "%");
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<MedicalServicePaymentItems>();
        } finally {
            em.close();
        }
    }
    
    public MedicalServicePaymentItems findByCode(String code) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("MedicalServicePaymentItems.findInfoByCode");
            q.setParameter("code", code);
            return (MedicalServicePaymentItems) q.getSingleResult();
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }
    
    public List<MedicalServicePaymentItems> searchByItem(String item) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("MedicalServicePaymentItems.findByItem");
            q.setParameter("item", "%" + item + "%");
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<MedicalServicePaymentItems>();
        } finally {
            em.close();
        }
    }

    public List<MedicalServicePaymentItems> searchByCodeAndItem(String code, String item) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("MedicalServicePaymentItems.findByCodeAndItem");
            q.setParameter("code", "%" + code + "%");
            q.setParameter("item", "%" + item + "%");
            return q.getResultList();
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ArrayList<MedicalServicePaymentItems>();
        } finally {
            em.close();
        }
    }
}