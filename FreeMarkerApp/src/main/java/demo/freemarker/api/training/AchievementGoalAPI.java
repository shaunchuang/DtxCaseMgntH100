package demo.freemarker.api.training;

import demo.freemarker.dao.training.AchievementGoalDAO;
import demo.freemarker.model.training.AchievementGoal;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;

public class AchievementGoalAPI implements API {
    private final static AchievementGoalAPI INSTANCE = new AchievementGoalAPI();

    public final static AchievementGoalAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "AchievementGoalAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "成就目標管理 API";
    }

    public List<AchievementGoal> listAchievementGoal() {
        List<AchievementGoal> output = new ArrayList<>();
        try {
            List<IntIdDataEntity> list = AchievementGoalDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((AchievementGoal) entity);
            }
            return output;

        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public AchievementGoal getAchievementGoal(long id) {
        try {
            return (AchievementGoal) AchievementGoalDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createAchievementGoal(AchievementGoal achievementGoal) {
        try {
            AchievementGoalDAO.getInstance().create(achievementGoal);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateAchievementGoal(AchievementGoal achievementGoal) {
        try {
            AchievementGoalDAO.getInstance().edit(achievementGoal);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteAchievementGoal(long id) {
        try {
            AchievementGoalDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<AchievementGoal> listByMappingId(Long mappingId) {
        try {
            return AchievementGoalDAO.getInstance().findByfindByMappingId(mappingId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
}
