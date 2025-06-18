/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.handler.page;

import demo.freemarker.core.SecurityUtils;
import demo.freemarker.dto.UserRoleDTO;
import itri.sstc.freemarker.core.Model;
import itri.sstc.freemarker.core.RequestData;
import itri.sstc.freemarker.core.RequestHandler;

/**
 *
 * @author zhush
 */
public class DtxCaseTrainingPage extends RequestHandler {

    @Override
    public String getName() {
        return "casetraining";
    }
    
    @RequestMapping(pattern = "infoComplete", description = "模組根目錄")
    public String infoComplete(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        return "infoComplete";
    }
    
    @RequestMapping(pattern = "caseDashboard", description = "個案dashboard")
    public String caseDashboard(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        return "dashboard";
    }
    
    @RequestMapping(pattern = "trainingPlan", description = "個案訓練計畫")
    public String trainingPlan(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        return "trainingPlan";
    }
    
    @RequestMapping(pattern = "trainingQuestion", description = "個案提問")
    public String trainingQuestion(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        return "trainingQuestion";
    }

    @RequestMapping(pattern = "trainingRecord", description = "個案訓練紀錄")
    public String trainingRecord(RequestData request, Model model) {
        UserRoleDTO currentUser = SecurityUtils.getCurrentUser(request);
        if (currentUser == null) {
            return "redirect:/ftl/imas/login";
        }
        return "trainingRecord";
    }
}
