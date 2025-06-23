package demo.freemarker.api.healthinsurance;

import demo.freemarker.api.RoleAPI;
import demo.freemarker.api.UserAPI;
import demo.freemarker.api.WgIcdCodeAPI;
import demo.freemarker.api.WgTaskAPI;
import demo.freemarker.core.StringUtils;
import demo.freemarker.dao.healthinsurance.HealthInsuranceRecordDAO;
import demo.freemarker.dto.HcRecordDTO;
import demo.freemarker.dto.UserRoleDTO;
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

    public HcRecordDTO convertToHcRecordDTO(HealthInsuranceRecord hcForm, Long serialNo, Boolean isDetailInfo) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Long id = hcForm.getId();
        Long patientId = hcForm.getPatientId();
        String diagDate = sdf.format(hcForm.getCreateTime());
        String diagDateTime = fullDateFormat(hcForm.getCreateTime());
        User doctor = UserAPI.getInstance().getUser(hcForm.getCreator());
        String doctorName = doctor.getUsername();
        String icdCode = hcForm.getMainDiagnosisCode();
        WgIcdCode codeObj = WgIcdCodeAPI.getInstance().getByPureCode(icdCode);
        String diagnosois = codeObj != null ? StringUtils.join(new String[]{codeObj.getPureCode(), codeObj.getName()}, " ") : "";
        String doctorAlias = "";
        Boolean isFirstDiag = false;
        int diagTImes = 0;

        if (doctor != null) {
            List<Role> roles = RoleAPI.getInstance().listRolesByUserId(doctor.getId());
            UserRoleDTO userRole = new UserRoleDTO(doctor, roles);
            isFirstDiag = WgTaskAPI.getInstance().checkFirstDiagnosis(hcForm.getPatientId(), doctor.getId());
        }

        if (isDetailInfo) {
            return new HcRecordDTO(serialNo, id, patientId, diagDateTime, isFirstDiag, diagTImes, diagnosois, doctorName, doctorAlias);
        } else {
            return new HcRecordDTO(serialNo, id, patientId, diagDate, diagnosois, doctorName, doctorAlias);
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
            String timePart = dateTime.format(DateTimeFormatter.ofPattern("HH:mm"));

            return String.format("%s (%s) %s", datePart, dayStr, timePart);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fullDate;
    }

}
