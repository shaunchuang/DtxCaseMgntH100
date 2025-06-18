package demo.freemarker.api.assessment;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import demo.freemarker.dao.assessment.AssessmentResultDAO;
import demo.freemarker.model.assessment.AssessmentResult;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;

public class AssessmentResultAPI implements API {

    private final static AssessmentResultAPI INSTANCE = new AssessmentResultAPI();

    public final static AssessmentResultAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "AssessmentResultAPI";
    }

    @Override
    public String getVersion() {
        return "20250423.1";
    }

    @Override
    public String getDescription() {
        return "評估結果資料 API";
    }

    public List<AssessmentResult> list() {
        List<AssessmentResult> list = new ArrayList<>();
        try {
            List<IntIdDataEntity> entities = AssessmentResultDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : entities) {
                list.add((AssessmentResult) entity);
            }
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    @APIDefine(description = "根據ID取得評估結果")
    public AssessmentResult getAssessmentResult(Long id) {
        try {
            return (AssessmentResult) AssessmentResultDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "新增評估結果")
    public void createAssessmentResult(AssessmentResult assessmentResult) {
        try {
            // 設置創建時間
            if (assessmentResult.getCreateTime() == null) {
                assessmentResult.setCreateTime(new Date());
            }
            AssessmentResultDAO.getInstance().create(assessmentResult);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "更新評估結果")
    public void updateAssessmentResult(AssessmentResult assessmentResult) {
        try {
            AssessmentResultDAO.getInstance().edit(assessmentResult);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "刪除評估結果")
    public void deleteAssessmentResult(Long id) {
        try {
            AssessmentResultDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據評估ID、量表項目ID和選項ID查詢評估結果")
    public AssessmentResult findByAssIdItemIdOpId(Long assessmentId, Long scaleItemId, Long scaleItemOptionId) {
        try {
            List<AssessmentResult> assessmentResult = AssessmentResultDAO.getInstance().findByAssIdItemIdOpId(assessmentId, scaleItemId, scaleItemOptionId);
            return assessmentResult.isEmpty() ? null : assessmentResult.get(0);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據評估ID和量表項目ID查詢評估結果")
    public AssessmentResult findByAssIdItemId(Long assessmentId, Long scaleItemId) {
        try {
            List<AssessmentResult> assessmentResult = AssessmentResultDAO.getInstance().findByAssIdItemId(assessmentId, scaleItemId);
            return assessmentResult.isEmpty() ? null : assessmentResult.get(0);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據評估ID、量表項目ID和選項ID查詢評估分數")
    public Integer findScoreByAssIdItemIdOpId(Long assessmentId, Long scaleItemId, Long scaleItemOptionId) {
        try {
            AssessmentResult assessmentResult = null;
            if(assessmentId != null && scaleItemId != null){
                if(scaleItemOptionId == null) {
                    assessmentResult = findByAssIdItemId(assessmentId, scaleItemId);
                } else {
                    assessmentResult = findByAssIdItemIdOpId(assessmentId, scaleItemId, scaleItemOptionId);
                }
                if(assessmentResult != null )
                    return assessmentResult.getScore();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex.getMessage());
        }
        return 0;
    }

    @APIDefine(description = "根據評估ID和量表項目ID查詢評估分數檢查量表是否存在")
    public Boolean checkAssessmentResultExist(Long assessmentId, Long scaleItemId, Long scaleItemOptionId) {
        try {
            List<AssessmentResult> assessmentResult = AssessmentResultDAO.getInstance().findByAssIdItemIdOpId(assessmentId, scaleItemId, scaleItemOptionId);
            return assessmentResult.isEmpty() ? false : true;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException(ex.getMessage());
        }
    }
}
