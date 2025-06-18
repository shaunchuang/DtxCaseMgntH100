package demo.freemarker.dao;

import demo.freemarker.model.WgIcdCode;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

public class WgIcdCodeDAO extends IntIdBaseDAO {

    final static WgIcdCodeDAO instance = new WgIcdCodeDAO("DTXCASEMGNT_PU");

    public final static WgIcdCodeDAO getInstance() {
        return instance;
    }

    private WgIcdCodeDAO(String puName) {
        super(puName, WgIcdCode.class);
    }

    @Override
    public String getTableName() {
        return "WgIcdCode";
    }

    public WgIcdCode searchByCode(String code) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("WgIcdCode.findByCode");
            q.setParameter("code", code);
            return (WgIcdCode)q.getSingleResult();
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }

    public List<WgIcdCode> searchByPureCode(String pureCode) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("WgIcdCode.findByPureCode");
            q.setParameter("pureCode", "%" + pureCode + "%");
            return q.getResultList();
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
    }
}
