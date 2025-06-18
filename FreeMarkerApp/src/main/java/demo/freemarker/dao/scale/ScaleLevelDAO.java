package demo.freemarker.dao.scale;

import demo.freemarker.model.scale.ScaleLevel;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import org.hsqldb.Session;

public class ScaleLevelDAO extends IntIdBaseDAO {

    final static ScaleLevelDAO instance = new ScaleLevelDAO("DTXCASEMGNT_PU");

    public final static ScaleLevelDAO getInstance() {
        return instance;
    }

    private ScaleLevelDAO(String puName) {
        super(puName, ScaleLevel.class);
    }

    @Override
    public String getTableName() {
        return "ScaleLevel";
    }

    public List<ScaleLevel> findByScaleId(Long scaleId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ScaleLevel.findByScaleId");
            q.setParameter("scaleId", scaleId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<ScaleLevel>();
        } finally {
            em.close();
        }
    }

    public ScaleLevel findByScore(Long scaleId, Integer score) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("ScaleLevel.findByScore");
            q.setParameter("scaleId", scaleId);
            q.setParameter("score", score);

            return (ScaleLevel) q.getSingleResult();
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }
}
