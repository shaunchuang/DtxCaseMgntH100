package demo.freemarker.api;

import demo.freemarker.dao.OtherPatientInfoDAO;
import demo.freemarker.model.OtherPatientInfo;
import demo.freemarker.model.Patient;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;

public class OtherPatientInfoAPI implements API {

    private final static OtherPatientInfoAPI INSTANCE = new OtherPatientInfoAPI();

    public final static OtherPatientInfoAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "OtherPatientInfoAPI";
    }

    @Override
    public String getVersion() {
        return "20250615.01";
    }

    @Override
    public String getDescription() {
        return "其他病患資訊 API";
    }

    public List<OtherPatientInfo> listOtherPatientInfo() {
        try {
            return OtherPatientInfoDAO.getInstance().listOtherPatientInfo();
        } catch (Exception ex) {
            throw new RuntimeException("Failed to list OtherPatientInfo: " + ex.getMessage(), ex);
        }
    }

    public OtherPatientInfo getByPatientId(long patientId) {
        try {
            return OtherPatientInfoDAO.getInstance().findByPatientId(patientId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to get OtherPatientInfo: " + ex.getMessage(), ex);
        }
    }

    /**
     * 創建 OtherPatientInfo，需要提供關聯的 Patient
     */
    public void createOtherPatientInfo(OtherPatientInfo info, Patient patient) {
        try {
            OtherPatientInfoDAO.getInstance().createOtherPatientInfo(info, patient);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to create OtherPatientInfo: " + ex.getMessage(), ex);
        }
    }

    /**
     * 更新 OtherPatientInfo，確保不修改關聯
     */
    public void updateOtherPatientInfo(OtherPatientInfo info) {
        try {
            OtherPatientInfoDAO.getInstance().editOtherPatientInfo(info);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to update OtherPatientInfo: " + ex.getMessage(), ex);
        }
    }

    public void deleteOtherPatientInfo(long patientId) {
        try {
            OtherPatientInfoDAO.getInstance().destroy(patientId);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to delete OtherPatientInfo: " + ex.getMessage(), ex);
        }
    }
}
