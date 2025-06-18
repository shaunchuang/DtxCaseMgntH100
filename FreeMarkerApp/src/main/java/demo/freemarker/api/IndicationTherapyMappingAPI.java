/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.api;

import demo.freemarker.dao.IndicationTherapyMappingDAO;
import demo.freemarker.model.IndicationTherapyMapping;
import java.util.List;

/**
 * 適應症與治療類別對應 API
 * 
 * @author zhush
 */
public class IndicationTherapyMappingAPI {
    private final IndicationTherapyMappingDAO dao = IndicationTherapyMappingDAO.getInstance();

    /**
     * 根據適應症ID查詢對應的治療類別
     * @param conditionId 適應症ID
     * @return 治療類別列表
     */
    public List<IndicationTherapyMapping> findByIndicationId(Long conditionId) {
        return dao.findByIndicationId(conditionId);
    }

    /**
     * 根據治療類別查詢對應的適應症
     * @param therapyType 治療類別 (OT, ST, PT, CP, PS)
     * @return 適應症對應列表
     */
    public List<IndicationTherapyMapping> findByTherapyType(String therapyType) {
        return dao.findByTherapyType(therapyType);
    }

    /**
     * 檢查特定適應症是否對應特定治療類別
     * @param conditionId 適應症ID
     * @param therapyType 治療類別
     * @return 對應記錄，如果不存在則返回null
     */
    public IndicationTherapyMapping findByIndicationAndTherapy(Long conditionId, String therapyType) {
        return dao.findByIndicationAndTherapy(conditionId, therapyType);
    }

    /**
     * 獲取適應症對應的治療類別字串列表
     * @param conditionId 適應症ID
     * @return 治療類別字串陣列 (如: ["OT", "CP"])
     */
    public String[] getTherapyTypesByIndicationId(Long conditionId) {
        List<IndicationTherapyMapping> mappings = findByIndicationId(conditionId);
        if (mappings == null || mappings.isEmpty()) {
            return new String[0];
        }
        return mappings.stream()
                .map(IndicationTherapyMapping::getTherapyType)
                .toArray(String[]::new);
    }

    /**
     * 保存適應症與治療類別的對應關係
     * @param mapping 對應關係物件
     * @return 保存後的物件
     */
    public IndicationTherapyMapping save(IndicationTherapyMapping mapping) {
        return dao.save(mapping);
    }

    /**
     * 批量儲存適應症與治療類別的對應關係
     * @param conditionId 適應症ID
     * @param therapyTypes 治療類別陣列
     */
    public void saveTherapyMappings(Long conditionId, String[] therapyTypes) {
        dao.saveTherapyMappings(conditionId, therapyTypes);
    }

    /**
     * 刪除特定適應症的所有對應關係
     * @param conditionId 適應症ID
     */
    public void deleteByIndicationId(Long conditionId) {
        dao.deleteByIndicationId(conditionId);
    }
}
