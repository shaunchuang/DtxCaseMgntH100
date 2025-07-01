package demo.freemarker.api.training;

import demo.freemarker.api.PatientAPI;
import demo.freemarker.api.UserAPI;
import demo.freemarker.dao.training.TrainingPlanDAO;
import demo.freemarker.dto.AchievementDTO;
import demo.freemarker.dto.LessonDTO;
import demo.freemarker.dto.StatisticsDTO;
import demo.freemarker.dto.TrainingPlanDTO;
import demo.freemarker.dto.TrainingTrack;
import demo.freemarker.model.Patient;
import demo.freemarker.model.training.AchievementGoal;
import demo.freemarker.model.training.PlanLessonMapping;
import demo.freemarker.model.training.StatisticsGoal;
import demo.freemarker.model.training.TrainingPlan;
import demo.freemarker.model.training.TrainingRecord;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Collectors;

public class TrainingPlanAPI implements API {
    private final static TrainingPlanAPI INSTANCE = new TrainingPlanAPI();

    public final static TrainingPlanAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "TrainingPlanAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "訓練計畫管理 API";
    }

    public List<TrainingPlan> listTrainingPlan() {
        List<TrainingPlan> output = new ArrayList<>();
        try {
            List<IntIdDataEntity> list = TrainingPlanDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((TrainingPlan) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public TrainingPlan getTrainingPlan(long id) {
        try {
            return (TrainingPlan) TrainingPlanDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createTrainingPlan(TrainingPlan plan) {
        try {
            TrainingPlanDAO.getInstance().create(plan);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateTrainingPlan(TrainingPlan plan) {
        try {
            TrainingPlanDAO.getInstance().edit(plan);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteTrainingPlan(long id) {
        try {
            TrainingPlanDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "取得病患的訓練計畫清單")
    public List<TrainingPlan> listByPatient(Long patientId) {
        try {
            return TrainingPlanDAO.getInstance().findByPatient(patientId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "取得治療師的訓練計畫清單")
    public List<TrainingPlan> listTrainingPlanByTherapist(Long therapistId) {
        try {
            return TrainingPlanDAO.getInstance().findByTherapist(therapistId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    
    public TrainingPlanDTO convertPlanDTO(TrainingPlan trainingPlan) {
        TrainingPlanDTO planDTO = new TrainingPlanDTO();
        List<PlanLessonMapping> mappings = PlanLessonMappingAPI.getInstance().listByPlanId(trainingPlan.getId());
        List<LessonDTO> lessonDTOs = new ArrayList<>();
        for (PlanLessonMapping mapping : mappings) {
            LessonDTO lessonDTO = new LessonDTO();
            lessonDTO.setLessonId(mapping.getLessonId());
            List<AchievementGoal> achievementGoals = AchievementGoalAPI.getInstance().listByMappingId(mapping.getId());
            List<AchievementDTO> achievements = achievementGoals.stream()
                    .map(achievementGoal -> {
                        AchievementDTO achievementDTO = new AchievementDTO();
                        achievementDTO.setAchievementId(achievementGoal.getId());
                        achievementDTO.setApiName(achievementGoal.getApiName());
                        return achievementDTO;
                    })
                    .collect(Collectors.toList());

            lessonDTO.setAchievements(achievements);
            List<StatisticsGoal> statisticsGoals = StatisticsGoalAPI.getInstance().listByMappingId(mapping.getId());
            List<StatisticsDTO> statisticsDTOs = statisticsGoals.stream()
                    .map(statisticsGoal -> {
                        StatisticsDTO statisticsDTO = new StatisticsDTO();
                        statisticsDTO.setStatisticsId(statisticsGoal.getId());
                        statisticsDTO.setApiName(statisticsGoal.getApiName());
                        statisticsDTO.setValueGoal(statisticsGoal.getValueGoal());
                        return statisticsDTO;
                    })
                    .collect(Collectors.toList());
            lessonDTO.setStatistics(statisticsDTOs);
            lessonDTOs.add(lessonDTO);
        }
        planDTO.setPlanId(trainingPlan.getId());
        planDTO.setTherapistId(trainingPlan.getTherapist());
        String therapistName = UserAPI.getInstance().getUser(trainingPlan.getTherapist()).getUsername();
        planDTO.setTherapistName(therapistName != null ? therapistName : null);
        planDTO.setPatientId(String.valueOf(trainingPlan.getPatientId()));
        Patient patient = PatientAPI.getInstance().getPatient(trainingPlan.getPatientId());
        planDTO.setPatientName(patient.getName());
        planDTO.setTitle(trainingPlan.getTitle());
        planDTO.setStartDate(trainingPlan.getStartDate());
        planDTO.setEndDate(trainingPlan.getEndDate());
        planDTO.setFrequencyPerWeek(trainingPlan.getFrequencyPerWeek());
        planDTO.setFrequencyPerDay(trainingPlan.getFrequencyPerDay());
        planDTO.setDurationPerSession(trainingPlan.getDurationPerSession());
        planDTO.setNotes(trainingPlan.getNotes());
        planDTO.setCreateTime(trainingPlan.getCreateTime());
        planDTO.setLessons(lessonDTOs);
        return planDTO;
    }
    
    public List<TrainingTrack> convertToTrack(TrainingPlan plan){
        List<TrainingTrack> tracks = new ArrayList<>();
        List<PlanLessonMapping> mappings = PlanLessonMappingAPI.getInstance().listByPlanId(plan.getId());
        
        // 收集所有訓練紀錄並按日期分組
        Map<String, List<TrainingRecord>> recordsByDate = new HashMap<>();
        
        for(PlanLessonMapping mapping : mappings){
            List<TrainingRecord> records = TrainingRecordAPI.getInstance().listRecordsByPlanLessonId(mapping.getId());
            
            for(TrainingRecord record : records) {
                // 將訓練開始時間格式化為日期字串 (yyyy/MM/dd)
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
                String dateKey = dateFormat.format(record.getStartTime());
                
                recordsByDate.computeIfAbsent(dateKey, k -> new ArrayList<>()).add(record);
            }
        }
        
        // 將每日的訓練紀錄轉換為 TrainingTrack
        int weekCounter = 1;
        int dayCounter = 1;
        
        // 按日期排序
        List<String> sortedDates = recordsByDate.keySet().stream()
                .sorted()
                .collect(Collectors.toList());
        
        for(String date : sortedDates) {
            List<TrainingRecord> dayRecords = recordsByDate.get(date);
            
            TrainingTrack track = new TrainingTrack();
            track.setPlanId(plan.getId());
            track.setTrainingDate(date);
            
            // 根據當日完成的訓練次數生成描述
            int sessionsCount = dayRecords.size();
            track.setTrainingTimes(String.valueOf(sessionsCount));
            
            String description;
            
            if (sessionsCount == 1) {
                description = String.format("完成本週第%d次訓練", dayCounter);
            } else {
                description = String.format("完成本週第%d次訓練（共%d個session）", dayCounter, sessionsCount);
            }
            
            track.setDescription(description);
            
            // 檢查是否有異常狀況（例如：訓練時間過短或過長）
            boolean isAbnormal = false;
            for(TrainingRecord record : dayRecords) {
                // 如果訓練時間少於1分鐘或超過2小時，視為異常
                if (record.getDuration() != null && 
                    (record.getDuration() < 60 || record.getDuration() > 7200)) {
                    isAbnormal = true;
                    break;
                }
            }
            
            if (isAbnormal) {
                track.setStatus("異常");
                track.setDescription("訓練狀態異常");
            } else {
                track.setStatus("正常");
            }
            
            tracks.add(track);
            dayCounter++;
            
            // 每7天重置週計數器（可依需求調整）
            if (dayCounter > 7) {
                dayCounter = 1;
                weekCounter++;
            }
        }
        
        return tracks;
    }
}
