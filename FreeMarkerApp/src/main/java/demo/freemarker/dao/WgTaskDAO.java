package demo.freemarker.dao;

import demo.freemarker.model.WgTask;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;


public class WgTaskDAO extends IntIdBaseDAO {

    final static WgTaskDAO instance = new WgTaskDAO("DTXCASEMGNT_PU");

    public final static WgTaskDAO getInstance() {
        return instance;
    }

    private WgTaskDAO(String puName) {
        super(puName, WgTask.class);
    }

    @Override
    public String getTableName() {
        return "WgTask";
    }

    public List<WgTask> listWgTask(String param) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("WgTask.findAll");
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<WgTask>();
        } finally {
            em.close();
        }
    }

    public List<WgTask> listWgTaskByCreator(Long creator) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("WgTask.findByCreator");
            q.setParameter("creator", creator);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<WgTask>();
        } finally {
            em.close();
        }
    }

    public List<WgTask> listWgTaskByCaseNoAndCreator(Long creator, Long caseNo) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("WgTask.findByCaseNoAndCreator");
            q.setParameter("CaseNo", caseNo);
            q.setParameter("creator", creator);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<WgTask>();
        } finally {
            em.close();
        }
    }

    public List<WgTask> listWgTaskByCaseNoAndCreatorAndisChecked(Long caseNo, Long creator) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("WgTask.findByCaseNoAndCreatorAndisChecked");
            q.setParameter("caseNo", caseNo);
            q.setParameter("creator", creator);

            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<WgTask>();
        } finally {
            em.close();
        }
    }
    
    public WgTask getWgTaskBySlotId(Long slotId){
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("WgTask.findBySlotId");
            q.setParameter("availableSlotId", slotId);
            List<WgTask> list = q.getResultList();
            if (list.size() > 0) {
                return list.get(0);
            } else {
                return null;
            }
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }

    public List<WgTask> listWgTaskByUserAndCat(Long creator, int cat) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("WgTask.findByUserAndCat");
            q.setParameter("cat", cat);
            q.setParameter("creator", creator);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<WgTask>();
        } finally {
            em.close();
        }
    }   
}