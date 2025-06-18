package demo.freemarker.dao.training;

import itri.sstc.framework.core.database.IntIdBaseDAO;
import javax.persistence.EntityManager;
import javax.persistence.Query;

import demo.freemarker.model.training.TrainingStatistics;

import java.util.List;
import java.util.ArrayList;

public class TrainingStatisticsDAO extends IntIdBaseDAO {

    final static TrainingStatisticsDAO instance = new TrainingStatisticsDAO("DTXCASEMGNT_PU");

    public final static TrainingStatisticsDAO getInstance() {
        return instance;
    }

    private TrainingStatisticsDAO(String puName) {
        super(puName, TrainingStatistics.class);
    }

    @Override
    public String getTableName() {
        return "TrainingStatistics";
    }

    public List<TrainingStatistics> findByRecordId(Long recordId) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("TrainingStatistics.findByRecordId");
            q.setParameter("recordId", recordId);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}
