package demo.freemarker.api.training;

import demo.freemarker.dao.training.TrainingAchievementDAO;
import demo.freemarker.model.training.TrainingAchievement;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;

public class TrainingAchievementAPI implements API {
    private final static TrainingAchievementAPI INSTANCE = new TrainingAchievementAPI();

    public final static TrainingAchievementAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "TrainingAchievementAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "訓練成就管理 API";
    }

    public List<TrainingAchievement> listTrainingAchievement() {
        List<TrainingAchievement> output = new ArrayList<>();
        try {

            List<IntIdDataEntity> list = TrainingAchievementDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((TrainingAchievement) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public TrainingAchievement getTrainingAchievement(long id) {
        try {
            return (TrainingAchievement) TrainingAchievementDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createTrainingAchievement(TrainingAchievement achievement) {
        try {
            TrainingAchievementDAO.getInstance().create(achievement);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateTrainingAchievement(TrainingAchievement achievement) {
        try {
            TrainingAchievementDAO.getInstance().edit(achievement);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteTrainingAchievement(long id) {
        try {
            TrainingAchievementDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<TrainingAchievement> listTrainingAchievementsByRecordId(long recordId) {
        try {
            return TrainingAchievementDAO.getInstance().findByRecordId(recordId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
}
