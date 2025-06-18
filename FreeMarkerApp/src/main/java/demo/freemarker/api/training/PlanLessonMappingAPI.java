package demo.freemarker.api.training;

import demo.freemarker.dao.training.PlanLessonMappingDAO;
import demo.freemarker.model.training.PlanLessonMapping;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PlanLessonMappingAPI implements API {

    private static final PlanLessonMappingAPI INSTANCE = new PlanLessonMappingAPI();

    public static PlanLessonMappingAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "PlanLessonMappingAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "訓練計畫課程映射管理 API";
    }

    /**
     * 獲取所有訓練計畫課程映射
     * @return 映射清單
     */
    public List<PlanLessonMapping> listPlanLessonMappings() {
        List<PlanLessonMapping> output = new ArrayList<>();
        try {

            List<IntIdDataEntity> list = PlanLessonMappingDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((PlanLessonMapping) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    /**
     * 獲取指定ID的映射
     * @param id 映射ID
     * @return 映射對象
     */
    public PlanLessonMapping getPlanLessonMapping(long id) {
        try {
            return (PlanLessonMapping) PlanLessonMappingDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    /**
     * 新增映射
     * @param mapping 映射對象
     */
    public void createPlanLessonMapping(PlanLessonMapping mapping) {
        try {
            mapping.setCreateTime(new Date());
            PlanLessonMappingDAO.getInstance().create(mapping);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    /**
     * 更新映射
     * @param mapping 映射對象
     */
    public void updatePlanLessonMapping(PlanLessonMapping mapping) {
        try {
            PlanLessonMappingDAO.getInstance().edit(mapping);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    /**
     * 刪除映射
     * @param id 映射ID
     */
    public void deletePlanLessonMapping(long id) {
        try {
            PlanLessonMappingDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    /**
     * 透過訓練計畫ID獲取所有相應的課程映射
     * @param planId 訓練計畫ID
     * @return 映射清單
     */
    @APIDefine(description = "透過訓練計畫ID獲取課程映射清單")
    public List<PlanLessonMapping> listByPlanId(Long planId) {
        try {
            return PlanLessonMappingDAO.getInstance().findByPlanId(planId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get plan-lesson mappings: " + ex.getMessage());
        }
    }

    /**
     * 透過訓練計畫ID獲取所有相應的課程ID
     * @param planId 訓練計畫ID
     * @return 課程ID清單
     */
    @APIDefine(description = "透過訓練計畫ID獲取課程ID清單")
    public List<Long> listLessonIdsByPlanId(Long planId) {
        try {
            return PlanLessonMappingDAO.getInstance().findLessonIdsByPlanId(planId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get lesson IDs: " + ex.getMessage());
        }
    }

    public List<PlanLessonMapping> PlanLessonMappingByLessonIdAndPlanId(Long lessonId, Long planId) {
        try {
            return PlanLessonMappingDAO.getInstance().findPlanLessonMappingByLessonIdAndPlanId(lessonId, planId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get plan-lesson mapping by lesson ID and plan ID: " + ex.getMessage());
        }
    }
}
