/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.dao.scale;

import demo.freemarker.model.scale.ScaleSection;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 *
 * @author zhush
 */
public class ScaleSectionDAO  extends IntIdBaseDAO {
    final static ScaleSectionDAO instance = new ScaleSectionDAO("DTXCASEMGNT_PU");

    public final static ScaleSectionDAO getInstance() {
        return instance;
    }

    private ScaleSectionDAO(String puName) {
        super(puName, ScaleSection.class);
    }

    @Override
    public String getTableName() {
        return "ScaleSection";
    }

    public List<ScaleSection> findByScaleId(Long scaleId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ScaleSection.findByScaleId");
            q.setParameter("scaleId", scaleId);
            return q.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<ScaleSection>(); 
        } finally {
            em.close();
        }
    }   
}
