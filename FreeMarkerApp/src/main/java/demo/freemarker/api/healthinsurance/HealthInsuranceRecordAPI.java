package demo.freemarker.api.healthinsurance;

import demo.freemarker.dao.healthinsurance.HealthInsuranceRecordDAO;
import demo.freemarker.model.healthinsurance.HealthInsuranceRecord;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
}
