package demo.freemarker.api.assessment;

import demo.freemarker.api.PatientAPI;
import demo.freemarker.api.RoleAPI;
import demo.freemarker.api.UserAPI;
import demo.freemarker.api.scale.ScaleAPI;
import demo.freemarker.api.scale.ScaleLevelAPI;
import demo.freemarker.dao.assessment.AssessmentDAO;
import demo.freemarker.dto.CaseAssessment;
import demo.freemarker.dto.UserRoleDTO;
import demo.freemarker.model.Patient;
import demo.freemarker.model.User;
import java.util.ArrayList;
import java.util.List;

import demo.freemarker.model.assessment.Assessment;
import demo.freemarker.model.scale.Scale;
import demo.freemarker.model.scale.ScaleLevel;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.stream.Collectors;

public class AssessmentAPI implements API {

    private final static AssessmentAPI INSTANCE = new AssessmentAPI();

    public final static AssessmentAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "AssessmentAPI";
    }

    @Override
    public String getVersion() {
        return "20250415.01";
    }

    @Override
    public String getDescription() {
        return "評估結果管理 API";
    }

    public List<Assessment> list() {
        List<Assessment> list = new ArrayList<>();
        try {
            List<IntIdDataEntity> entities = AssessmentDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : entities) {
                list.add((Assessment) entity);
            }
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    @APIDefine(description = "根據ID取得評估結果")
    public Assessment getAssessment(Long id) {
        try {
            return (Assessment) AssessmentDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "新增評估結果")
    public void createAssessment(Assessment assessment) {
        try {
            AssessmentDAO.getInstance().create(assessment);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "更新評估結果")
    public void updateAssessment(Assessment assessment) {
        try {
            AssessmentDAO.getInstance().edit(assessment);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "刪除評估結果")
    public void deleteAssessment(Long id) {
        try {
            AssessmentDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public Assessment findByIdAndPatientIdAndTherapistId(Long id, Long patientId, Long therapistId) {
        try {
            if (id != null && patientId != null && therapistId != null) {
                return AssessmentDAO.getInstance().findByIdAndPatientIdAndTherapistId(id, patientId, therapistId);
            } else if (id != null && patientId != null) {
                return AssessmentDAO.getInstance().findByIdAndPatientId(id, patientId);
            }
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
        return null;
    }

    @APIDefine(description = "根據評估表ID找到評估表")
    public List<Assessment> findByScaleId(Long scaleId) {
        try {
            return AssessmentDAO.getInstance().findByScaleId(scaleId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據病人ID找到評估表")
    public List<Assessment> findByTherapistId(Long therapistId) {
        try {
            return AssessmentDAO.getInstance().findByTherapistId(therapistId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據病人ID找到評估表")
    public List<Assessment> listByPatientIdParamAndStartEndDate(Long patientId, String param, Date startDate, Date endDate) {
        try {
            if (param == null) {
                param = "";
            }
            if (startDate == null) {
                List<Assessment> list = AssessmentDAO.getInstance().findByPatientIdParamAndEndDate(patientId, param, endDate);
                return list;
            } else {
                List<Assessment> list = AssessmentDAO.getInstance().findByPatientIdParamAndStartEndDate(patientId, param, startDate, endDate);
                return list;
            }
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據病人ID找到評估表")
    public List<Assessment> listByPatientIdTherapistIdParamAndStartEndDate(Long patientId, Long therapistId, String param, Date startDate, Date endDate) {
        try {
            if (param == null) {
                param = "";
            }
            if (therapistId == null) {
                if (startDate == null) {
                    List<Assessment> list = AssessmentDAO.getInstance().findByPatientIdParamAndEndDate(patientId, param, endDate);
                    return list;
                } else {
                    List<Assessment> list = AssessmentDAO.getInstance().findByPatientIdParamAndStartEndDate(patientId, param, startDate, endDate);
                    return list;
                }
            } else {
                if (startDate == null) {
                    List<Assessment> list = AssessmentDAO.getInstance().findBypatientIdTherapistIdParamAndEndDate(patientId, therapistId, param, endDate);
                    return list;
                } else {
                    List<Assessment> list = AssessmentDAO.getInstance().findBypatientIdTherapistIdParamAndStartEndDate(patientId, therapistId, param, startDate, endDate);
                    return list;
                }
            }
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據病人ID找到最新的評估表")
    public List<Assessment> listLatestAssessment(Long patientId) {
        try {
            return AssessmentDAO.getInstance().listLatestAssessment(patientId, new Date());
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    public Assessment findLastAssessment(Long patientId, Long scaleId, Date assessmentDate){
        try {
            return AssessmentDAO.getInstance().findLastAssessment(patientId, scaleId, assessmentDate);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    public List<Assessment> listByTodateAndScale(Long patientId, Date evalDate){
        try {
            return AssessmentDAO.getInstance().listByTodateAddScale(patientId, evalDate);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    public List<Long> listScaleIdsByTodateAndScale(Long patientId, Date evalDate){
        List<Long> ids = new ArrayList<Long>();
        try {
            
            List<Assessment> assessments = AssessmentDAO.getInstance().listByTodateAddScale(patientId, evalDate);
            for(Assessment assessment: assessments){
                ids.add(assessment.getScaleId());
            }
            return ids;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public CaseAssessment convertToCaseAssessment(Assessment assessment, Locale locale) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Long formId = assessment.getPatientId();
        Patient patient = PatientAPI.getInstance().getPatient(formId);
        String totalResult = "", resultLevel = "", subFuncList = "";
        String assessmentDate = assessment.getAssessmentDate() != null ? sdf.format(assessment.getAssessmentDate()) : "N/A";
        Assessment lastAssessment = this.findLastAssessment(assessment.getPatientId(), assessment.getScaleId(), assessment.getAssessmentDate());
        String lastAssessmentDate = (lastAssessment != null && lastAssessment.getAssessmentDate() != null) ? sdf.format(lastAssessment.getAssessmentDate()) : "N/A";

        String mode = "edit";
        if (assessment.getScaleLevevlId() != null) {
            ScaleLevel level = ScaleLevelAPI.getInstance().getScaleLevel(assessment.getScaleLevevlId());
            totalResult = "<span class='badge badge-tag badge-score' style='color:" + level.getColor() + "; background-color:" + level.getBgColor() + "'>" + assessment.getTotalScore() + "分 - " + level.getLevel() + "</span>";
            resultLevel = "<small style='color: " + level.getBgColor() + "'>" + level.getLevel() + "</small>";
            mode = "view";
        } else {
            resultLevel = "<button class='btn btn-sm do-fill'>前往填寫</button>";
        }
        
        Scale scale = ScaleAPI.getInstance().getScale(assessment.getScaleId());
        User therapist = UserAPI.getInstance().getUser(assessment.getTherapistId());
        String catNo = scale.getCategory();
        String catName = Scale.TreatmentType.getAbbrListMap(locale).getOrDefault(catNo, catNo);
        String cat = assessment.getScaleId() != null ? "<span class='category-label label-" + scale.getCategory().toLowerCase() + "'>" + catName + "</span>" : "";
        String showResult = assessment.isStatus() && assessment.getTotalScore() > 0 ? assessment.getTotalScore() + "分" : "未評量";
        String scoreResult = "<div class='score-box mb-1'>" + showResult + "</div>";
        UserRoleDTO userRole = new UserRoleDTO(therapist, RoleAPI.getInstance().listRolesByUserId(therapist.getId()));
        
        String editor = assessment.getTherapistId() == null ? patient.getName() : String.join(" ", therapist.getUsername(), userRole.getRoleName());

        if (!lastAssessmentDate.equals("N/A")) {
            subFuncList += "<button class='btn btn-sm chart-review'>檢視數據</button>";
        }
        CaseAssessment caseAssessment = new CaseAssessment(
                assessment.getId(),
                lastAssessmentDate,
                assessmentDate,
                editor,
                cat,
                scale.getName(),
                assessment.getTotalScore(),
                resultLevel,
                scoreResult,
                totalResult,
                subFuncList,
                mode
        );
        return caseAssessment;
    }

    public List<CaseAssessment> convertToCaseAssessmentList(List<Assessment> assessments, Locale locale) {
        return assessments.stream()
                .map(assessment -> convertToCaseAssessment(assessment, locale))
                .collect(Collectors.toList());
    }
}
