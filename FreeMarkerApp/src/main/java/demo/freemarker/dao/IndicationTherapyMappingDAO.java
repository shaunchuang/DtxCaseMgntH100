package demo.freemarker.dao;

import demo.freemarker.model.IndicationTherapyMapping;
import itri.sstc.framework.core.database.IntIdBaseDAO;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

public class IndicationTherapyMappingDAO extends IntIdBaseDAO {
    final static IndicationTherapyMappingDAO instance = new IndicationTherapyMappingDAO("DTXSTORE_PU");

    public final static IndicationTherapyMappingDAO getInstance() {
        return instance;
    }

    private IndicationTherapyMappingDAO(String puName) {
        super(puName, IndicationTherapyMapping.class);
    }

    @Override
    public String getTableName() {
        return "indication_therapy_mapping";
    }

    /**
     * 根據適應症ID查詢對應的治療類別
     * @param indicationId 適應症ID
     * @return 治療類別列表
     */
    public List<IndicationTherapyMapping> findByIndicationId(Long indicationId) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<IndicationTherapyMapping> query = em.createNamedQuery(
                "IndicationTherapyMapping.findByIndicationId", IndicationTherapyMapping.class);
            query.setParameter("indicationId", indicationId);
            return query.getResultList();
        } catch (NoResultException e) {
            return null;
        }
    }

    public List<IndicationTherapyMapping> findByTherapyType(String therapyType) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<IndicationTherapyMapping> query = em.createNamedQuery(
                "IndicationTherapyMapping.findByTherapyType", IndicationTherapyMapping.class);
            query.setParameter("therapyType", therapyType);
            return query.getResultList();
        } catch (NoResultException e) {
            return null;
        }
    }

    public IndicationTherapyMapping findByIndicationAndTherapy(Long indicationId, String therapyType) {
        EntityManager em = getEntityManager();
        try {
            TypedQuery<IndicationTherapyMapping> query = em.createNamedQuery(
                "IndicationTherapyMapping.findByIndicationAndTherapy", IndicationTherapyMapping.class);
            query.setParameter("indicationId", indicationId);
            query.setParameter("therapyType", therapyType);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public IndicationTherapyMapping save(IndicationTherapyMapping mapping) {
        EntityManager em = getEntityManager();
        if (mapping.getId() == null) {
            em.persist(mapping);
            return mapping;
        } else {
            return em.merge(mapping);
        }
    }

    public void saveTherapyMappings(Long indicationId, String[] therapyTypes) {
        deleteByIndicationId(indicationId);
        for (String therapyType : therapyTypes) {
            IndicationTherapyMapping mapping = new IndicationTherapyMapping(indicationId, therapyType);
            save(mapping);
        }
    }

    public void deleteByIndicationId(Long indicationId) {
        EntityManager em = getEntityManager();
        List<IndicationTherapyMapping> mappings = findByIndicationId(indicationId);
        if (mappings != null) {
            for (IndicationTherapyMapping mapping : mappings) {
                em.remove(em.contains(mapping) ? mapping : em.merge(mapping));
            }
        }
    }
}
