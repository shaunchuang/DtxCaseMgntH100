package demo.freemarker.api;

import demo.freemarker.dao.OtherPatientInfoDAO;
import demo.freemarker.dto.OtherPatientInfoDTO;
import demo.freemarker.model.OtherPatientInfo;
import demo.freemarker.model.Patient;
import demo.freemarker.model.SpeechDevIssueCategory;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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

    /**
     * 將 OtherPatientInfo 實體轉換為 OtherPatientInfoDTO
     * @param otherPatientInfo 要轉換的 OtherPatientInfo 實體
     * @return 轉換後的 OtherPatientInfoDTO 物件
     */
    public OtherPatientInfoDTO convertToDTO(OtherPatientInfo otherPatientInfo) {
        if (otherPatientInfo == null) {
            return null;
        }

        OtherPatientInfoDTO dto = new OtherPatientInfoDTO();
        
        // 設定病患 ID
        dto.setPatientId(otherPatientInfo.getPatientId());
        
        // 複製所有基本欄位
        dto.setMainIssueDesc(otherPatientInfo.getMainIssueDesc());
        dto.setDifficultyDesc(otherPatientInfo.getDifficultyDesc());
        dto.setEducationLevel(otherPatientInfo.getEducationLevel());
        dto.setOccupation(otherPatientInfo.getOccupation());
        dto.setFamilyLanguage(otherPatientInfo.getFamilyLanguage());
        dto.setPreeducationExp(otherPatientInfo.getPreeducationExp());
        dto.setFatherEducation(otherPatientInfo.getFatherEducation());
        dto.setMotherEducation(otherPatientInfo.getMotherEducation());
        
        // 處理語言發展問題類別 - 轉換為 ID 列表
        if (otherPatientInfo.getSpeechDevIssues() != null) {
            List<Long> speechDevIssueIds = otherPatientInfo.getSpeechDevIssues()
                    .stream()
                    .map(SpeechDevIssueCategory::getId)
                    .collect(Collectors.toList());
            dto.setSpeechDevIssueIds(speechDevIssueIds);
        }
        
        dto.setCommunicationMtd(otherPatientInfo.getCommunicationMtd());
        dto.setSwallowDifficulty(otherPatientInfo.getSwallowDifficulty());
        dto.setPsychologicalState(otherPatientInfo.getPsychologicalState());
        dto.setOtherRemarks(otherPatientInfo.getOtherRemarks());
        dto.setFatherOccupation(otherPatientInfo.getFatherOccupation());
        dto.setMotherOccupation(otherPatientInfo.getMotherOccupation());
        dto.setDevelopmentalDelay(otherPatientInfo.getDevelopmentalDelay());
        dto.setSuspectedSpeechIssues(otherPatientInfo.getSuspectedSpeechIssues());
        dto.setComprehensionAbility(otherPatientInfo.getComprehensionAbility());
        dto.setExpressionAbility(otherPatientInfo.getExpressionAbility());
        dto.setRecentStressEvents(otherPatientInfo.getRecentStressEvents());
        dto.setFamilySupportLevel(otherPatientInfo.getFamilySupportLevel());
        dto.setPsychologicalTreatment(otherPatientInfo.getPsychologicalTreatment());
        dto.setTreatmentDetails(otherPatientInfo.getTreatmentDetails());
        dto.setSuicidalThoughts(otherPatientInfo.getSuicidalThoughts());
        dto.setSelfHarmBehavior(otherPatientInfo.getSelfHarmBehavior());
        
        return dto;
    }
}
