package demo.freemarker.dao;

import demo.freemarker.model.DrugUseStatusCategory;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * 毒品使用狀態分類 DAO
 */
public class DrugUseStatusCategoryDAO extends IntIdBaseDAO {
    final static DrugUseStatusCategoryDAO instance = new DrugUseStatusCategoryDAO("DTXCASEMGNT_PU");

    public final static DrugUseStatusCategoryDAO getInstance() {
        return instance;
    }

    private DrugUseStatusCategoryDAO(String puName) {
        super(puName, DrugUseStatusCategory.class);
    }

    @Override
    public String getTableName() {
        return "drug_use_status_category";
    }

    @SuppressWarnings("unchecked")
    public List<DrugUseStatusCategory> findByName(String name) {
        EntityManager em = super.getEntityManager();
        try {
            Query q = em.createQuery("SELECT d FROM DrugUseStatusCategory d WHERE d.name = :name");
            q.setParameter("name", name);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
