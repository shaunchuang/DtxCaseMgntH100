package demo.freemarker.api;

import demo.freemarker.dao.PatientDAO;
import demo.freemarker.model.Patient;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;

public class PatientAPI implements API {

    private final static PatientAPI INSTANCE = new PatientAPI();

    public final static PatientAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "PatientAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "病患 API";
    }

    public List<Patient> listPatient() {
        try {
            List<Patient> output = new ArrayList<>();
            List<IntIdDataEntity> list = PatientDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((Patient) entity);
            }
            return output;
            
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public Patient getPatient(long id) {
        try {
            return (Patient) PatientDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createPatient(Patient patient) {
        try {
            PatientDAO.getInstance().create(patient);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updatePatient(Patient patient) {
        try {
            PatientDAO.getInstance().edit(patient);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deletePatient(long id) {
        try {
            PatientDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public Patient getPatientByIdno(String idno) {
        return PatientDAO.getInstance().findByIdno(idno);
    }

    public Patient getPatientByUserId(Long userId) {
        try {
            return PatientDAO.getInstance().findByUserId(userId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
}
