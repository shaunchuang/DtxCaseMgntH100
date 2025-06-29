package demo.freemarker.handler.restfulapi.assessment;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.assessment.AssessmentAPI;
import demo.freemarker.api.assessment.AssessmentResultAPI;
import demo.freemarker.api.assessment.AssessmentSectionResultAPI;
import demo.freemarker.api.scale.ScaleAPI;
import demo.freemarker.api.scale.ScaleLevelAPI;
import demo.freemarker.api.scale.ScaleSectionAPI;
import demo.freemarker.core.GsonUtil;
import demo.freemarker.core.SecurityUtils;
import demo.freemarker.dto.AssessmentInfo;
import demo.freemarker.dto.AssessmentResultInfo;
import demo.freemarker.dto.AssessmentScoreResult;
import demo.freemarker.dto.AssessmentSectionScoreResult;
import demo.freemarker.dto.CaseAssessment;
import demo.freemarker.model.assessment.Assessment;
import demo.freemarker.model.assessment.AssessmentResult;
import demo.freemarker.model.assessment.AssessmentSectionResult;
import demo.freemarker.model.scale.Scale;
import demo.freemarker.model.scale.ScaleLevel;
import demo.freemarker.model.scale.ScaleSection;

import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.json.JSONObject;

public class AssessmentRESTfulAPI extends RESTfulAPI {

    public AssessmentRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/Assessment/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                AssessmentAPI.getInstance().getName(),
                AssessmentAPI.getInstance().getVersion(),
                AssessmentAPI.getInstance().getDescription());
        //
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(Assessment.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "取得所有 Assessment 資料")
    private String list(HttpExchange exchange) throws IOException {
        List<Assessment> assessments = new ArrayList<>();
        try {
            assessments = AssessmentAPI.getInstance().list();

        } catch (Exception ex) {
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
            return null;
        }
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(assessments);
    }

    @RESTfulAPIDefine(url = "createAssessment", methods = "post", description = "新增 Assessment 資料")
    private String createAssessment(HttpExchange exchange) throws IOException {
        try {
            JSONObject responsebody = new JSONObject();
            Date createDate = new Date();
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            Locale locale = SecurityUtils.getLocale(exchange);
            AssessmentInfo assessmentInfo = GsonUtil.fromJson(requestBody, AssessmentInfo.class);
            if (assessmentInfo.getPatientId() == null || assessmentInfo.getScaleIds().size() < 0) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
                return null;
            }

            if (assessmentInfo.getAssessmentEndDate() == null) {
                assessmentInfo.setAssessmentEndDate(createDate);
            }

            List<CaseAssessment> caseAssessments = new ArrayList<CaseAssessment>();

            for (Long scaleId : assessmentInfo.getScaleIds()) {
                Assessment assessment = new Assessment();
                if (assessmentInfo.getTherapistId() != null) {
                    assessment.setTherapistId(assessmentInfo.getTherapistId());
                }
                assessment.setPatientId(assessmentInfo.getPatientId());
                assessment.setScaleId(scaleId);
                assessment.setAssessmentDate(createDate);
                AssessmentAPI.getInstance().createAssessment(assessment);
            }

            if (assessmentInfo.getShowList()) {
                List<Assessment> assessments = AssessmentAPI.getInstance().listByPatientIdTherapistIdParamAndStartEndDate(assessmentInfo.getPatientId(), assessmentInfo.getTherapistId(), null, assessmentInfo.getAssessmentBeginDate(), assessmentInfo.getAssessmentEndDate());
                caseAssessments = AssessmentAPI.getInstance().convertToCaseAssessmentList(assessments, locale);
            }

            responsebody.put("success", Boolean.TRUE);
            responsebody.put("data", caseAssessments);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responsebody.toString();
        } catch (Exception e) {
            e.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
            return null;
        }
    }

    @RESTfulAPIDefine(url = "getCaseAssessmentList", methods = "post", description = "取得所有 Assessment 資料")
    private String getCaseAssessmentList(HttpExchange exchange) throws IOException {
        try {
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject responsebody = new JSONObject();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date nowDate = new Date();
            Locale locale = SecurityUtils.getLocale(exchange);
            AssessmentInfo info = GsonUtil.fromJson(requestBody, AssessmentInfo.class);
            if (info.getPatientId() == null) {
                responsebody.put("success", Boolean.FALSE);
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
                return null;
            }

            if (info.getAssessmentEndDate() == null) {
                info.setAssessmentEndDate(nowDate);
            }

            List<Assessment> assessments = new ArrayList<Assessment>();
            List<CaseAssessment> caseAssessments = new ArrayList<CaseAssessment>();
            if (info.getTherapistId() != null) {
                System.out.println("TherapistId: " + info.getTherapistId());
                assessments = AssessmentAPI.getInstance().listByPatientIdTherapistIdParamAndStartEndDate(info.getPatientId(), info.getTherapistId(), info.getParam(), info.getAssessmentBeginDate(), info.getAssessmentEndDate());
            } else {
                // 個案的評估量表
                if (info.getIsFromPatient()) {
                    assessments = AssessmentAPI.getInstance().listLatestAssessment(info.getPatientId());
                    if (assessments.size() <= 0 && info.getScaleIds().size() > 0) {
                        Assessment assessment = new Assessment();
                        assessment.setTherapistId(null);
                        assessment.setAssessmentDate(nowDate);
                        assessment.setPatientId(info.getPatientId());
                        assessment.setTotalScore(0);
                        assessment.setStatus(Boolean.FALSE);
                        Scale scale = ScaleAPI.getInstance().getScale(info.getScaleIds().get(0));
                        assessment.setScaleId(scale.getId());
                        AssessmentAPI.getInstance().createAssessment(assessment);
                        assessments.add(assessment);
                    }
                } else {
                    assessments = AssessmentAPI.getInstance().listByPatientIdParamAndStartEndDate(info.getPatientId(), info.getParam(), info.getAssessmentBeginDate(), info.getAssessmentEndDate());
                }
            }
            System.out.println("Assessments size: " + assessments.size());
            caseAssessments = AssessmentAPI.getInstance().convertToCaseAssessmentList(assessments, locale);

            responsebody.put("success", Boolean.TRUE);
            responsebody.put("data", caseAssessments);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responsebody.toString();
        } catch (Exception e) {
            e.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
            return null;
        }
    }

    @RESTfulAPIDefine(url = "getCaseAssessment", methods = "post", description = "取得 Assessment 資料")
    private String getCaseAssessment(HttpExchange exchange) throws IOException {
        try {
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject responsebody = new JSONObject();

            AssessmentInfo info = GsonUtil.fromJson(requestBody, AssessmentInfo.class);
            if (info.getAssessmentId() == null) {
                Assessment assessment = AssessmentAPI.getInstance().getAssessment(info.getAssessmentId());
                if (assessment.isStatus()) {
                    Scale scale = ScaleAPI.getInstance().getScale(assessment.getScaleId());
                    responsebody.put("scale", scale);
                } else {
                    responsebody.put("scale", JSONObject.NULL);
                }
            } else {
                responsebody.put("scale", JSONObject.NULL);
                responsebody.put("success", Boolean.FALSE);
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
                return responsebody.toString();
            }

            responsebody.put("success", Boolean.TRUE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responsebody.toString();
        } catch (Exception e) {
            e.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
            return null;
        }
    }

    @RESTfulAPIDefine(url = "createAssessmentResult", methods = "post", description = "建立 Assessment 資料")
    public String createAssessmentResults(HttpExchange exchange) throws IOException {
        try {
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject responseBody = new JSONObject();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date createDate = new Date();
            Locale locale = SecurityUtils.getLocale(exchange);
            AssessmentResultInfo info = GsonUtil.fromJson(requestBody, AssessmentResultInfo.class);

            if (info.getAssessmentId() == null) {
                responseBody.put("success", Boolean.FALSE);
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
                return responseBody.toString();
            }

            if (info.getSectionItemResults().size() > 0) {
                for (AssessmentSectionScoreResult sectionResult : info.getSectionItemResults()) {
                    AssessmentSectionResult assessmentSectionResult = new AssessmentSectionResult();
                    List<AssessmentScoreResult> itemResults = sectionResult.getSectionResults();
                    
                    ScaleSection section = ScaleSectionAPI.getInstance().getScaleSection(sectionResult.getSection());

                    for (AssessmentScoreResult itemResult : itemResults) {
                        AssessmentResult assessmentResult = new AssessmentResult();
                        assessmentResult.setAssessmentId(info.getAssessmentId());
                        assessmentResult.setScaleItemId(itemResult.getItem());
                        assessmentResult.setScaleSectionId(section.getId());
                        if (itemResult.getOption() != null) {
                            assessmentResult.setScaleItemOptionId(itemResult.getOption());
                        }
                        assessmentResult.setScore(itemResult.getScore());
                        assessmentResult.setCreateTime(createDate);
                        AssessmentResultAPI.getInstance().createAssessmentResult(assessmentResult);
                    }

                    if (section != null) {
                        assessmentSectionResult.setAssessmentId(info.getAssessmentId());
                        assessmentSectionResult.setSectionId(section.getId());
                        assessmentSectionResult.setSectionName(section.getName());
                        assessmentSectionResult.setTotalScore(sectionResult.getSectionScore());
                        AssessmentSectionResultAPI.getInstance().createAssessmentSectionResult(assessmentSectionResult);
                    }
                }

                Assessment assessment = AssessmentAPI.getInstance().findByIdAndPatientIdAndTherapistId(info.getAssessmentId(), info.getPatientId(), info.getTherapistId());
                if (assessment != null) {
                    ScaleLevel level = ScaleLevelAPI.getInstance().findByScore(assessment.getScaleId(), info.getTotalScore());
                    if (level == null) {
                        level = ScaleLevelAPI.getInstance().findByScaleId(assessment.getScaleId());
                    }
                    if (level != null) {
                        assessment.setScaleLevevlId(level.getId());
                    }
                    assessment.setTotalScore(info.getTotalScore());
                    assessment.setStatus(Boolean.TRUE);
                    AssessmentAPI.getInstance().updateAssessment(assessment);
                }
            }

            if (info.getItemResults().size() > 0) {
                for (AssessmentScoreResult itemResult : info.getItemResults()) {
                    AssessmentResult assessmentResult = new AssessmentResult();
                    assessmentResult.setAssessmentId(info.getAssessmentId());
                    assessmentResult.setScaleItemId(itemResult.getItem());
                    if (itemResult.getOption() != null) {
                        assessmentResult.setScaleItemOptionId(itemResult.getOption());
                    }
                    assessmentResult.setScore(itemResult.getScore());
                    assessmentResult.setCreateTime(createDate);
                    AssessmentResultAPI.getInstance().createAssessmentResult(assessmentResult);
                }

                Assessment assessment = AssessmentAPI.getInstance().getAssessment(info.getAssessmentId());
                if (assessment != null) {
                    ScaleLevel level = ScaleLevelAPI.getInstance().findByScore(assessment.getScaleId(), info.getTotalScore());
                    if(level == null) {
                        level = ScaleLevelAPI.getInstance().findByScaleId(assessment.getScaleId());
                    }
                    if(level != null ) assessment.setScaleLevevlId(level.getId());
                    assessment.setTotalScore(info.getTotalScore());
                    assessment.setStatus(Boolean.TRUE);
                    AssessmentAPI.getInstance().updateAssessment(assessment);
                }
            }

            if (info.getShowList()) {
                List<Assessment> assessments = AssessmentAPI.getInstance().listByPatientIdTherapistIdParamAndStartEndDate(info.getPatientId(), info.getTherapistId(), null, null, createDate);
                List<CaseAssessment> caseAssessments = AssessmentAPI.getInstance().convertToCaseAssessmentList(assessments, locale);
                responseBody.put("data", caseAssessments);
            }

            responseBody.put("assessmentId", info.getAssessmentId());
            responseBody.put("success", Boolean.TRUE);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseBody.toString();
        } catch (Exception e) {
            e.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
            return null;
        }
    }

    @RESTfulAPIDefine(url = "getScaleLevel", methods = "post", description = "取得 Assessment 資料")
    public String getScaleLevel(HttpExchange exchange) throws IOException {
        try {
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            JSONObject requestJson = new JSONObject(requestBody);
            if (!requestJson.has("scaleId") || !requestJson.has("score")) {
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
                return null;
            }
            JSONObject responsebody = new JSONObject();

            ScaleLevel scaleLevel = ScaleLevelAPI.getInstance().findByScore(requestJson.getLong("scaleId"), requestJson.getInt("score"));
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return EntityUtility.toJSONString(scaleLevel);
        } catch (Exception e) {
            e.printStackTrace();
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_NOT_FOUND, 0);
            return null;
        }
    }
}
