package demo.freemarker.dao;

import demo.freemarker.model.MedicationCategory;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * 藥品分類 DAO
 */
public class MedicationCategoryDAO extends IntIdBaseDAO {
    final static MedicationCategoryDAO instance = new MedicationCategoryDAO("DTXCASEMGNT_PU");

    public final static MedicationCategoryDAO getInstance() {
        return instance;
    }

    private MedicationCategoryDAO(String puName) {
        super(puName, MedicationCategory.class);
    }

    @Override
    public String getTableName() {
        return "medication_category";
    }

    @SuppressWarnings("unchecked")
    public List<MedicationCategory> findByName(String name) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createQuery("SELECT m FROM MedicationCategory m WHERE m.name = :name");
            q.setParameter("name", name);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
