package demo.freemarker.dao;

import demo.freemarker.model.SpeechDevIssueCategory;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * 語言發展問題分類 DAO
 */
public class SpeechDevIssueCategoryDAO extends IntIdBaseDAO {
    final static SpeechDevIssueCategoryDAO instance = new SpeechDevIssueCategoryDAO("DTXCASEMGNT_PU");

    public final static SpeechDevIssueCategoryDAO getInstance() {
        return instance;
    }

    private SpeechDevIssueCategoryDAO(String puName) {
        super(puName, SpeechDevIssueCategory.class);
    }

    @Override
    public String getTableName() {
        return "speech_dev_issue_category";
    }

    @SuppressWarnings("unchecked")
    public List<SpeechDevIssueCategory> findByName(String name) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createQuery("SELECT s FROM SpeechDevIssueCategory s WHERE s.name = :name");
            q.setParameter("name", name);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
