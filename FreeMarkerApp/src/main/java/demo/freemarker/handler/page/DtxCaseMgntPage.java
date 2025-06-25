/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.handler.page;

import com.sun.net.httpserver.Headers;
import demo.freemarker.api.ConfigPropertyAPI;
import demo.freemarker.api.DiseaseCategoryAPI;
import demo.freemarker.api.DrugUseStatusCategoryAPI;
import demo.freemarker.api.MedicationCategoryAPI;
import demo.freemarker.api.PatientAPI;
import demo.freemarker.api.RoleAPI;
import demo.freemarker.api.UserAPI;
import demo.freemarker.api.WgIcdCodeAPI;
import demo.freemarker.api.WgTaskAPI;
import demo.freemarker.api.assessment.AssessmentAPI;
import demo.freemarker.api.healthinsurance.HealthInsuranceRecordAPI;
import demo.freemarker.api.healthinsurance.MedicalServicePaymentItemsAPI;
import demo.freemarker.api.healthinsurance.TherapeuticTreatmentAPI;
import demo.freemarker.api.scale.ScaleAPI;
import demo.freemarker.api.training.PlanLessonMappingAPI;
import demo.freemarker.api.training.TrainingPlanAPI;
import demo.freemarker.core.CrossPlatformUtil;
import demo.freemarker.core.GsonUtil;
import demo.freemarker.core.SecurityUtils;
import demo.freemarker.dto.CaseAppoEvent;
import demo.freemarker.dto.CodeItem;
import demo.freemarker.dto.Executor;
import demo.freemarker.dto.HcRecordDTO;
import demo.freemarker.dto.HcRecordResp;
import demo.freemarker.dto.PatientInfo;
import demo.freemarker.dto.PaymentItem;
import demo.freemarker.dto.ScaleForm;
import demo.freemarker.dto.SyndromeDTO;
import demo.freemarker.dto.TodayReviewInfo;
import demo.freemarker.dto.TrainingEvent;
import demo.freemarker.dto.TrainingPlanDTO;
import demo.freemarker.dto.UserRoleDTO;
import demo.freemarker.model.DiseaseCategory;
import demo.freemarker.model.DrugUseStatusCategory;
import demo.freemarker.model.MedicationCategory;
import demo.freemarker.model.Patient;
import demo.freemarker.model.Role;
import demo.freemarker.model.User;
import demo.freemarker.model.WgIcdCode;
import demo.freemarker.model.WgTask;
import demo.freemarker.model.assessment.Assessment;
import demo.freemarker.model.healthinsurance.HealthInsuranceRecord;
import demo.freemarker.model.healthinsurance.MedicalServicePaymentItems;
import demo.freemarker.model.healthinsurance.TherapeuticTreatment;
import demo.freemarker.model.training.TrainingPlan;
import itri.sstc.framework.core.Config;
import itri.sstc.framework.core.httpd.session.HttpSession;
import itri.sstc.framework.core.httpd.session.HttpSessionManager;
import itri.sstc.freemarker.core.Model;
import itri.sstc.freemarker.core.RequestData;
import itri.sstc.freemarker.core.RequestHandler;
import itri.sstc.freemarker.core.RequestHandler.RequestMapping;
import itri.sstc.freemarker.utils.StringUtils;

import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.Year;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;
import java.util.function.Consumer;
import org.json.JSONObject;

/**
 *
 * @author zhush
 */
public class DtxCaseMgntPage extends RequestHandler {

    @Override
    public String getName() {
        return "imas";
    }

    // http://127.0.0.1:7001/ftl/imas
    @RequestMapping(pattern = "", description = "模組根目錄")
    public String index0(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        return "redirect:/ftl/imas/dashboard";
    }

    @RequestMapping(pattern = "/", description = "模組根目錄")
    public String index1(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        return "redirect:/ftl/imas/dashboard";
    }

    // http://127.0.0.1:7001/ftl/imas
    @RequestMapping(pattern = "/login", description = "模組根目錄")
    public String login(RequestData request, Model model) {

        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        String baseUrl = Config.get("baseUrl", "http://127.0.0.1:7001");
        model.addAttribute("baseUrl", baseUrl);
        String randomPwd = UUID.randomUUID().toString().replace("-", "").substring(0, 8);
        model.addAttribute("randomPassword", randomPwd);

        model.addAttribute("ver", "v3");
        return "/user/login";
    }

    // http://127.0.0.1:7000/ftl/imas/logout
    @RequestMapping(pattern = "/logout", description = "")
    public String logout(RequestData request, Model model) {
        SecurityUtils.removeToken(request.session);
        SecurityUtils.clearCurrentUserAndSession(request);
        HttpSessionManager.getInstance().removeSession(request.exchange);
        String expiredCookie = String.format(
                "%s=; Path=/; Max-Age=0; HttpOnly; SameSite=Lax",
                HttpSession.COOKIE_NAME
        );
        request.exchange.getResponseHeaders().add("Set-Cookie", expiredCookie);
        return "redirect:/ftl/imas/login";
    }

    // http://127.0.0.1:7001/ftl/imas/dashboard
    @RequestMapping(pattern = "/dashboard", description = "模組根目錄")
    public String dashboard(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }

        String jwtToken = SecurityUtils.getOrCreateJwtToken(request, currentUser);
        model.addAttribute("jwtToken", jwtToken);

        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        String baseUrl = Config.get("baseUrl", "http://127.0.0.1:7001");

        TodayReviewInfo reviewResp = qryTodayReview(currentUser);

        if (reviewResp != null) {
            model.addAttribute("todayReviewInfo", reviewResp);
        }
        model.addAttribute("baseUrl", baseUrl);
        model.addAttribute("menuNum", 1);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        return "/home/review";
    }

    @RequestMapping(pattern = "/diagnosis/doctor", description = "診斷/醫師")
    public String diagnosisDoctor(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        try {
            Locale locale = SecurityUtils.getLocale(request);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String toDate = sdf.format(new Date());
            int maxYear = Year.now().getValue();
            Long patientId = Long.parseLong(getValueOfKeyInQuery(request.exchange.getRequestURI(), "patientId"));
            Long slotId = Long.parseLong(getValueOfKeyInQuery(request.exchange.getRequestURI(), "slot"));
            String blogname = Config.get("blogname", "測試平台");

            List<Executor> executors = new ArrayList<Executor>();
            List<User> users = UserAPI.getInstance().listUser();
            if (users != null && users.size() > 0) {
                for (User user : users) {
                    Executor executor = new Executor(user.getId());
                    executor.setName(user.getUsername());
                    executor.setUserNo(user.getAccount());
                    String description = convertToTherapyFieldName(user);
                    executor.setRole(description);
                    executors.add(executor);
                }
            }

            PatientInfo ptInfo = new PatientInfo(patientId, locale);

            List<SyndromeDTO> syndromeList = CrossPlatformUtil.getInstance().listSyndrome();
            Boolean revisit = WgTaskAPI.getInstance().checkFirstDiagnosis(patientId, slotId);

            List<DiseaseCategory> diseases = DiseaseCategoryAPI.getInstance().listLocale(locale);
            List<DrugUseStatusCategory> drugUseStatus = DrugUseStatusCategoryAPI.getInstance().listAll();
            List<MedicationCategory> medicationCategories = MedicationCategoryAPI.getInstance().listLocale(locale);

            model.addAttribute("blogname", blogname);
            model.addAttribute("formId", patientId);
            model.addAttribute("ptInfo", ptInfo);
            model.addAttribute("patientInfo", GsonUtil.toJsonObject(ptInfo));
            model.addAttribute("toDate", toDate);
            model.addAttribute("maxYear", maxYear);
            model.addAttribute("doctors", executors);
            model.addAttribute("revisit", !revisit);
            model.addAttribute("menuNum", 1);
            model.addAttribute("field_abbrev_ename", "ITRI");
            model.addAttribute("currentUser", currentUser);
            model.addAttribute("indications", syndromeList);
            model.addAttribute("__field", "field");
            model.addAttribute("slotId", slotId);
            model.addAttribute("personalDiseaseHistoryItems", diseases);
            model.addAttribute("drugUseStatus", drugUseStatus);
            model.addAttribute("drugAllergyHistoryItems", medicationCategories);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "/casemgnt/diagnosis/doctor/diagnosis";
    }

    @RequestMapping(pattern = "/diagnosis/therapist", description = "診斷/治療師")
    public String diagnosisTherapist(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }

        Locale locale = SecurityUtils.getLocale(request);

        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        int maxYear = Year.now().getValue();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String toDate = sdf.format(new Date());

        Long patientId = Long.parseLong(getValueOfKeyInQuery(request.exchange.getRequestURI(), "patientId"));
        Long slotId = Long.parseLong(getValueOfKeyInQuery(request.exchange.getRequestURI(), "slot"));
        Boolean revisit = WgTaskAPI.getInstance().checkFirstDiagnosis(patientId, slotId);

        PatientInfo ptInfo = new PatientInfo(patientId, locale);
        List<Executor> executors = new ArrayList<Executor>();
        List<User> psy = UserAPI.getInstance().listUserByRole("DTX_PSY");
        List<User> st = UserAPI.getInstance().listUserByRole("DTX_ST");
        List<User> ot = UserAPI.getInstance().listUserByRole("DTX_OT");
        List<User> pi = UserAPI.getInstance().listUserByRole("DTX_PI");
        List<User> users = new ArrayList<User>();
        users.addAll(psy);
        users.addAll(st);
        users.addAll(ot);
        users.addAll(pi);
        if (users != null && users.size() > 0) {
            for (User user : users) {
                if (StringUtils.isEmpty(user.getUsername())) {
                    continue;
                }
                Executor executor = new Executor(user.getId());
                executor.setName(user.getUsername());
                executor.setUserNo(user.getAccount());
                String description = convertToTherapyFieldName(user);
                executor.setRole(description);
                executors.add(executor);
            }
        }

        List<SyndromeDTO> syndromeList = CrossPlatformUtil.getInstance().listSyndrome();
        List<HealthInsuranceRecord> records = HealthInsuranceRecordAPI.getInstance().getRecordsByPatientId(patientId);
        List<DiseaseCategory> diseases = DiseaseCategoryAPI.getInstance().listLocale(locale);
        List<MedicationCategory> medicationCategories = MedicationCategoryAPI.getInstance().listLocale(locale);
        List<DrugUseStatusCategory> drugUseStatus = DrugUseStatusCategoryAPI.getInstance().listAll();

        model.addAttribute("formId", patientId);
        model.addAttribute("ptInfo", ptInfo);
        model.addAttribute("patientInfo", GsonUtil.toJsonObject(ptInfo));
        model.addAttribute("toDate", toDate);
        model.addAttribute("doctorList", executors);
        model.addAttribute("slotId", slotId);
        model.addAttribute("revisit", !revisit);
        model.addAttribute("lessonStoreUrl", ConfigPropertyAPI.getInstance().getConfigPropertyByKey("DtxStoreUrl").getGlobalValue());
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("maxYear", maxYear);
        model.addAttribute("menuNum", 1);
        model.addAttribute("__field", "field");
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("indications", syndromeList);
        model.addAttribute("personalDiseaseHistoryItems", diseases);
        model.addAttribute("drugUseStatus", drugUseStatus);
        model.addAttribute("drugAllergyHistoryItems", medicationCategories);

        List<HcRecordDTO> hcRecordDTOs = new ArrayList<HcRecordDTO>();

        for (HealthInsuranceRecord record : records) {
            User user = UserAPI.getInstance().getUser(record.getCreator());
            List<Role> roles = RoleAPI.getInstance().listRolesByUserId(user.getId());
            UserRoleDTO doctor = new UserRoleDTO(user, roles);
            if (doctor.getRoleAlias().equals("DOCTOR")) {
                HcRecordDTO hcRecordDTO = new HcRecordDTO();
                hcRecordDTO.setId(record.getId());
                hcRecordDTO.setSerialno(record.getId());
                hcRecordDTO.setPatientId(record.getPatientId());
                hcRecordDTO.setDiagDate(sdf.format(record.getCreateTime()));
                hcRecordDTO.setIndication(ptInfo.getIndication());
                hcRecordDTO.setDoctorName(UserAPI.getInstance().getUser(record.getCreator()).getUsername());
                if (record.getMainDiagnosisCode() != null) {
                    WgIcdCode icd = WgIcdCodeAPI.getInstance().getWgIcdCode(Long.parseLong(record.getMainDiagnosisCode()));
                    if (icd != null) {
                        hcRecordDTO.setMainIcdCode(icd.getPureCode() + " " + icd.getName());
                    }
                }
                hcRecordDTOs.add(hcRecordDTO);
            }
        }

        model.addAttribute("hcRecords", hcRecordDTOs);

        return "/casemgnt/diagnosis/therapist/diagnosis";
    }

    // http://127.0.0.1:7001/ftl/imas/casemgnt/caselist
    @RequestMapping(pattern = "/casemgnt/caselist", description = "個案管理/個案清單")
    public String caseList(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String toDate = sdf.format(new Date());
        try {
            Date taskDate = sdf.parse(toDate);

        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("menuNum", 2);

        return "/casemgnt/caseList";
    }

    // http://127.0.0.1:7001/ftl/imas/chatroom
    @RequestMapping(pattern = "/chatroom", description = "協作溝通")
    public String chatroom(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);

        return "/chatroom/chatroom";
    }

    // http://127.0.0.1:7001/ftl/imas
    @RequestMapping(pattern = "/test", description = "測試")
    public String test(RequestData request, Model model) {
        model.addAttribute("string", "testbc");
        model.addAttribute("now", new Date());

        return "/test";
    }

    @RequestMapping(pattern = "/admin/taskMgnt/appointment", description = "預約")
    public String caseAppointment(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String toDate = sdf.format(new Date());
        String clinician = getValueOfKeyInQuery(request.exchange.getRequestURI(), "clinician");
        String doctorId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "doctorId");
        model.addAttribute("moduleContent", clinician + "-booking-content");
        model.addAttribute("pickerId", clinician);
        model.addAttribute("category", clinician);
        model.addAttribute("toDate", toDate);
        if (doctorId != null) {
            model.addAttribute("doctorId", Long.parseLong(doctorId));
        }

        return "/admin/taskMgnt/appointment";
    }

    @RequestMapping(pattern = "/admin/taskMgnt/appointment/msg/chooseMessage", description = "預約")
    public String caseAppointmentMsg(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        String clinician = getValueOfKeyInQuery(request.exchange.getRequestURI(), "clinician");
        model.addAttribute("blogname", blogname);

        model.addAttribute("moduleContent", clinician + "-booking-content");
        model.addAttribute("category", clinician);
        model.addAttribute("message", "chooseMessage");
        return "/admin/taskMgnt/appointment";
    }

    @RequestMapping(pattern = "/diagnosisReport", description = "個案看診紀錄")
    public String diagnosisReport(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String id = getValueOfKeyInQuery(request.exchange.getRequestURI(), "id");
        System.out.println("hcrecord id: " + id);
        HealthInsuranceRecord record = HealthInsuranceRecordAPI.getInstance().getRecord(Long.parseLong(id));
        /* ---------- 評估量表 ---------- */
        DatePeriod datePeriod = getDatePeriod(record.getCreateTime());
        List<Assessment> assessments = AssessmentAPI.getInstance().listByPatientIdTherapistIdParamAndStartEndDate(record.getPatientId(), record.getCreator(), null, datePeriod.getStart(), datePeriod.getEnd());
        try {
            String jsonStr = this.qryHcRecord(record);
            HcRecordResp resp = GsonUtil.fromJson(jsonStr, HcRecordResp.class);
            model.addAttribute("hcInfo", resp);
            String hcInfoString = GsonUtil.toJson(resp);
            model.addAttribute("testHcInfo", hcInfoString);
            ScaleForm scale = null;
            if (assessments.size() > 0) {
                Assessment assessment = assessments.get(0);
                if (assessment.isStatus()) {
                    scale = ScaleAPI.getInstance().findScaleFormByAssessmentId(assessment.getId());
                }
                if (scale != null) {
                    model.addAttribute("scale", scale);
                    String scaleString = GsonUtil.toJson(scale);
                    model.addAttribute("testScale", scaleString);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);

        return "/casemgnt/template/diagnosisReport";
    }

    @RequestMapping(pattern = "/diagnosisReport/msg/chooseMessage")
    public String diagnosisReportChooseReport(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        model.addAttribute("message", "chooseMessage");
        return "/casemgnt/template/diagnosisReport";
    }

    @RequestMapping(pattern = "/admin/other/phraseMgnt", description = "其他設定管理")
    public String phraseManagement(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("menuNum", 6);
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");

        return "/admin/other/phraseMgnt/list";
    }

    @RequestMapping(pattern = "/admin/other/medicalMgnt", description = "其他設定管理")
    public String medicalManagement(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("menuNum", 6);

        return "/admin/other/medicalMgnt/list";
    }

    @RequestMapping(pattern = "/admin/other/medicalMgnt/edit", description = "其他設定管理")
    public String medicalManagementEdit(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("menuNum", 6);

        return "/admin/other/medicalMgnt/edit";
    }

    @RequestMapping(pattern = "/admin/other/deviceMgnt", description = "其他設定管理")
    public String deviceManagement(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("menuNum", 6);

        return "/admin/other/deviceMgnt/list";
    }

    @RequestMapping(pattern = "/admin/other/deviceMgnt/edit", description = "其他設定管理")
    public String deviceManagementEdit(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("menuNum", 6);

        return "/admin/other/deviceMgnt/edit";
    }

    @RequestMapping(pattern = "/admin/other/lessonMgnt", description = "其他設定管理")
    public String lessonManagement(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("menuNum", 6);

        return "/admin/other/lessonMgnt/list";
    }

    @RequestMapping(pattern = "/admin/other/lessonMgnt/edit", description = "其他設定管理")
    public String lessonManagementEdit(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("menuNum", 6);

        return "/admin/other/lessonMgnt/edit";
    }

    @RequestMapping(pattern = "/admin/other/scaleMgnt/test", description = "模組根目錄")
    public String lessonMgntTest(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("menuNum", 6);

        return "/admin/other/scaleMgnt/assessmentDetail";
    }

    @RequestMapping(pattern = "/admin/other/scaleMgnt", description = "其他設定管理")
    public String scaleManagement(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("menuNum", 6);
        model.addAttribute("isNewForm", Boolean.FALSE);

        return "/admin/other/scaleMgnt/list";
    }

    @RequestMapping(pattern = "/admin/other/scaleMgnt/new", description = "其他設定管理")
    public String scaleManagementNew(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("menuNum", 6);
        model.addAttribute("isNewForm", Boolean.TRUE);

        return "/admin/other/scaleMgnt/testScale";
    }

    @RequestMapping(pattern = "/admin/other/scaleMgnt/edit", description = "其他設定管理")
    public String scaleManagementEdit(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("menuNum", 6);

        return "/admin/other/scaleMgnt/detail";
    }

    @RequestMapping(pattern = "/admin/other/scaleMgnt/detail", description = "其他設定管理")
    public String scaleManagementDetail(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("menuNum", 6);

        return "/admin/other/scaleMgnt/detail";
    }

    @RequestMapping(pattern = "/admin/other/scaleMgnt/template/level", description = "模組根目錄")
    public String scaleMgntTemplate(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        model.addAttribute("menuNum", 6);
        return "/casemgnt/template/scaleForm/level_setting";
    }

    @RequestMapping(pattern = "/dtxanalysis", description = "數位治療分析")
    public String dtxAnalysis(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("menuNum", 5);
        return "/report/dtx/dtxAnalysis";
    }

    /**/
    @RequestMapping(pattern = "/admin/taskMgnt/evaluation", description = "個案評估表單")
    public String taskEvaluation(RequestData request, Model model) {

        String patientId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "patientId");
        String formId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "formId"); // 量表ID
        String mode = getValueOfKeyInQuery(request.exchange.getRequestURI(), "mode");

        Assessment assessment = new Assessment();
        ScaleForm scale = new ScaleForm();
        Locale locale = SecurityUtils.getLocale(request);
        assessment = AssessmentAPI.getInstance().getAssessment(Long.parseLong(formId));

        Headers headers = request.exchange.getRequestHeaders();
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);

        boolean isFormExternal = headers.containsKey("X-From-External");
        if (isFormExternal) {
            assessment = AssessmentAPI.getInstance().findByIdAndPatientIdAndTherapistId(Long.parseLong(formId), Long.parseLong(patientId), null);
        } else {
            if (currentUser == null) {
                return "redirect:/ftl/imas/login";
            }
            Long userId = currentUser.getRoleAlias().equals("DOCTOR") ? null : currentUser.getId();
            System.out.println("userId " + userId);
            assessment = AssessmentAPI.getInstance().findByIdAndPatientIdAndTherapistId(Long.parseLong(formId), Long.parseLong(patientId), userId);
        }

        if (assessment != null) {
            PatientInfo patientInfo = PatientInfo.getPatientInfo(assessment.getPatientId(), locale);
            if (assessment.isStatus()) {
                scale = ScaleAPI.getInstance().findScaleFormByAssessmentId(assessment.getId());
            } else {
                scale = ScaleAPI.getInstance().findScaleFormById(assessment.getScaleId());
            }
            scale.setPatientInfo(patientInfo);
            model.addAttribute("scale", scale);
            model.addAttribute("assessmentId", assessment.getId());
        }

        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("blogname", blogname);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("mode", mode);
        model.addAttribute("formId", patientId);
        model.addAttribute("isFromPatient", Boolean.FALSE);
        return "/casemgnt/template/evaluation";
    }

    @RequestMapping(pattern = "/admin/taskMgnt/evaluation/message", description = "個案評估表單")
    public String taskEvaluationMsg(RequestData request, Model model) {
        String msg = getValueOfKeyInQuery(request.exchange.getRequestURI(), "msg");

        System.out.println("msg: " + msg);

        model.addAttribute("message", msg);
        return "/casemgnt/template/evaluation";
    }

    @RequestMapping(pattern = "/admin/dataForm", description = "資料表單")
    public String dataForm(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        String viewer = getValueOfKeyInQuery(request.exchange.getRequestURI(), "viewer");
        return "/casemgnt/template/dataForm/" + viewer;
    }

    @RequestMapping(pattern = "/patient/caseForm/overview", description = "個案表單")
    public String overview(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String patientId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "patientId");
        Locale locale = SecurityUtils.getLocale(request);
        PatientInfo ptInfo = PatientInfo.getPatientInfo(Long.parseLong(patientId), locale);
        model.addAttribute("lessonStoreUrl", ConfigPropertyAPI.getInstance().getConfigPropertyByKey("DtxStoreUrl").getGlobalValue());
        model.addAttribute("blogname", Config.get("blogname", "測試平台"));
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("formId", patientId);
        model.addAttribute("ptInfo", ptInfo);
        model.addAttribute("menuNum", 2);
        return "/casemgnt/overview";
    }

    @RequestMapping(pattern = "/patient/caseForm/analysis", description = "分析")
    public String caseFormAnalysis(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String patientId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "patientId");
        Locale locale = SecurityUtils.getLocale(request);
        PatientInfo ptInfo = PatientInfo.getPatientInfo(Long.parseLong(patientId), locale);

        model.addAttribute("__lang", "zh_TW");
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("formId", patientId);
        model.addAttribute("ptInfo", ptInfo);
        model.addAttribute("menuNum", 2);
        return "/casemgnt/template/caseForm/analysis";
    }

    @RequestMapping(pattern = "/patient/caseForm/assessment", description = "量表")
    public String caseFormAssessment(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String patientId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "patientId");
        Locale locale = SecurityUtils.getLocale(request);
        PatientInfo ptInfo = PatientInfo.getPatientInfo(Long.parseLong(patientId), locale);

        model.addAttribute("__lang", "zh_TW");
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("formId", patientId);
        model.addAttribute("ptInfo", ptInfo);
        model.addAttribute("menuNum", 2);
        return "/casemgnt/template/caseForm/assessment";
    }

    @RequestMapping(pattern = "/patient/caseForm/assessment/charts", description = "量表圖表")
    public String caseFormAssessmentChart(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String formId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "formId");
        model.addAttribute("formId", formId);
        return "/casemgnt/template/caseForm/assessmentChart";
    }

    @RequestMapping(pattern = "/patient/caseForm/plan", description = "診斷")
    public String caseFormPlan(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String patientId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "patientId");
        Locale locale = SecurityUtils.getLocale(request);
        PatientInfo ptInfo = PatientInfo.getPatientInfo(Long.parseLong(patientId), locale);

        model.addAttribute("lessonStoreUrl", ConfigPropertyAPI.getInstance().getConfigPropertyByKey("DtxStoreUrl").getGlobalValue());
        model.addAttribute("__lang", "zh_TW");
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("formId", patientId);
        model.addAttribute("ptInfo", ptInfo);
        model.addAttribute("menuNum", 2);
        return "/casemgnt/template/caseForm/plan";
    }

    @RequestMapping(pattern = "/patient/caseForm/notes", description = "備註")
    public String caseFormNotes(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String patientId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "patientId");
        Locale locale = SecurityUtils.getLocale(request);
        PatientInfo ptInfo = PatientInfo.getPatientInfo(Long.parseLong(patientId), locale);

        model.addAttribute("__lang", "zh_TW");
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("formId", patientId);
        model.addAttribute("ptInfo", ptInfo);
        model.addAttribute("menuNum", 2);
        return "/casemgnt/template/caseForm/notes";
    }

    @RequestMapping(pattern = "/patient/caseForm/profile", description = "資料")
    public String caseFormProfile(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        Locale locale = SecurityUtils.getLocale(request);
        String patientId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "patientId");
        PatientInfo ptInfo = PatientInfo.getPatientInfo(Long.parseLong(patientId), locale);
        int maxYear = Year.now().getValue();

        List<SyndromeDTO> syndromeList = CrossPlatformUtil.getInstance().listSyndrome();
        List<HealthInsuranceRecord> records = HealthInsuranceRecordAPI.getInstance().getRecordsByPatientId(Long.parseLong(patientId));
        List<DiseaseCategory> diseases = DiseaseCategoryAPI.getInstance().listLocale(locale);
        List<MedicationCategory> medicationCategories = MedicationCategoryAPI.getInstance().listLocale(locale);
        List<DrugUseStatusCategory> drugUseStatus = DrugUseStatusCategoryAPI.getInstance().listAll();

        model.addAttribute("patientInfo", GsonUtil.toJsonObject(ptInfo));
        model.addAttribute("personalDiseaseHistoryItems", diseases);
        model.addAttribute("drugUseStatus", drugUseStatus);
        model.addAttribute("drugAllergyHistoryItems", medicationCategories);
        model.addAttribute("__lang", "zh_TW");
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("maxYear", maxYear);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("formId", patientId);
        model.addAttribute("ptInfo", ptInfo);
        model.addAttribute("menuNum", 2);
        return "/casemgnt/template/caseForm/profile";
    }

    @RequestMapping(pattern = "/patient/caseForm/visits", description = "複診")
    public String caseFormVisits(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String patientId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "patientId");
        Locale locale = SecurityUtils.getLocale(request);
        PatientInfo ptInfo = PatientInfo.getPatientInfo(Long.parseLong(patientId), locale);

        List<HcRecordDTO> hcRecordDTOs = new ArrayList<HcRecordDTO>();
        //List<HealthInsuranceRecord> records = HealthInsuranceRecordAPI.getInstance().getRecordsByPatientId(Long.parseLong(patientId));
        List<HealthInsuranceRecord> records = HealthInsuranceRecordAPI.getInstance().getDoctorVisitsByPatient(Long.parseLong(patientId));
        int diagTimes = records.size() - 1 ;
        for (HealthInsuranceRecord record : records) {
            User user = UserAPI.getInstance().getUser(record.getCreator());
            List<Role> roles = RoleAPI.getInstance().listRolesByUserId(user.getId());
            UserRoleDTO doctor = new UserRoleDTO(user, roles);
                HcRecordDTO hcRecordDTO = new HcRecordDTO();
                hcRecordDTO.setId(record.getId());
                hcRecordDTO.setDiagTimes(diagTimes);
                diagTimes--;
                System.out.println("diagTimes: " + diagTimes + " diagTimes: " + diagTimes);
                if(diagTimes == 0) {
                    hcRecordDTO.setIsFirstDiag(true);
                } else {
                    hcRecordDTO.setIsFirstDiag(false);
                }
                hcRecordDTO.setDiagDateTime(HealthInsuranceRecordAPI.getInstance().fullDateFormat(record.getCreateTime()));
                hcRecordDTO.setDoctorAlias(doctor.getRoleName());
                WgIcdCode codeObj = WgIcdCodeAPI.getInstance().getWgIcdCode(Long.parseLong(record.getMainDiagnosisCode()));
                if(codeObj != null) {
                    hcRecordDTO.setIcdCode(codeObj.getCode() + " " + codeObj.getName());
                }
                hcRecordDTO.setSerialno(record.getId());
                hcRecordDTO.setPatientId(record.getPatientId());
                hcRecordDTO.setDiagDate(sdf.format(record.getCreateTime()));
                hcRecordDTO.setIndication(ptInfo.getIndication());
                hcRecordDTO.setDoctorName(UserAPI.getInstance().getUser(record.getCreator()).getUsername());
                if (record.getMainDiagnosisCode() != null) {
                    WgIcdCode icd = WgIcdCodeAPI.getInstance().getWgIcdCode(Long.parseLong(record.getMainDiagnosisCode()));
                    if (icd != null) {
                        hcRecordDTO.setMainIcdCode(icd.getPureCode() + " " + icd.getName());
                    }
                }
                hcRecordDTOs.add(hcRecordDTO);
                    }

        // 取得醫師和治療師最後看診時間以及治療週數
        String lastDoctorVisit = HealthInsuranceRecordAPI.getInstance().getLastDoctorVisitTime(Long.parseLong(patientId));
        System.out.println("lastDoctorVisit: " + lastDoctorVisit);
        String lastTherapistVisit = HealthInsuranceRecordAPI.getInstance().getLastTherapistVisitTime(Long.parseLong(patientId));
        System.out.println("lastTherapistVisit: " + lastTherapistVisit);
        int treatmentWeeks = HealthInsuranceRecordAPI.getInstance().calculateTreatmentWeeks(Long.parseLong(patientId));
        System.out.println("treatmentWeeks: " + treatmentWeeks);
        
        
        model.addAttribute("hcRecords", hcRecordDTOs);
        model.addAttribute("lastDoctorVisit", lastDoctorVisit);
        model.addAttribute("lastTherapistVisit", lastTherapistVisit);
        model.addAttribute("treatmentWeeks", treatmentWeeks);
        model.addAttribute("__lang", "zh_TW");
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("formId", patientId);
        model.addAttribute("ptInfo", ptInfo);
        model.addAttribute("menuNum", 2);
        return "/casemgnt/template/caseForm/visits";
    }

    @RequestMapping(pattern = "/patient/analysis", description = "空訊息")
    public String patientAnalysisEmptyMessage(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        
        String msg = getValueOfKeyInQuery(request.exchange.getRequestURI(), "msg");
        model.addAttribute("lessonStoreUrl", ConfigPropertyAPI.getInstance().getConfigPropertyByKey("DtxStoreUrl").getGlobalValue());
        System.out.println("msg: " + msg);
        model.addAttribute("message", msg);
        model.addAttribute("planId", 0);
        return "/casemgnt/template/caseForm/analysis";
    }

    @RequestMapping(pattern = "/patient/analysis/detail", description = "詳細資料")
    public String patientAnalysisDetail(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        Locale locale = SecurityUtils.getLocale(request);
        String patientId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "patientId");
        String planId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "planId");
        System.out.println("patientId: " + patientId);
        System.out.println("planId: " + planId);
        TrainingPlan trainingPlan = TrainingPlanAPI.getInstance().getTrainingPlan(Long.parseLong(planId));
        TrainingPlanDTO trainingPlanDTO = TrainingPlanAPI.getInstance().convertPlanDTO(trainingPlan);
        PatientInfo ptInfo = PatientInfo.getPatientInfo(Long.parseLong(patientId), locale);
        model.addAttribute("lessonStoreUrl", ConfigPropertyAPI.getInstance().getConfigPropertyByKey("DtxStoreUrl").getGlobalValue());
        model.addAttribute("planId", planId);
        model.addAttribute("trainingPlan", GsonUtil.toJson(trainingPlanDTO));
        model.addAttribute("formId", patientId);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("ptInfo", ptInfo);
        return "/casemgnt/template/caseForm/analysis";
    }

    public TodayReviewInfo qryTodayReview(UserRoleDTO currentUser) {
        try {
            TodayReviewInfo info = new TodayReviewInfo();

            List<CaseAppoEvent> appoEvents = new ArrayList<CaseAppoEvent>();
            List<TrainingEvent> trainingEvents = getTrainingEvents(currentUser);
            // 取得今天的預約資料
            List<WgTask> tasks = WgTaskAPI.getInstance().listWgTaskByCreatorAndDate(currentUser.getId(), new Date());
            if (tasks.size() > 0) {
                // 如果預約資料不為空，則轉換成 CaseAppoEvent
                appoEvents = WgTaskAPI.getInstance().convertToCaseAppoEventList(tasks);
                info.setAppoEvents(appoEvents);
                int waitCheckinCount = (int) appoEvents.stream()
                        .filter(event -> event.getCheckinTime() == null || event.getCheckinTime().isBlank())
                        .count();
                info.setWaitCheckinNum(waitCheckinCount);
            }
            info.setTrainingEvents(trainingEvents);
            return info;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<TrainingEvent> getTrainingEvents(UserRoleDTO currentUser) {
        Instant now = Instant.now();
        List<TrainingEvent> trainingEvents = new ArrayList<TrainingEvent>();
        List<Role> roles = currentUser.getRoles();
        boolean isAdminOrDoctor = roles.stream()
                .anyMatch(role -> role.getId() == 2 || role.getId() == 3);

        if (isAdminOrDoctor) {
            List<WgTask> taskList = WgTaskAPI.getInstance().listWgTaskByCreator(currentUser.getId());
            if (taskList != null && taskList.size() > 0) {
                Map<Long, WgTask> latestTaskMap = new HashMap<>();
                for (WgTask task : taskList) {
                    if (task.getCheckinTime() == null) {
                        continue;
                    }
                    Instant taskModifyInstant = task.getModifyTime().toInstant();

                    // 如果當前 caseNo 已經存在於 map 中，並且該 task 的 modifyTime 比已存在的 task 更新，則替換
                    if (latestTaskMap.containsKey(task.getCaseNo())) {
                        WgTask existingTask = latestTaskMap.get(task.getCaseNo());
                        Instant existingTaskModifyInstant = existingTask.getModifyTime().toInstant();

                        if (taskModifyInstant.isAfter(existingTaskModifyInstant)) {
                            latestTaskMap.put(task.getCaseNo(), task);
                        }
                    } else {
                        latestTaskMap.put(task.getCaseNo(), task); // 如果該 caseNo 尚未存在於 map 中，則直接加入
                    }
                }
                for (WgTask task : latestTaskMap.values()) {
                    TrainingEvent trainingEvent = new TrainingEvent();
                    Patient patient = PatientAPI.getInstance().getPatient(task.getCaseNo());
                    List<TrainingPlan> trainingPlans = TrainingPlanAPI.getInstance().listByPatient(patient.getId());
                    if (trainingPlans.isEmpty()) {
                        continue;
                    } else {
                        ZoneId zone = ZoneId.of("Asia/Taipei");
                        Iterator<TrainingPlan> iterator = trainingPlans.iterator();
                        // 移除在startDate和endDate之外的計畫
                        while (iterator.hasNext()) {
                            TrainingPlan plan = iterator.next();
                            Instant start = plan.getStartDate().toInstant();
                            Instant end = plan.getEndDate().toInstant();
                            if (now.isBefore(start) || now.isAfter(end)) {
                                iterator.remove();
                            }
                        }

                        // 將剩餘的training plan 放入trainingEvent
                        if (trainingPlans.isEmpty()) {
                            continue;
                        } else {
                            TrainingPlan firstPlan = trainingPlans.get(0);
                            User therapist = UserAPI.getInstance().getUser(firstPlan.getTherapist());
                            trainingEvent.setSerialno(firstPlan.getId().intValue());
                            trainingEvent.setName(patient.getName());
                            trainingEvent.setGender(patient.getGender());
                            trainingEvent.setAge(String.valueOf(patient.getAge()));
                            trainingEvent.setIndication(
                                    CrossPlatformUtil.getInstance().findSyndromeById(patient.getDiseaseId()));
                            trainingEvent.setTherapist(therapist.getUsername());
                            trainingEvent.setTherapCat(convertToTherapyFieldName(therapist));
                            List<Long> lessonIds = PlanLessonMappingAPI.getInstance()
                                    .listLessonIdsByPlanId(firstPlan.getId());
                            Long lessonId = lessonIds.get(0);
                            trainingEvent.setLesson(CrossPlatformUtil.getInstance().getLessonName(lessonId));
                            trainingEvent.setIsAbnormal(false);
                            trainingEvents.add(trainingEvent);
                        }
                    }
                }
            }
        } else {
            Map<Long, WgTask> latestTaskMap = new HashMap<>();
            List<WgTask> taskList = WgTaskAPI.getInstance().listWgTaskByUserAndCat(currentUser.getId(), 2);
            for (WgTask task : taskList) {
                if (task.getCheckinTime() == null) {
                    continue;
                }

                Instant taskModifyInstant = task.getModifyTime().toInstant();

                // 如果當前 caseNo 已經存在於 map 中，並且該 task 的 modifyTime 比已存在的 task 更新，則替換
                if (latestTaskMap.containsKey(task.getCaseNo())) {
                    WgTask existingTask = latestTaskMap.get(task.getCaseNo());
                    Instant existingTaskModifyInstant = existingTask.getModifyTime().toInstant();

                    if (taskModifyInstant.isAfter(existingTaskModifyInstant)) {
                        latestTaskMap.put(task.getCaseNo(), task);
                    }
                } else {
                    latestTaskMap.put(task.getCaseNo(), task); // 如果該 caseNo 尚未存在於 map 中，則直接加入
                }
            }
            for (WgTask task : latestTaskMap.values()) {
                TrainingEvent trainingEvent = new TrainingEvent();
                Patient patient = PatientAPI.getInstance().getPatient(task.getCaseNo());
                List<TrainingPlan> trainingPlans = TrainingPlanAPI.getInstance().listByPatient(patient.getId());
                String startTimeStr = "";
                String endTimeStr = "";
                LocalDate startDate = null;
                LocalDate endDate = null;
                if (trainingPlans.isEmpty()) {
                    continue;
                } else {
                    ZoneId zone = ZoneId.of("Asia/Taipei");
                    Iterator<TrainingPlan> iterator = trainingPlans.iterator();
                    // 移除在startDate和endDate之外的計畫
                    while (iterator.hasNext()) {
                        TrainingPlan plan = iterator.next();
                        Instant start = plan.getStartDate().toInstant();
                        Instant end = plan.getEndDate().toInstant();
                        if (now.isBefore(start) || now.isAfter(end)) {
                            iterator.remove();
                        }
                    }
                    // 將剩餘的training plan 放入trainingEvent
                    if (trainingPlans.isEmpty()) {
                        continue;
                    } else {
                        TrainingPlan firstPlan = trainingPlans.get(0);
                        // 取得 ZonedDateTime
                        ZonedDateTime zdtStart = firstPlan.getStartDate().toInstant().atZone(zone);
                        ZonedDateTime zdtEnd = firstPlan.getEndDate().toInstant().atZone(zone);

                        // 取 LocalDate
                        startDate = zdtStart.toLocalDate();
                        endDate = zdtEnd.toLocalDate();

                        // 格式化字串（如果你需要）
                        startTimeStr = zdtStart.toLocalDate().toString();
                        endTimeStr = zdtEnd.toLocalDate().toString();
                        Long patientId = patient.getId();
                        trainingEvent.setName(patient.getName());

                        trainingEvent.setGender(patient.getGender());
                        trainingEvent.setAge(String.valueOf(patient.getAge()));

                        trainingEvent.setIndication(
                                CrossPlatformUtil.getInstance().findSyndromeById(patient.getDiseaseId()));
                        List<Long> lessonIds = PlanLessonMappingAPI.getInstance()
                                .listLessonIdsByPlanId(firstPlan.getId());
                        Long lessonId = lessonIds.get(0);
                        trainingEvent.setLesson(CrossPlatformUtil.getInstance().getLessonName(lessonId));
                        trainingEvent.setIsAbnormal(false);

                        Integer freqWeek = firstPlan.getFrequencyPerWeek();
                        Integer freqDay = firstPlan.getFrequencyPerDay();

                        if (freqWeek != null) {
                            // 真正有設定每週頻率
                            trainingEvent.setFrequency("每週");
                            trainingEvent.setTimes(String.valueOf(freqWeek));
                        } else if (freqDay != null) {
                            trainingEvent.setFrequency("每天");
                            trainingEvent.setTimes(String.valueOf(freqDay));
                        }

                        long weeksBetween = ChronoUnit.WEEKS.between(startDate, endDate);
                        trainingEvent.setBeginDate(startTimeStr.replace("/", "-"));
                        trainingEvent.setDuration(String.valueOf(weeksBetween));
                        trainingEvents.add(trainingEvent);
                    }
                }
            }
        }
        return trainingEvents;
    }

    private String convertToTherapyFieldName(User therapist) {
        List<Role> roles = RoleAPI.getInstance().listRolesByUserId(therapist.getId());

        // Use find first matching role instead of forEach
        for (Role role : roles) {
            switch (role.getId().intValue()) {
                case 4:
                case 5:
                case 6:
                case 7:
                    return role.getDescription();
            }
        }

        // Default return if no matching role is found
        return "未知";
    }

    /* ---------- 輔助方法 ---------- */
    private Long safeParseLong(String s) {
        try {
            return (s == null || s.isBlank()) ? null : Long.parseLong(s);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private boolean isParsable(String s) {
        return s != null && !s.isBlank() && s.chars().allMatch(Character::isDigit);
    }

    private String qryHcRecord(HealthInsuranceRecord hir) {
        String jsonStr = "";
        JSONObject result = new JSONObject();
        try {
            String name = "", gender = "", age = "", birth = "", charNo = "", idNo = "", address = "";
            String divisionName = "", diagnosis = "", order = "";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String printTime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
            if (hir == null) {
                return null;
            }
            HcRecordResp resp = new HcRecordResp();
            if (hir != null) {
                resp.setId(hir.getId());
                resp.setEvalDate(sdf.format(hir.getCreateTime()));
                resp.setSubjective(hir.getSubjective());
                resp.setObjective(hir.getObjective());
                resp.setMainIcdCode(convertToIcdName(hir.getMainDiagnosisCode()));
                List<String> subCodes = hir.getSecondaryDiagnosisCodes();
                List<Consumer<CodeItem>> setters = List.of(
                        resp::setSubIcdCode1,
                        resp::setSubIcdCode2,
                        resp::setSubIcdCode3,
                        resp::setSubIcdCode4,
                        resp::setSubIcdCode5
                );
                for (int i = 0; i < subCodes.size() && i < setters.size(); i++) {
                    CodeItem item = convertToIcdName(subCodes.get(i));
                    setters.get(i).accept(item);
                }

                resp.setCoPaymentCode(convertToCopaymentName(hir.getCopaymentCode()));
                resp.setTotal_points(String.valueOf(hir.getTotalPoint()));
                resp.setPart_points(String.valueOf(hir.getCopayment()));
                resp.setSerial_no(hir.getSerialNum());
                List<TherapeuticTreatment> treatments = TherapeuticTreatmentAPI.getInstance().getTreatmentsByHiRecordId(hir.getId());
                if (treatments.size() > 0) {
                    List<PaymentItem> items = new ArrayList<PaymentItem>();
                    for (TherapeuticTreatment treatment : treatments) {
                        PaymentItem item = new PaymentItem();
                        item.setKeyno(treatment.getId());
                        item.setPaymentItemCode(convertToPaymentName(treatment.getTreatmentCode()));
                        item.setAmount(treatment.getTotalMount());
                        item.setPoints(String.valueOf(treatment.getPoint()));
                        item.setExecutor(getUserName(treatment.getExecutiveId()));
                        item.setBeginTime(sdf.format(treatment.getStartTime()));
                        item.setEndTime(sdf.format(treatment.getEndTime()));
                        items.add(item);
                    }
                    resp.setPaymentItems(items);
                }
            }
            return GsonUtil.toJson(resp);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private CodeItem convertToIcdName(String code) {
        CodeItem icdCode = new CodeItem();
        if (StringUtils.isNotEmpty(code)) {
            WgIcdCode obj = WgIcdCodeAPI.getInstance().getWgIcdCode(Long.parseLong(code));

            icdCode.setCode(obj.getCode());
            icdCode.setCodeTxt(obj.getCode() + " " + obj.getName());
            icdCode.setViewTxt(obj.getCode() + " " + obj.getName() + " (" + obj.getEnName() + ")");
        }
        return icdCode;
    }

    private CodeItem convertToCopaymentName(String code) {
        CodeItem paymentCode = new CodeItem();
        if (StringUtils.isNotEmpty(code)) {
            paymentCode.setCode(code);
            if (code.equals("K00")) {
                paymentCode.setCodeTxt("K00(居家照護)-部分負擔醫療費用5%");
            } else {
                paymentCode.setCodeTxt("K20(居家照護且開立藥品)-部分負擔醫療費用(扣除藥費與藥事服務費5%+藥品部分負擔)");
            }
        }
        return paymentCode;
    }

    private CodeItem convertToPaymentName(String code) {
        CodeItem paymentCode = new CodeItem();
        if (StringUtils.isNotEmpty(code)) {
            MedicalServicePaymentItems obj = MedicalServicePaymentItemsAPI.getInstance().findByCode(code);
            paymentCode.setCode(code);
            paymentCode.setCodeTxt("[" + code + "] " + obj.getZhItem());
        }
        return paymentCode;
    }

    private CodeItem getUserName(Long userNo) {
        CodeItem executor = new CodeItem();
        if (userNo != null) {
            User user = UserAPI.getInstance().getUser(userNo);
            executor.setCode(String.valueOf(userNo));
            executor.setCodeTxt("[" + user.getAccount() + "] " + user.getUsername());
        }
        return executor;
    }

    private DatePeriod getDatePeriod(Date theDay) {

        // 1. 取得當天 00:00:00
        Calendar cal = Calendar.getInstance();
        cal.setTime(theDay);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date startOfDay = cal.getTime();

        // 2. 加一天，作為隔天 00:00:00
        cal.add(Calendar.DATE, 1);
        Date startOfNextDay = cal.getTime();

        return new DatePeriod(startOfDay, startOfNextDay);
    }

    private class DatePeriod {

        private Date start;
        private Date end;

        public DatePeriod(Date start, Date end) {
            this.start = start;
            this.end = end;
        }

        public Date getStart() {
            return start;
        }

        public Date getEnd() {
            return end;
        }
    }
}
