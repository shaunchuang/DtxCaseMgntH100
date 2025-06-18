package demo.freemarker.api.training;

import demo.freemarker.dao.training.TrainingRecordDAO;
import demo.freemarker.model.training.TrainingRecord;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TrainingRecordAPI implements API {

    private final static TrainingRecordAPI INSTANCE = new TrainingRecordAPI();

    public final static TrainingRecordAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "TrainingRecordAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "訓練紀錄 API";
    }

    public List<TrainingRecord> listTrainingRecords() {
        List<TrainingRecord> output = new ArrayList<>();
        List<IntIdDataEntity> list = TrainingRecordDAO.getInstance().findEntities();
        for (IntIdDataEntity entity : list) {
            output.add((TrainingRecord) entity);
        }
        return output;
    }

    public TrainingRecord getTrainingRecord(long id) {
        try {
            return (TrainingRecord) TrainingRecordDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createTrainingRecord(TrainingRecord record) {
        try {
            // Set current timestamp for created_at and updated_at
            Date now = new Date();
            record.setCreatedAt(now);

            TrainingRecordDAO.getInstance().create(record);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateTrainingRecord(TrainingRecord record) {
        try {
            TrainingRecordDAO.getInstance().edit(record);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteTrainingRecord(long id) {
        try {
            TrainingRecordDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<TrainingRecord> getRecordsByPatientId(Long patientId) {
        try {
            return TrainingRecordDAO.getInstance().findByPatientId(patientId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<TrainingRecord> getRecordsByDate(Date trainingDate) {
        try {
            return TrainingRecordDAO.getInstance().findByDate(trainingDate);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<TrainingRecord> getRecordsByPatientIdAndDate(Long patientId, Date trainingDate) {
        try {
            return TrainingRecordDAO.getInstance().findByPatientIdAndDate(patientId, trainingDate);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<TrainingRecord> listRecordsByPlanLessonId(Long planLessonId) {
        try {
            return TrainingRecordDAO.getInstance().findByPlanLessonId(planLessonId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
}
