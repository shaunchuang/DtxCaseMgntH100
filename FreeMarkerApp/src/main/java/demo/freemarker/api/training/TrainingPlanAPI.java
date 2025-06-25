package demo.freemarker.api.training;

import demo.freemarker.api.PatientAPI;
import demo.freemarker.api.UserAPI;
import demo.freemarker.dao.training.TrainingPlanDAO;
import demo.freemarker.dto.AchievementDTO;
import demo.freemarker.dto.LessonDTO;
import demo.freemarker.dto.StatisticsDTO;
import demo.freemarker.dto.TrainingPlanDTO;
import demo.freemarker.model.Patient;
import demo.freemarker.model.training.AchievementGoal;
import demo.freemarker.model.training.PlanLessonMapping;
import demo.freemarker.model.training.StatisticsGoal;
import demo.freemarker.model.training.TrainingPlan;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;
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
        System.out.println("mappings size: " + mappings.size());
        for (PlanLessonMapping mapping : mappings) {
            LessonDTO lessonDTO = new LessonDTO();
            System.out.println("lessonId:" + mapping.getLessonId());
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
        System.out.println("therapistName: "+therapistName);
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
}
