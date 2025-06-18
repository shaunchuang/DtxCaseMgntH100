package demo.freemarker.api.assessment;

import demo.freemarker.dao.assessment.AssessmentSectionResultDAO;
import demo.freemarker.model.assessment.AssessmentSectionResult;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;

public class AssessmentSectionResultAPI implements API {

    private final static AssessmentSectionResultAPI INSTANCE = new AssessmentSectionResultAPI();

    public final static AssessmentSectionResultAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "AssessmentSectionResultAPI";
    }

    @Override
    public String getVersion() {
        return "20250423.1";
    }

    @Override
    public String getDescription() {
        return "評估區間結果資料 API";
    }

    public List<AssessmentSectionResult> list() {
        List<AssessmentSectionResult> list = new ArrayList<>();
        try {
            List<IntIdDataEntity> entities = AssessmentSectionResultDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : entities) {
                list.add((AssessmentSectionResult) entity);
            }
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    @APIDefine(description = "根據ID取得評估結果")
    public AssessmentSectionResult getAssessmentSectionResult(Long id) {
        try {
            return (AssessmentSectionResult) AssessmentSectionResultDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "新增評估區間結果")
    public void createAssessmentSectionResult(AssessmentSectionResult assessmentSectionResult) {
        try {
            AssessmentSectionResultDAO.getInstance().create(assessmentSectionResult);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "更新評估區間結果")
    public void updateAssessmentSectionResult(AssessmentSectionResult assessmentSectionResult) {
        try {
            AssessmentSectionResultDAO.getInstance().edit(assessmentSectionResult);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "刪除評估區間結果")
    public void deleteAssessmentSectionResult(Long id) {
        try {
            AssessmentSectionResultDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<AssessmentSectionResult> listByAssessmentId(Long assessmentId) {
        try {
            return AssessmentSectionResultDAO.getInstance().findByAssId(assessmentId);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }
}
