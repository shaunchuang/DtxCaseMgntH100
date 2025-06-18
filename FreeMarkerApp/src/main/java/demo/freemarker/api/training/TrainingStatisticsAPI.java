package demo.freemarker.api.training;

import demo.freemarker.dao.training.TrainingStatisticsDAO;
import demo.freemarker.model.training.TrainingStatistics;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;

public class TrainingStatisticsAPI implements API {
    private final static TrainingStatisticsAPI INSTANCE = new TrainingStatisticsAPI();

    public final static TrainingStatisticsAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "TrainingStatisticsAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "訓練統計管理 API";
    }

    public List<TrainingStatistics> listTrainingStatistics() {
        List<TrainingStatistics> output = new ArrayList<>();
        try {
            List<IntIdDataEntity> list = TrainingStatisticsDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((TrainingStatistics) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public TrainingStatistics getTrainingStatistics(long id) {
        try {
            return (TrainingStatistics) TrainingStatisticsDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createTrainingStatistics(TrainingStatistics statistics) {
        try {
            TrainingStatisticsDAO.getInstance().create(statistics);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateTrainingStatistics(TrainingStatistics statistics) {
        try {
            TrainingStatisticsDAO.getInstance().edit(statistics);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteTrainingStatistics(long id) {
        try {
            TrainingStatisticsDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<TrainingStatistics> listByRecordId(Long recordId){
        try {
            return TrainingStatisticsDAO.getInstance().findByRecordId(recordId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
}
