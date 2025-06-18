package demo.freemarker.api.training;

import demo.freemarker.dao.training.StatisticsGoalDAO;
import demo.freemarker.model.training.StatisticsGoal;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;

public class StatisticsGoalAPI implements API {
    private final static StatisticsGoalAPI INSTANCE = new StatisticsGoalAPI();

    public final static StatisticsGoalAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "StatisticsGoalAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "統計目標管理 API";
    }

    public List<StatisticsGoal> listStatisticsGoal() {
        List<StatisticsGoal> output = new ArrayList<>();
        try{

            List<IntIdDataEntity> list = StatisticsGoalDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((StatisticsGoal) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public StatisticsGoal getStatisticsGoal(long id) {
        try {
            return (StatisticsGoal) StatisticsGoalDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createStatisticsGoal(StatisticsGoal goal) {
        try {
            StatisticsGoalDAO.getInstance().create(goal);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateStatisticsGoal(StatisticsGoal goal) {
        try {
            StatisticsGoalDAO.getInstance().edit(goal);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteStatisticsGoal(long id) {
        try {
            StatisticsGoalDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<StatisticsGoal> listByMappingId(long mappingId) {
        try {
            return StatisticsGoalDAO.getInstance().findByMappingId(mappingId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
}
