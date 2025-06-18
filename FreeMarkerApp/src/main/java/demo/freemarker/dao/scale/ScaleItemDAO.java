/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.dao.scale;

import demo.freemarker.model.scale.ScaleItem;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 *
 * @author zhush
 */
public class ScaleItemDAO extends IntIdBaseDAO {
    
    final static ScaleItemDAO instance = new ScaleItemDAO("DTXCASEMGNT_PU");

    public final static ScaleItemDAO getInstance() {
        return instance;
    }

    private ScaleItemDAO(String puName) {
        super(puName, ScaleItem.class);
    }

    @Override
    public String getTableName() {
        return "ScaleItem";
    }

    public List<ScaleItem> findByScaleId(Long scaleId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ScaleItem.findByScaleId");
            q.setParameter("scaleId", scaleId);
            return q.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<ScaleItem>(); 
        } finally {
            em.close();
        }
    }

    public List<ScaleItem> findByScaleIdAndSectionId(Long scaleId, Long sectionId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ScaleItem.findByScaleIdAndSectionId");
            q.setParameter("scaleId", scaleId);
            q.setParameter("sectionId", sectionId);
            return q.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<ScaleItem>(); 
        } finally {
            em.close();
        }
    }

    public List<ScaleItem> findByChildScaleItemId(Long parentItemId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ScaleItem.findByChildScaleItemId");
            q.setParameter("parentItemId", parentItemId);
            return q.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<ScaleItem>(); 
        } finally {
            em.close();
        }
    }

    public ScaleItem findById(Long id) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ScaleItem.findById");
            q.setParameter("id", id);
            return (ScaleItem)q.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null; 
        } finally {
            em.close();
        }
    }
    
    public Long findParentItemNo(Long childItemId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ScaleItem.findParentItemNo");
            q.setParameter("childItemId", childItemId);
            ScaleItem scaleItem = (ScaleItem)q.getSingleResult();
            scaleItem = this.findById(scaleItem.getParentItemId());
            return scaleItem.getItemNo();
        } catch (Exception e) {
            return null; 
        } finally {
            em.close();
        }
    }
}
