package demo.freemarker.api.training;

import demo.freemarker.dao.training.TrainingPlanDAO;
import demo.freemarker.model.training.TrainingPlan;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;

public class TrainingPlanAPI implements API {
    private final static TrainingPlanAPI INSTANCE = new TrainingPlanAPI();

    public final static TrainingPlanAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "TrainingPlanAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "訓練計畫管理 API";
    }

    public List<TrainingPlan> listTrainingPlan() {
        List<TrainingPlan> output = new ArrayList<>();
        try {
            List<IntIdDataEntity> list = TrainingPlanDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((TrainingPlan) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public TrainingPlan getTrainingPlan(long id) {
        try {
            return (TrainingPlan) TrainingPlanDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createTrainingPlan(TrainingPlan plan) {
        try {
            TrainingPlanDAO.getInstance().create(plan);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateTrainingPlan(TrainingPlan plan) {
        try {
            TrainingPlanDAO.getInstance().edit(plan);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteTrainingPlan(long id) {
        try {
            TrainingPlanDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "取得病患的訓練計畫清單")
    public List<TrainingPlan> listByPatient(Long patientId) {
        try {
            return TrainingPlanDAO.getInstance().findByPatient(patientId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
}
