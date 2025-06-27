package demo.freemarker.api;

import demo.freemarker.dao.WgTaskDAO;
import demo.freemarker.dto.CaseAppoEvent;
import demo.freemarker.dto.UserRoleDTO;
import demo.freemarker.model.Patient;
import demo.freemarker.model.Role;
import demo.freemarker.model.User;
import demo.freemarker.model.WgAvailableSlots;
import demo.freemarker.model.WgTask;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class WgTaskAPI implements API {

    private final static WgTaskAPI INSTANCE = new WgTaskAPI();

    public final static WgTaskAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "WgTaskAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "工作任務 API";
    }

    @APIDefine(description = "獲取任務清單")
    public List<WgTask> listWgTask() {
        try {
            List<WgTask> output = new ArrayList<>();
            List<IntIdDataEntity> list = WgTaskDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((WgTask) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "獲取任務")
    public WgTask getWgTask(long id) {
        try {
            return (WgTask) WgTaskDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "新增任務")
    public void createWgTask(WgTask task) {
        try {
            WgTaskDAO.getInstance().create(task);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "更新任務")
    public void updateWgTask(WgTask task) {
        try {
            WgTaskDAO.getInstance().edit(task);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "刪除任務")
    public void deleteWgTask(long id) {
        try {
            WgTaskDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<WgTask> listWgTaskByCreator(Long creator) {
        List<WgTask> taskList = new ArrayList<>();
        try {
            taskList = WgTaskDAO.getInstance().listWgTaskByCreator(creator);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
        return taskList;
    }

    public WgTask geWgTaskBySlotId(Long slotId){
        try {
            return WgTaskDAO.getInstance().getWgTaskBySlotId(slotId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "獲取使用者當天任務清單")
    public List<WgTask> listWgTaskByCreatorAndDate(Long creator, Date date) {
        // Get all tasks for the creator
        List<WgTask> wgTaskList = WgTaskAPI.getInstance().listWgTaskByCreator(creator);
        Date today = truncateTime(date); 
        // Get available slots for the creator on today's date
        List<WgAvailableSlots> availableSlots = WgAvailableSlotsAPI.getInstance().listByDoctorIdAndDate(creator, date);
        // Extract the IDs of available slots for today
        List<Long> availableSlotIds = availableSlots.stream()
                .map(slot -> slot.getId())
                .collect(Collectors.toList());

        // Filter tasks to only include those with availableSlotId in the list of today's slots
        List<WgTask> todayTasks = wgTaskList.stream()
                .filter(task -> task.getAvailableSlotId() != null
                && availableSlotIds.contains(task.getAvailableSlotId()))
                .collect(Collectors.toList());
        return todayTasks;
    }

    @APIDefine(description = "檢查是否為初診")
    public Boolean checkFirstDiagnosis(Long caseNo, Long creator) {
        List<WgTask> tasks = WgTaskDAO.getInstance().checkIsFirstDiag(caseNo, creator);
        if (tasks == null || tasks.isEmpty()) {
            return true; // No previous tasks found, so it's considered first diagnosis
        }
        return false;
    }

    public List<WgTask> listWgTaskByUserAndCat(Long creator, int cat) {
        List<WgTask> taskList = new ArrayList<>();
        try {
            taskList = WgTaskDAO.getInstance().listWgTaskByUserAndCat(creator, cat);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
        return taskList;
    }

    public List<WgTask> listWgTaskByCaseNo(Long caseNo) {
        List<WgTask> taskList = new ArrayList<>();
        try {
            taskList = WgTaskDAO.getInstance().listWgTaskByCaseNo(caseNo);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
        return taskList;
    }

    @APIDefine(description = "轉換任務為 CaseAppoEvent")
    public CaseAppoEvent convertToCaseAppoEvent(WgTask task) {
        
        CaseAppoEvent appoEvent = new CaseAppoEvent();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        SimpleDateFormat dateSDF = new SimpleDateFormat("yyyy-MM-dd");
        WgAvailableSlots slot = WgAvailableSlotsAPI.getInstance().getWgAvailableSlot(task.getAvailableSlotId());
        Long formId = task.getCaseNo();
        Patient patient = PatientAPI.getInstance().getPatient(formId);
        appoEvent.setSerialno(task.getId());
        appoEvent.setName(patient.getName());
        appoEvent.setGender(patient.getGender());
        appoEvent.setAge(String.valueOf(patient.getAge()));
        appoEvent.setIndication(patient.getDiseaseName());
        appoEvent.setCheckinTime(task.getCheckinTime() != null ? sdf.format(task.getCheckinTime()) : null);
        appoEvent.setIsFirstDiag(checkFirstDiagnosis(formId, slot.getDoctor()));
        User therapist = UserAPI.getInstance().getUser(slot.getDoctor());
        List<Role> roles = RoleAPI.getInstance().listRolesByUserId(therapist.getId());
        UserRoleDTO therapistUser = new UserRoleDTO(therapist, roles);
        appoEvent.setDoctorAlias(therapistUser.getRoleName());
        appoEvent.setAppoDate(dateSDF.format(slot.getSlotDate()));
        appoEvent.setDoctorName(therapist.getUsername());
        appoEvent.setAppoTime(sdf.format(slot.getSlotBeginTime()));
        appoEvent.setCaseno(formId);
        appoEvent.setSlotId(slot.getId());
        Long slotId = null;
        String appoTimeStr = null;

        if (slot != null) {
            slotId = slot.getId();
            Date appoTime = slot.getSlotBeginTime();
            if (appoTime != null) {
                appoTimeStr = sdf.format(appoTime);
            }
        }
        
//        return new CaseAppoEvent(serialno, patient.getId(), slotId, name, gender, age, indication, appoTimeStr, checkinTime, isFirstDiag);
        return appoEvent;
    }

    @APIDefine(description = "轉換任務清單為 CaseAppoEvent 清單")
    public List<CaseAppoEvent> convertToCaseAppoEventList(List<WgTask> tasks) {
        List<CaseAppoEvent> appoEvents = new ArrayList<>();
        for (WgTask task : tasks) {
            CaseAppoEvent appoEvent = convertToCaseAppoEvent(task);
            appoEvents.add(appoEvent);
        }
        return appoEvents;
    }

 
    private static Date truncateTime(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return cal.getTime();
    }
}
