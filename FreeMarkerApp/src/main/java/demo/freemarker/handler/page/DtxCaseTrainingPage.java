/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.handler.page;

import java.time.Year;
import java.util.List;

import demo.freemarker.api.ConfigPropertyAPI;
import demo.freemarker.api.DiseaseCategoryAPI;
import demo.freemarker.api.DrugUseStatusCategoryAPI;
import demo.freemarker.api.MedicationCategoryAPI;
import demo.freemarker.api.training.TrainingPlanAPI;
import demo.freemarker.core.CrossPlatformUtil;
import demo.freemarker.core.GsonUtil;
import demo.freemarker.core.SecurityUtils;
import demo.freemarker.dto.SyndromeDTO;
import demo.freemarker.dto.TrainingPlanDTO;
import demo.freemarker.dto.UserRoleDTO;
import demo.freemarker.model.DiseaseCategory;
import demo.freemarker.model.DrugUseStatusCategory;
import demo.freemarker.model.MedicationCategory;
import demo.freemarker.model.training.TrainingPlan;
import itri.sstc.framework.core.Config;
import itri.sstc.freemarker.core.Model;
import itri.sstc.freemarker.core.RequestData;
import itri.sstc.freemarker.core.RequestHandler;
import java.util.Locale;

/**
 *
 * @author zhush
 */
public class DtxCaseTrainingPage extends RequestHandler {

    @Override
    public String getName() {
        return "casetraining";
    }

    @RequestMapping(pattern = "/infoComplete", description = "模組根目錄")
    public String infoComplete(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        Locale locale = SecurityUtils.getLocale(request);
        List<SyndromeDTO> syndromeList = CrossPlatformUtil.getInstance().listSyndrome();
        
        List<DiseaseCategory> diseases = DiseaseCategoryAPI.getInstance().listLocale(locale);
        List<DrugUseStatusCategory> drugUseStatus = DrugUseStatusCategoryAPI.getInstance().listAll();
        List<MedicationCategory> medicationCategories = MedicationCategoryAPI.getInstance().listLocale(locale);
        
        int maxYear = Year.now().getValue();

        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("__field", "field");
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("indications", syndromeList);
        model.addAttribute("blogname", blogname);
        model.addAttribute("field_abbrev_ename", "ITRI");
        model.addAttribute("maxYear", maxYear);
        model.addAttribute("personalDiseaseHistoryItems", diseases);
        model.addAttribute("drugUseStatus", drugUseStatus);
        model.addAttribute("drugAllergyHistoryItems", medicationCategories);
        return "/infoComplete";
    }

    @RequestMapping(pattern = "/caseDashboard", description = "個案dashboard")
    public String caseDashboard(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("lessonStoreUrl", ConfigPropertyAPI.getInstance().getConfigPropertyByKey("DtxStoreUrl").getGlobalValue());
        model.addAttribute("__field", "field");
        model.addAttribute("menuNum", 1);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("blogname", blogname);
        model.addAttribute("field_abbrev_ename", "ITRI");
        return "/dashboard";
    }

    @RequestMapping(pattern = "/trainingPlan", description = "個案訓練計畫")
    public String trainingPlan(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String planId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "planId");
        TrainingPlan trainingPlan = TrainingPlanAPI.getInstance().getTrainingPlan(Long.parseLong(planId));
        TrainingPlanDTO trainingPlanDTO = TrainingPlanAPI.getInstance().convertPlanDTO(trainingPlan);
        String blogname = Config.get("blogname", "測試平台");
        model.addAttribute("lessonStoreUrl", ConfigPropertyAPI.getInstance().getConfigPropertyByKey("DtxStoreUrl").getGlobalValue());
        model.addAttribute("planId", planId);
        model.addAttribute("trainingPlan", GsonUtil.toJson(trainingPlanDTO));
        model.addAttribute("__field", "field");
        model.addAttribute("menuNum", 1);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("blogname", blogname);
        model.addAttribute("field_abbrev_ename", "ITRI");
        return "/trainingPlan";
    }

    @RequestMapping(pattern = "/trainingQuestion", description = "個案提問")
    public String trainingQuestion(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String planId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "planId");
        String blogname = Config.get("blogname", "測試平台");
        TrainingPlan trainingPlan = TrainingPlanAPI.getInstance().getTrainingPlan(Long.parseLong(planId));
        TrainingPlanDTO trainingPlanDTO = TrainingPlanAPI.getInstance().convertPlanDTO(trainingPlan);
        
        model.addAttribute("__field", "field");
        model.addAttribute("menuNum", 1);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("lessonStoreUrl", ConfigPropertyAPI.getInstance().getConfigPropertyByKey("DtxStoreUrl").getGlobalValue());
        model.addAttribute("planId", planId);
        model.addAttribute("trainingPlan", GsonUtil.toJson(trainingPlanDTO));
        model.addAttribute("blogname", blogname);
        model.addAttribute("field_abbrev_ename", "ITRI");
        return "/trainingQuestion";
    }

    @RequestMapping(pattern = "/trainingRecord", description = "個案訓練紀錄")
    public String trainingRecord(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        String planId = getValueOfKeyInQuery(request.exchange.getRequestURI(), "planId");
        String blogname = Config.get("blogname", "測試平台");
        TrainingPlan trainingPlan = TrainingPlanAPI.getInstance().getTrainingPlan(Long.parseLong(planId));
        TrainingPlanDTO trainingPlanDTO = TrainingPlanAPI.getInstance().convertPlanDTO(trainingPlan);
        model.addAttribute("lessonStoreUrl", ConfigPropertyAPI.getInstance().getConfigPropertyByKey("DtxStoreUrl").getGlobalValue());
        model.addAttribute("planId", planId);
        model.addAttribute("trainingPlan", GsonUtil.toJson(trainingPlanDTO));
        model.addAttribute("__field", "field");
        model.addAttribute("menuNum", 1);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("blogname", blogname);
        model.addAttribute("field_abbrev_ename", "ITRI");
        return "/trainingRecord";
    }
}
