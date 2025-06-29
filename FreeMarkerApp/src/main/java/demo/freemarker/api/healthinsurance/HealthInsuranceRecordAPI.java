package demo.freemarker.api.healthinsurance;

import demo.freemarker.api.PatientAPI;
import demo.freemarker.api.RoleAPI;
import demo.freemarker.api.UserAPI;
import demo.freemarker.api.WgIcdCodeAPI;
import demo.freemarker.api.WgTaskAPI;
import demo.freemarker.core.CrossPlatformUtil;
import demo.freemarker.core.StringUtils;
import demo.freemarker.dao.healthinsurance.HealthInsuranceRecordDAO;
import demo.freemarker.dto.HcRecordDTO;
import demo.freemarker.dto.UserRoleDTO;
import demo.freemarker.model.Patient;
import demo.freemarker.model.Role;
import demo.freemarker.model.User;
import demo.freemarker.model.WgIcdCode;
import demo.freemarker.model.healthinsurance.HealthInsuranceRecord;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;

import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class HealthInsuranceRecordAPI implements API {

    private final static HealthInsuranceRecordAPI INSTANCE = new HealthInsuranceRecordAPI();

    public final static HealthInsuranceRecordAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "HealthInsuranceRecordAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "健保紀錄 API";
    }

    public List<HealthInsuranceRecord> listRecords() {
        List<HealthInsuranceRecord> output = new ArrayList<>();
        List<IntIdDataEntity> list = HealthInsuranceRecordDAO.getInstance().findEntities();
        for (IntIdDataEntity entity : list) {
            output.add((HealthInsuranceRecord) entity);
        }
        return output;
    }

    public HealthInsuranceRecord getRecord(long id) {
        try {
            return (HealthInsuranceRecord) HealthInsuranceRecordDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createRecord(HealthInsuranceRecord record) {
        try {
            record.setCreateTime(new Date());
            HealthInsuranceRecordDAO.getInstance().create(record);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateRecord(HealthInsuranceRecord record) {
        try {
            HealthInsuranceRecordDAO.getInstance().edit(record);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteRecord(long id) {
        try {
            HealthInsuranceRecordDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<HealthInsuranceRecord> getRecordsByPatientId(Long patientId) {
        return HealthInsuranceRecordDAO.getInstance().findByPatientId(patientId);
    }

    public HealthInsuranceRecord getRecordBySerialNum(String serialNum) {
        return HealthInsuranceRecordDAO.getInstance().findBySerialNum(serialNum);
    }
    
    public HealthInsuranceRecord getLatestRecord(Long patientId){
        try {
            return HealthInsuranceRecordDAO.getInstance().findLatestRecordByPateintId(patientId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public HealthInsuranceRecord getLatestRecordByPatientAndCreator(Long patientId, Long creatorId) {
        try {
            return HealthInsuranceRecordDAO.getInstance().findLatestRecordByPatientAndCreator(patientId, creatorId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    /**
     * 取得指定病患的醫師最後看診記錄
     * @param patientId 病患ID
     * @return 醫師最後看診記錄
     */
    public HealthInsuranceRecord getLatestDoctorVisitByPatient(Long patientId) {
        try {
            return HealthInsuranceRecordDAO.getInstance().findLatestDoctorRecordByPatient(patientId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    /**
     * 取得指定病患的治療師最後看診記錄
     * @param patientId 病患ID
     * @return 治療師最後看診記錄
     */
    public HealthInsuranceRecord getLatestTherapistVisitByPatient(Long patientId) {
        try {
            return HealthInsuranceRecordDAO.getInstance().findLatestTherapistRecordByPatient(patientId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    /**
     * 取得指定病患的特定角色最後看診記錄
     * @param patientId 病患ID
     * @param roleId 角色ID (3=醫師, 4=心理治療師, 5=語言治療師, 6=職能治療師, 7=物理治療師)
     * @return 特定角色最後看診記錄
     */
    public HealthInsuranceRecord getLatestVisitByPatientAndRole(Long patientId, Long roleId) {
        try {
            return HealthInsuranceRecordDAO.getInstance().findLatestRecordByPatientAndRole(patientId, roleId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    /**
     * 取得指定病患的所有醫師看診記錄
     * @param patientId 病患ID
     * @return 醫師看診記錄列表
     */
    public List<HealthInsuranceRecord> getDoctorVisitsByPatient(Long patientId) {
        try {
            return HealthInsuranceRecordDAO.getInstance().findDoctorRecordsByPatient(patientId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    /**
     * 取得指定病患的所有治療師看診記錄
     * @param patientId 病患ID
     * @return 治療師看診記錄列表
     */
    public List<HealthInsuranceRecord> getTherapistVisitsByPatient(Long patientId) {
        try {
            return HealthInsuranceRecordDAO.getInstance().findTherapistRecordsByPatient(patientId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    /**
     * 取得醫師最後看診時間（格式化後的字串）
     * @param patientId 病患ID
     * @return 格式化的最後看診時間字串，如果沒有記錄則回傳 null
     */
    public String getLastDoctorVisitTime(Long patientId) {
        try {
            HealthInsuranceRecord record = getLatestDoctorVisitByPatient(patientId);
            if (record != null && record.getCreateTime() != null) {
                return fullDateFormat(record.getCreateTime());
            }
            return null;
        } catch (Exception ex) {
            return null;
        }
    }
    
    /**
     * 取得治療師最後看診時間（格式化後的字串）
     * @param patientId 病患ID
     * @return 格式化的最後看診時間字串，如果沒有記錄則回傳 null
     */
    public String getLastTherapistVisitTime(Long patientId) {
        try {
            HealthInsuranceRecord record = getLatestTherapistVisitByPatient(patientId);
            if (record != null && record.getCreateTime() != null) {
                return fullDateFormat(record.getCreateTime());
            }
            return null;
        } catch (Exception ex) {
            return null;
        }
    }
    
    /**
     * 計算治療週數
     * @param patientId 病患ID
     * @return 治療週數，如果無法計算則回傳 0
     */
    public int calculateTreatmentWeeks(Long patientId) {
        try {
            // 取得第一次治療記錄
            List<HealthInsuranceRecord> allRecords = getRecordsByPatientId(patientId);
            if (allRecords == null || allRecords.isEmpty()) {
                return 0;
            }
            
            // 找到最早的治療記錄
            HealthInsuranceRecord firstRecord = allRecords.stream()
                .min((r1, r2) -> r1.getCreateTime().compareTo(r2.getCreateTime()))
                .orElse(null);
                
            if (firstRecord == null) {
                return 0;
            }
            
            // 計算從第一次治療到現在的週數
            Date firstTreatmentDate = firstRecord.getCreateTime();
            Date currentDate = new Date();
            
            long diffInMillies = currentDate.getTime() - firstTreatmentDate.getTime();
            long diffInDays = diffInMillies / (1000 * 60 * 60 * 24);
            
            return (int) Math.ceil(diffInDays / 7.0);
            
        } catch (Exception ex) {
            return 0;
        }
    }
    
    public HcRecordDTO convertToHcRecordDTO(HealthInsuranceRecord hcForm, Long serialNo, Boolean isDetailInfo) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Long id = hcForm.getId();
        Long patientId = hcForm.getPatientId();
        Patient patient = PatientAPI.getInstance().getPatient(patientId);
        String diagDate = sdf.format(hcForm.getCreateTime());
        String diagDateTime = fullDateFormat(hcForm.getCreateTime());
        User doctor = UserAPI.getInstance().getUser(hcForm.getCreator());
        String doctorName = doctor.getUsername();
        String icdCode = hcForm.getMainDiagnosisCode();
        WgIcdCode codeObj = WgIcdCodeAPI.getInstance().getWgIcdCode(Long.parseLong(icdCode));
        String diagnosois = codeObj != null ? StringUtils.join(new String[]{codeObj.getPureCode(), codeObj.getName()}, " ") : "";
        String doctorAlias = "";
        Boolean isFirstDiag = false;
        int diagTImes = 0;
        String syndrome = CrossPlatformUtil.getInstance().findSyndromeById(patient.getDiseaseId());

        if (doctor != null) {
            List<Role> roles = RoleAPI.getInstance().listRolesByUserId(doctor.getId());
            UserRoleDTO userRole = new UserRoleDTO(doctor, roles);
            isFirstDiag = WgTaskAPI.getInstance().checkIsFirstDiag(patientId, doctor.getId());
        }

        if (isDetailInfo) {
            return new HcRecordDTO(serialNo, id, patientId, diagDateTime, isFirstDiag, diagTImes, diagnosois, doctorName, doctorAlias, syndrome);
        } else {
            return new HcRecordDTO(serialNo, id, patientId, diagDate, diagnosois, doctorName, doctorAlias, syndrome);
        }
    }

    public List<HcRecordDTO> convertToHcRecordDTOList(List<HealthInsuranceRecord> hcForm, Boolean isDetailInfo) {
        return IntStream.range(0, hcForm.size()).mapToObj(i -> convertToHcRecordDTO(hcForm.get(i), (long) (i + 1), isDetailInfo))
                .collect(Collectors.toList());
    }

    public List<HcRecordDTO> convertToHcRecordDTOList(List<HealthInsuranceRecord> hcForm, Boolean isDetailInfo, Integer maxRecords) {
        return IntStream.range(0, hcForm.size())
                .filter(i -> maxRecords == null || i < maxRecords)
                .mapToObj(i -> convertToHcRecordDTO(hcForm.get(i), (long) (i + 1), isDetailInfo))
                .collect(Collectors.toList());
    }

    public String fullDateFormat(Date toDate) {
        String fullDate = "";
        try {
            LocalDateTime dateTime = toDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
            String[] dayOfWeekNames = {"一", "二", "三", "四", "五", "六", "日"};
            DayOfWeek dayOfWeek = dateTime.getDayOfWeek();
            String dayStr = dayOfWeekNames[dayOfWeek.getValue() % 7];

            String datePart = dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            return String.format("%s (%s)", datePart, dayStr);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fullDate;
    }

}
