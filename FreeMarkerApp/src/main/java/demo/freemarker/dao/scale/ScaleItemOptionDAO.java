/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.dao.scale;

import demo.freemarker.model.scale.ScaleItemOption;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 *
 * @author zhush
 */
public class ScaleItemOptionDAO extends IntIdBaseDAO {

    final static ScaleItemOptionDAO instance = new ScaleItemOptionDAO("DTXCASEMGNT_PU");

    public final static ScaleItemOptionDAO getInstance() {
        return instance;
    }

    private ScaleItemOptionDAO(String puName) {
        super(puName, ScaleItemOption.class);
    }

    @Override
    public String getTableName() {
        return "ScaleItemOption";
    }

    public List<ScaleItemOption> findByScaleItemId(Long scaleItemId){
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ScaleItemOption.findByScaleItemId");
            q.setParameter("scaleItemId", scaleItemId);
            return q.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<ScaleItemOption>(); 
        } finally {
            em.close();
        }
    }
}
