package demo.freemarker.api.healthinsurance;

import demo.freemarker.dao.healthinsurance.TherapeuticTreatmentDAO;
import demo.freemarker.model.healthinsurance.TherapeuticTreatment;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;

public class TherapeuticTreatmentAPI implements API {

    private final static TherapeuticTreatmentAPI INSTANCE = new TherapeuticTreatmentAPI();

    public final static TherapeuticTreatmentAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "TherapeuticTreatmentAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "治療處置 API";
    }

    public List<TherapeuticTreatment> listTreatments() {
        List<TherapeuticTreatment> output = new ArrayList<>();
        List<IntIdDataEntity> list = TherapeuticTreatmentDAO.getInstance().findEntities();
        for (IntIdDataEntity entity : list) {
            output.add((TherapeuticTreatment) entity);
        }
        return output;
    }

    public TherapeuticTreatment getTreatment(long id) {
        try {
            return (TherapeuticTreatment) TherapeuticTreatmentDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createTreatment(TherapeuticTreatment treatment) {
        try {
            TherapeuticTreatmentDAO.getInstance().create(treatment);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateTreatment(TherapeuticTreatment treatment) {
        try {
            TherapeuticTreatmentDAO.getInstance().edit(treatment);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteTreatment(long id) {
        try {
            TherapeuticTreatmentDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<TherapeuticTreatment> getTreatmentsByHiRecordId(Long hiRecordId) {
        return TherapeuticTreatmentDAO.getInstance().findByHiRecordId(hiRecordId);
    }

    public List<TherapeuticTreatment> getTreatmentsByExecutiveId(Long executiveId) {
        return TherapeuticTreatmentDAO.getInstance().findByExecutiveId(executiveId);
    }
}
