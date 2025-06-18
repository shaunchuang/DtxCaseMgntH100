package demo.freemarker.dao.scale;

import demo.freemarker.model.scale.Scale;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

public class ScaleDAO  extends IntIdBaseDAO {

    final static ScaleDAO instance = new ScaleDAO("DTXCASEMGNT_PU");

    public final static ScaleDAO getInstance() {
        return instance;
    }

    private ScaleDAO(String puName) {
        super(puName, Scale.class);
    }

    @Override
    public String getTableName() {
        return "Scale";
    }

    public List<Scale> findByParam(String param) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Scale.findByParam");
            q.setParameter("param", param);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<Scale>();
        } finally {
            em.close();
        }
    }

    public List<Scale> findByCategory(String category) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Scale.findByCategory");
            q.setParameter("category", category);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<Scale>();
        } finally {
            em.close();
        }
    }
    
    public List<Scale> listTodateAddScale(Long patientId, Date evalDate) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Scale.listTodateAddScale");
            q.setParameter("patientId", patientId);
            q.setParameter("evalDate", evalDate);
            return q.getResultList();
        } catch (Exception e) {
            return new ArrayList<Scale>();
        } finally {
            em.close();
        }
    }
    
    public List<Scale> listWithoutDeleteMark () {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Scale.listWithoutDeleteMark");
            return q.getResultList();
        } catch (Exception e) {
            return new ArrayList<Scale>();
        } finally {
            em.close();
        }
    }

    public List<Scale> listByIds(List<Long> ids) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Scale.listByIds");
            q.setParameter("ids", ids);
            return q.getResultList();
        } catch (Exception e) {
            return new ArrayList<Scale>();
        } finally {
            em.close();
        }
    }

    public List<Scale> listNotInIds(List<Long> ids) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Scale.listNotInIds");
            q.setParameter("ids", ids);
            return q.getResultList();
        } catch (Exception e) {
            return new ArrayList<Scale>();
        } finally {
            em.close();
        }
    }
    
    public List<Scale> listSortByCat(boolean deleteMark) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("Scale.listSortByCat");
            q.setParameter("deleteMark", deleteMark);
            return q.getResultList();
        } catch (Exception e) {
            return new ArrayList<Scale>();
        } finally {
            em.close();
        }
    }
}

