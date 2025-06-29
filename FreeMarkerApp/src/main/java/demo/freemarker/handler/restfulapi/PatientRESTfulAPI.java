package demo.freemarker.handler.restfulapi;

import com.sun.net.httpserver.HttpExchange;
import demo.freemarker.api.DiseaseCategoryAPI;
import demo.freemarker.api.DrugUseStatusCategoryAPI;
import demo.freemarker.api.MedicationCategoryAPI;
import demo.freemarker.api.OtherPatientInfoAPI;
import demo.freemarker.api.PatientAPI;
import demo.freemarker.api.RoleAPI;
import demo.freemarker.api.SpeechDevIssueCategoryAPI;
import demo.freemarker.api.UserAPI;
import demo.freemarker.api.WgIcdCodeAPI;
import demo.freemarker.api.healthinsurance.HealthInsuranceRecordAPI;
import demo.freemarker.core.GsonUtil;
import demo.freemarker.core.SecurityUtils;
import demo.freemarker.core.StringUtils;
import demo.freemarker.dto.QryPtInfoDTO;
import demo.freemarker.dto.UserRoleDTO;
import demo.freemarker.model.DiseaseCategory;
import demo.freemarker.model.DrugUseStatusCategory;
import demo.freemarker.model.MedicationCategory;
import demo.freemarker.model.OtherPatientInfo;
import demo.freemarker.model.Patient;
import demo.freemarker.model.Role;
import demo.freemarker.model.SpeechDevIssueCategory;
import demo.freemarker.model.User;
import demo.freemarker.model.WgIcdCode;
import demo.freemarker.model.healthinsurance.HealthInsuranceRecord;
import itri.sstc.framework.core.api.RESTfulAPI;
import itri.sstc.framework.core.database.EntityUtility;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class PatientRESTfulAPI extends RESTfulAPI {

    private static final Logger LOGGER = Logger.getLogger(PatientRESTfulAPI.class.getName());
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    public PatientRESTfulAPI() {
    }

    @Override
    public String getContextPath() {
        return "/Patient/api/";
    }

    @RESTfulAPIDefine(url = "info", methods = "get", description = "取得 API 資訊")
    private String info(HttpExchange exchange) throws IOException {
        String json = String.format("{ \"name\": \"%s\", \"version\": \"%s\", \"desc\": \"%s\" }",
                PatientAPI.getInstance().getName(),
                PatientAPI.getInstance().getVersion(),
                PatientAPI.getInstance().getDescription());
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return json;
    }

    @RESTfulAPIDefine(url = "scheme", methods = "get", description = "取得資料表 Scheme")
    private String scheme(HttpExchange exchange) throws IOException {
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.entityScheme(Patient.class);
    }

    @RESTfulAPIDefine(url = "list", methods = "get", description = "列出所有病患")
    private String list(HttpExchange exchange) throws IOException {
        List<Patient> patients = PatientAPI.getInstance().listPatient();
        exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
        return EntityUtility.toJSONArrayString(patients);
    }

    @RESTfulAPIDefine(url = "editPatientInfo", methods = "post", description = "編輯病患資料")
    private String editPatientInfo(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        System.out.println("Received request to edit patient info");
        try {
            // 讀取並驗證請求資料
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            if (requestBody == null || requestBody.trim().isEmpty()) {
                return createErrorResponse(exchange, HttpURLConnection.HTTP_BAD_REQUEST,
                        "請求資料不能為空");
            }

            JSONObject requestJson;
            try {
                requestJson = new JSONObject(requestBody);
            } catch (JSONException e) {
                LOGGER.log(Level.WARNING, "JSON 解析失敗: " + e.getMessage());
                return createErrorResponse(exchange, HttpURLConnection.HTTP_BAD_REQUEST,
                        "JSON 格式錯誤: " + e.getMessage());
            }

            // 驗證必要欄位
            if (!requestJson.has("patientId") || requestJson.isNull("patientId")) {
                return createErrorResponse(exchange, HttpURLConnection.HTTP_BAD_REQUEST,
                        "病患 ID 不能為空");
            }

            Long patientId;
            try {
                patientId = requestJson.getLong("patientId");
            } catch (JSONException e) {
                return createErrorResponse(exchange, HttpURLConnection.HTTP_BAD_REQUEST,
                        "病患 ID 格式錯誤");
            }

            // 取得現有病患資料
            Patient patient = PatientAPI.getInstance().getPatient(patientId);
            if (patient == null) {
                return createErrorResponse(exchange, HttpURLConnection.HTTP_NOT_FOUND,
                        "找不到指定的病患資料");
            }

            // 開始原子更新操作
            boolean updateResult = performAtomicUpdate(patient, requestJson);

            if (updateResult) {
                responseJson.put("success", true);
                responseJson.put("message", "病患資料更新成功");
                responseJson.put("patientId", patientId);
                exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            } else {
                return createErrorResponse(exchange, HttpURLConnection.HTTP_INTERNAL_ERROR,
                        "資料更新失敗");
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "編輯病患資料時發生錯誤: " + e.getMessage(), e);
            return createErrorResponse(exchange, HttpURLConnection.HTTP_INTERNAL_ERROR,
                    "伺服器內部錯誤: " + e.getMessage());
        }

        return responseJson.toString();
    }

    @RESTfulAPIDefine(url = "qryPatientList", methods = "post", description = "取得病患資料")
    private String qryPatientList(HttpExchange exchange) throws IOException {
        JSONObject result = new JSONObject();
        try {
            Locale locale = SecurityUtils.getLocale(exchange);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String evalDate = sdf.format(new Date());
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            List<Role> roles = RoleAPI.getInstance().listRolesByUserId(currentUser.getId());
            UserRoleDTO cUser = new UserRoleDTO(currentUser, roles);
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            System.out.println("resquest: " + requestBody);
            QryPtInfoDTO info = GsonUtil.fromJson(requestBody, QryPtInfoDTO.class);

            int totalSize = 0;
            
            List<QryInfoResp> totalResult = new ArrayList<QryInfoResp>();
            // 查詢病患基本資料
            String sortBy = convertValue(info.sort);
            String orderBy = convertValue(info.order);
            String orderStr = "";
            
            List<Patient> patients = PatientAPI.getInstance().listPatient();
            if(patients.size() > 0){
                System.out.println("patient size: " + patients.size());
                totalSize = patients.size();
                for (Patient patient : patients){
                    QryInfoResp qir = new QryInfoResp();
                    HealthInsuranceRecord hcRecord = HealthInsuranceRecordAPI.getInstance().getLatestDoctorVisitByPatient(patient.getId());
                    if(hcRecord != null ){
                        WgIcdCode icdCode = WgIcdCodeAPI.getInstance().getWgIcdCode(Long.parseLong(hcRecord.getMainDiagnosisCode()));
                        qir.diagnosis = icdCode.getPureCode() + " " + icdCode.getName();
                        qir.newVisitDate = sdf.format(hcRecord.getCreateTime());
                    }
                    qir.patientId = patient.getId();
                    qir.charno = String.valueOf(patient.getId());
                    qir.name = patient.getName();
                    qir.idno = patient.getIdno();
                    qir.gender = patient.getGender();
                    qir.age = String.valueOf(patient.getAge());
                    qir.carer = cUser.getUsername() + " " + cUser.getRoleName();
                    totalResult.add(qir);
                }
            }
            JSONArray dataArr = new JSONArray();
            for(QryInfoResp q : totalResult){
                dataArr.put(GsonUtil.toJsonObject(q));
            }
            result.put("data", dataArr);
            result.put("num", totalSize);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return result.toString();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "查詢病患資料時發生錯誤: " + e.getMessage(), e);
            result.put("success", false);
            result.put("error", "伺服器內部錯誤: " + e.getMessage());
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_INTERNAL_ERROR, 0);
            return new JSONObject(result).toString();
        }
    }

    @RESTfulAPIDefine(url = "saveByUser", methods = "post", description = "根據當前使用者新增或更新病患資料")
    private String saveByUser(HttpExchange exchange) throws IOException {
        JSONObject responseJson = new JSONObject();
        try {
            // 讀取並驗證請求資料
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            if (requestBody == null || requestBody.trim().isEmpty()) {
                return createErrorResponse(exchange, HttpURLConnection.HTTP_BAD_REQUEST, "請求資料不能為空");
            }
            JSONObject requestJson = new JSONObject(requestBody);

            // 取得當前使用者
            User currentUser = SecurityUtils.getCurrentUser(exchange);
            long userId = currentUser.getId();

            // 檢查是否已有關聯的 Patient
            Patient patient = PatientAPI.getInstance().getPatientByUserId(userId);
            if (patient != null) {
                // 已存在則更新
                boolean ok = performAtomicUpdate(patient, requestJson);
                if (!ok) {
                    return createErrorResponse(exchange, HttpURLConnection.HTTP_INTERNAL_ERROR, "更新病患資料失敗");
                }
                responseJson.put("message", "病患資料更新成功");
                responseJson.put("patientId", patient.getId());
            } else {
                // 不存在則建立新 Patient，並關聯到 user
                patient = new Patient();
                patient.setUserId(userId);
                // 更新基本欄位與關聯
                updatePatientBasicFields(patient, requestJson);
                updatePatientRelationships(patient, requestJson);
                // 建立新病患
                PatientAPI.getInstance().createPatient(patient);
                responseJson.put("message", "病患資料創建成功");
                responseJson.put("patientId", patient.getId());
            }

            responseJson.put("success", true);
            exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK, 0);
            return responseJson.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "saveByUser 時發生錯誤: " + e.getMessage(), e);
            return createErrorResponse(exchange, HttpURLConnection.HTTP_INTERNAL_ERROR, "伺服器內部錯誤: " + e.getMessage());
        }
    }
        /**
         * 執行原子更新操作
         */
    private boolean performAtomicUpdate(Patient patient, JSONObject requestJson) {
        try {
            // 更新 Patient 基本欄位（僅更新非 null 值）
            updatePatientBasicFields(patient, requestJson);

            // 更新多對多關聯
            updatePatientRelationships(patient, requestJson);

            // 更新或建立 OtherPatientInfo
            updateOtherPatientInfo(patient, requestJson);

            // 執行資料庫更新
            PatientAPI.getInstance().updatePatient(patient);

            LOGGER.log(Level.INFO, "病患資料更新成功: ID = " + patient.getId());
            return true;

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "原子更新操作失敗: " + e.getMessage(), e);
            return false;
        }
    }

    /**
     * 更新病患基本欄位（僅更新非 null 值）
     */
    private void updatePatientBasicFields(Patient patient, JSONObject requestJson) {
        // 身分證號（通常不允許更新，但為了完整性保留）
        if (requestJson.has("idno") && !requestJson.isNull("idno")) {
            String idno = requestJson.optString("idno", "").trim();
            if (!idno.isEmpty() && !idno.equals(patient.getIdno())) {
                // 驗證身分證號格式
                if (isValidIdno(idno)) {
                    patient.setIdno(idno);
                } else {
                    throw new IllegalArgumentException("身分證號格式不正確");
                }
            }
        }

        // 性別
        if (requestJson.has("gender") && !requestJson.isNull("gender")) {
            String gender = requestJson.optString("gender", "").trim();
            if (!gender.isEmpty()) {
                patient.setGender(gender);
            }
        }

        // 婚姻狀況
        if (requestJson.has("maritalStatus") && !requestJson.isNull("maritalStatus")) {
            String maritalStatus = requestJson.optString("maritalStatus", "").trim();
            if (!maritalStatus.isEmpty()) {
                patient.setMaritalStatus(maritalStatus);
            }
        }

        // 出生日期
        if (requestJson.has("birth") && !requestJson.isNull("birth")) {
            String birthStr = requestJson.optString("birth", "").trim();
            if (!birthStr.isEmpty()) {
                try {
                    Date birth = DATE_FORMAT.parse(birthStr);
                    patient.setBirth(birth);
                } catch (ParseException e) {
                    LOGGER.log(Level.WARNING, "出生日期格式錯誤: " + birthStr);
                    throw new IllegalArgumentException("出生日期格式錯誤，請使用 yyyy-MM-dd 格式");
                }
            }
        }

        // 地址相關欄位
        if (requestJson.has("city") && !requestJson.isNull("city")) {
            String city = requestJson.optString("city", "").trim();
            if (!city.isEmpty()) {
                patient.setCity(city);
            }
        }

        if (requestJson.has("district") && !requestJson.isNull("district")) {
            String district = requestJson.optString("district", "").trim();
            if (!district.isEmpty()) {
                patient.setDistrict(district);
            }
        }

        if (requestJson.has("address") && !requestJson.isNull("address")) {
            String address = requestJson.optString("address", "").trim();
            if (!address.isEmpty()) {
                patient.setAddress(address);
            }
        }

        // 緊急聯絡人資訊
        if (requestJson.has("emergencyContact") && !requestJson.isNull("emergencyContact")) {
            String emergencyContact = requestJson.optString("emergencyContact", "").trim();
            if (!emergencyContact.isEmpty()) {
                patient.setEmergencyContact(emergencyContact);
            }
        }

        if (requestJson.has("emergencyPhone") && !requestJson.isNull("emergencyPhone")) {
            String emergencyPhone = requestJson.optString("emergencyPhone", "").trim();
            if (!emergencyPhone.isEmpty()) {
                patient.setEmergencyPhone(emergencyPhone);
            }
        }

        if (requestJson.has("emergencyRelation") && !requestJson.isNull("emergencyRelation")) {
            String emergencyRelation = requestJson.optString("emergencyRelation", "").trim();
            if (!emergencyRelation.isEmpty()) {
                patient.setEmergencyRelation(emergencyRelation);
            }
        }

        // 其他病史和用藥資訊
        if (requestJson.has("otherHistoryDisease") && !requestJson.isNull("otherHistoryDisease")) {
            String otherHistoryDisease = requestJson.optString("otherHistoryDisease", "").trim();
            patient.setOtherHistoryDisease(otherHistoryDisease.isEmpty() ? null : otherHistoryDisease);
        }

        if (requestJson.has("otherMedicalHistory") && !requestJson.isNull("otherMedicalHistory")) {
            String otherMedicalHistory = requestJson.optString("otherMedicalHistory", "").trim();
            patient.setOtherMedicalHistory(otherMedicalHistory.isEmpty() ? null : otherMedicalHistory);
        }

        if (requestJson.has("otherDrugUseStatus") && !requestJson.isNull("otherDrugUseStatus")) {
            String otherDrugUseStatus = requestJson.optString("otherDrugUseStatus", "").trim();
            patient.setOtherDrugUseStatus(otherDrugUseStatus.isEmpty() ? null : otherDrugUseStatus);
        }

        // 疾病 ID
        if (requestJson.has("diseaseId") && !requestJson.isNull("diseaseId")) {
            try {
                Long diseaseId = requestJson.getLong("diseaseId");
                patient.setDiseaseId(diseaseId);
            } catch (JSONException e) {
                LOGGER.log(Level.WARNING, "疾病 ID 格式錯誤");
            }
        }
    }

    /**
     * 更新病患多對多關聯（僅更新非 null 值）
     */
    private void updatePatientRelationships(Patient patient, JSONObject requestJson) {
        // 疾病分類
        if (requestJson.has("diseaseCategoryIds") && !requestJson.isNull("diseaseCategoryIds")) {
            JSONArray diseaseCategoryIds = requestJson.optJSONArray("diseaseCategoryIds");
            if (diseaseCategoryIds != null) {
                List<DiseaseCategory> diseaseCategories = getDiseaseCategories(diseaseCategoryIds);
                patient.setDiseaseCategories(diseaseCategories);
            }
        }

        // 藥物分類
        if (requestJson.has("medicalCategoryIds") && !requestJson.isNull("medicalCategoryIds")) {
            JSONArray medicalCategoryIds = requestJson.optJSONArray("medicalCategoryIds");
            if (medicalCategoryIds != null) {
                List<MedicationCategory> medicalCategories = getMedicalCategories(medicalCategoryIds);
                patient.setMedicalCategories(medicalCategories);
            }
        }

        // 藥物使用狀況分類
        if (requestJson.has("drugUseStatusCategoryIds") && !requestJson.isNull("drugUseStatusCategoryIds")) {
            JSONArray drugUseStatusCategoryIds = requestJson.optJSONArray("drugUseStatusCategoryIds");
            if (drugUseStatusCategoryIds != null) {
                List<DrugUseStatusCategory> drugUseStatusCategories = getDrugUseStatusCategories(drugUseStatusCategoryIds);
                patient.setDrugUseStatusCategory(drugUseStatusCategories);
            }
        }
    }

    /**
     * 更新或建立 OtherPatientInfo（僅更新非 null 值）
     */
    private void updateOtherPatientInfo(Patient patient, JSONObject requestJson) {
        if (!requestJson.has("otherPatientInfo") || requestJson.isNull("otherPatientInfo")) {
            return; // 沒有其他病患資訊需要更新
        }

        JSONObject otherInfoJson = requestJson.optJSONObject("otherPatientInfo");
        if (otherInfoJson == null) {
            return;
        }

        // 直接查詢資料庫是否有這筆資料
        OtherPatientInfo otherInfo = OtherPatientInfoAPI.getInstance().getByPatientId(patient.getId());
        boolean isNew = false;

        if (otherInfo == null) {
            // 資料庫中沒有找到，創建新的 OtherPatientInfo
            otherInfo = new OtherPatientInfo();
            otherInfo.setPatient(patient);
            otherInfo.setPatientId(patient.getId());
            patient.setOtherPatientInfo(otherInfo);
            isNew = true;
            LOGGER.log(Level.INFO, "創建新的 OtherPatientInfo for patient ID: " + patient.getId());
        } else {
            LOGGER.log(Level.INFO, "找到現有的 OtherPatientInfo for patient ID: " + patient.getId());
        }

        // 更新各個欄位（僅更新非 null 值）
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "mainIssueDesc",
                (info, value) -> info.setMainIssueDesc(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "difficultyDesc",
                (info, value) -> info.setDifficultyDesc(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "educationLevel",
                (info, value) -> info.setEducationLevel(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "occupation",
                (info, value) -> info.setOccupation(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "familyLanguage",
                (info, value) -> info.setFamilyLanguage(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "preeducationExp",
                (info, value) -> info.setPreeducationExp(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "fatherEducation",
                (info, value) -> info.setFatherEducation(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "motherEducation",
                (info, value) -> info.setMotherEducation(value));

        // 處理語言發展問題分類（多對多關聯）
        if (otherInfoJson.has("speechDevIssueCategoryIds") && !otherInfoJson.isNull("speechDevIssueCategoryIds")) {
            JSONArray speechDevIssueCategoryIds = otherInfoJson.optJSONArray("speechDevIssueCategoryIds");
            if (speechDevIssueCategoryIds != null) {
                List<SpeechDevIssueCategory> speechDevIssueCategories = getSpeechDevIssueCategories(speechDevIssueCategoryIds);
                otherInfo.setSpeechDevIssues(speechDevIssueCategories);
            }
        }

        updateOtherPatientInfoField(otherInfo, otherInfoJson, "communicationMtd",
                (info, value) -> info.setCommunicationMtd(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "swallowDifficulty",
                (info, value) -> info.setSwallowDifficulty(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "psychologicalState",
                (info, value) -> info.setPsychologicalState(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "otherRemarks",
                (info, value) -> info.setOtherRemarks(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "fatherOccupation",
                (info, value) -> info.setFatherOccupation(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "motherOccupation",
                (info, value) -> info.setMotherOccupation(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "developmentalDelay",
                (info, value) -> info.setDevelopmentalDelay(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "suspectedSpeechIssues",
                (info, value) -> info.setSuspectedSpeechIssues(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "comprehensionAbility",
                (info, value) -> info.setComprehensionAbility(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "expressionAbility",
                (info, value) -> info.setExpressionAbility(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "recentStressEvents",
                (info, value) -> info.setRecentStressEvents(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "familySupportLevel",
                (info, value) -> info.setFamilySupportLevel(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "psychologicalTreatment",
                (info, value) -> info.setPsychologicalTreatment(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "treatmentDetails",
                (info, value) -> info.setTreatmentDetails(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "suicidalThoughts",
                (info, value) -> info.setSuicidalThoughts(value));
        updateOtherPatientInfoField(otherInfo, otherInfoJson, "selfHarmBehavior",
                (info, value) -> info.setSelfHarmBehavior(value));
        // 更新或建立 OtherPatientInfo
        try {
            if (isNew) {
                OtherPatientInfoAPI.getInstance().createOtherPatientInfo(otherInfo, patient);
                LOGGER.log(Level.INFO, "成功創建 OtherPatientInfo for patient ID: " + patient.getId());
            } else {
                OtherPatientInfoAPI.getInstance().updateOtherPatientInfo(otherInfo);
                LOGGER.log(Level.INFO, "成功更新 OtherPatientInfo for patient ID: " + patient.getId());
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "更新其他病患資訊失敗: " + e.getMessage(), e);
            throw new RuntimeException("更新其他病患資訊失敗", e);
        }
    }

    /**
     * 輔助方法：更新 OtherPatientInfo 的單一欄位
     */
    @FunctionalInterface
    private interface OtherInfoSetter {

        void set(OtherPatientInfo info, String value);
    }

    private void updateOtherPatientInfoField(OtherPatientInfo otherInfo, JSONObject json,
            String fieldName, OtherInfoSetter setter) {
        if (json.has(fieldName) && !json.isNull(fieldName)) {
            String value = json.optString(fieldName, "").trim();
            setter.set(otherInfo, value.isEmpty() ? null : value);
        }
    }

    /**
     * 取得疾病分類列表
     */
    private List<DiseaseCategory> getDiseaseCategories(JSONArray categoryIds) {
        List<DiseaseCategory> categories = new ArrayList<>();
        for (int i = 0; i < categoryIds.length(); i++) {
            try {
                Long id = categoryIds.getLong(i);
                DiseaseCategory category = DiseaseCategoryAPI.getInstance().getDiseaseCategory(id);
                if (category != null) {
                    categories.add(category);
                }
            } catch (JSONException e) {
                LOGGER.log(Level.WARNING, "疾病分類 ID 格式錯誤: " + e.getMessage());
            }
        }
        return categories;
    }

    /**
     * 取得藥物分類列表
     */
    private List<MedicationCategory> getMedicalCategories(JSONArray categoryIds) {
        List<MedicationCategory> categories = new ArrayList<>();
        for (int i = 0; i < categoryIds.length(); i++) {
            try {
                Long id = categoryIds.getLong(i);
                MedicationCategory category = MedicationCategoryAPI.getInstance().getById(id);
                if (category != null) {
                    categories.add(category);
                }
            } catch (JSONException e) {
                LOGGER.log(Level.WARNING, "藥物分類 ID 格式錯誤: " + e.getMessage());
            }
        }
        return categories;
    }

    /**
     * 取得藥物使用狀況分類列表
     */
    private List<DrugUseStatusCategory> getDrugUseStatusCategories(JSONArray categoryIds) {
        List<DrugUseStatusCategory> categories = new ArrayList<>();
        for (int i = 0; i < categoryIds.length(); i++) {
            try {
                Long id = categoryIds.getLong(i);
                DrugUseStatusCategory category = DrugUseStatusCategoryAPI.getInstance().getById(id);
                if (category != null) {
                    categories.add(category);
                }
            } catch (JSONException e) {
                LOGGER.log(Level.WARNING, "藥物使用狀況分類 ID 格式錯誤: " + e.getMessage());
            }
        }
        return categories;
    }

    /**
     * 取得語言發展問題分類列表
     */
    private List<SpeechDevIssueCategory> getSpeechDevIssueCategories(JSONArray categoryIds) {
        List<SpeechDevIssueCategory> categories = new ArrayList<>();
        for (int i = 0; i < categoryIds.length(); i++) {
            try {
                Long id = categoryIds.getLong(i);
                SpeechDevIssueCategory category = SpeechDevIssueCategoryAPI.getInstance().getById(id);
                if (category != null) {
                    categories.add(category);
                }
            } catch (JSONException e) {
                LOGGER.log(Level.WARNING, "語言發展問題分類 ID 格式錯誤: " + e.getMessage());
            }
        }
        return categories;
    }

    /**
     * 驗證身分證號格式（簡單驗證）
     */
    private boolean isValidIdno(String idno) {
        if (idno == null || idno.length() != 10) {
            return false;
        }
        // 這裡可以加入更詳細的身分證號驗證邏輯
        return idno.matches("^[A-Z][12][0-9]{8}$");
    }

    /**
     * 建立錯誤回應
     */
    private String createErrorResponse(HttpExchange exchange, int statusCode, String message)
            throws IOException {
        JSONObject errorJson = new JSONObject();
        errorJson.put("success", false);
        errorJson.put("error", message);
        errorJson.put("timestamp", System.currentTimeMillis());

        exchange.sendResponseHeaders(statusCode, 0);
        return errorJson.toString();
    }
    
    	public String convertValue(String value){
		String returnValue = "";
		if(!StringUtils.isEmpty(value)){
			Boolean isMessyCode = java.nio.charset.Charset.forName("GBK").newEncoder().canEncode(value);
			if(!isMessyCode){
				try{
					value =  new String(value.getBytes("ISO8859_1"), "UTF-8");
				}
				catch(Exception e){
					e.printStackTrace();
				}
			}
			returnValue = value;
		}
		return returnValue;
	}
        
        public static class QryInfoResp {

    public Long patientId = null;
    public String keyno = "";
    public String charno = "";
    public String name = "";
    public String idno = "";
    public String gender = "";
    public String age = "";
    public String diagnosis = "";
    public String status = "";
    public String newVisitDate = "";
    public String carer = "";
    public String alertContent = "";
}
}
