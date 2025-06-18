/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.core;

import demo.freemarker.api.IndicationTherapyMappingAPI;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * 適應症與治療類別對應工具類
 * 
 * @author zhush
 */
public class IndicationTherapyUtils {
    
    // 靜態對應表，用於快速查詢（避免頻繁查詢資料庫）
    private static final Map<Long, String[]> INDICATION_TO_THERAPY_MAP = new HashMap<>();
    
    static {
        // 初始化靜態對應表
        INDICATION_TO_THERAPY_MAP.put(1L, new String[]{"OT", "PS"});  // 注意力不足過動症
        INDICATION_TO_THERAPY_MAP.put(2L, new String[]{"PS"});        // 憂鬱症
        INDICATION_TO_THERAPY_MAP.put(3L, new String[]{"PS"});        // 創傷後壓力症候群
        INDICATION_TO_THERAPY_MAP.put(4L, new String[]{"ST", "OT"});  // 自閉症
        INDICATION_TO_THERAPY_MAP.put(5L, new String[]{"PS"});        // 焦慮症
        INDICATION_TO_THERAPY_MAP.put(6L, new String[]{"PS"});        // 強迫症
        INDICATION_TO_THERAPY_MAP.put(7L, new String[]{"PS"});        // 躁鬱症
        INDICATION_TO_THERAPY_MAP.put(8L, new String[]{"PS"});        // 精神分裂症
        INDICATION_TO_THERAPY_MAP.put(9L, new String[]{"PS"});        // 社交恐懼症
        INDICATION_TO_THERAPY_MAP.put(10L, new String[]{"PS"});       // 進食障礙
        INDICATION_TO_THERAPY_MAP.put(11L, new String[]{"PT"});       // 帕金森氏症
        INDICATION_TO_THERAPY_MAP.put(12L, new String[]{"OT", "ST"}); // 阿茲海默症
        INDICATION_TO_THERAPY_MAP.put(13L, new String[]{"PT"});       // 關節炎
        INDICATION_TO_THERAPY_MAP.put(14L, new String[]{"OT"});       // 發展遲緩
        INDICATION_TO_THERAPY_MAP.put(15L, new String[]{"ST"});       // 失語症
        INDICATION_TO_THERAPY_MAP.put(16L, new String[]{"ST"});       // 語用障礙
        INDICATION_TO_THERAPY_MAP.put(17L, new String[]{"ST"});       // 構音障礙
        INDICATION_TO_THERAPY_MAP.put(18L, new String[]{"ST"});       // 語言發展遲緩
        INDICATION_TO_THERAPY_MAP.put(19L, new String[]{"ST"});       // 語言障礙
        INDICATION_TO_THERAPY_MAP.put(20L, new String[]{"PS"});       // 恐慌症
        INDICATION_TO_THERAPY_MAP.put(21L, new String[]{"PS"});       // 自律神經失調
        INDICATION_TO_THERAPY_MAP.put(22L, new String[]{"PS"});       // 神經衰弱症
        INDICATION_TO_THERAPY_MAP.put(23L, new String[]{"PT"});       // 慢性疼痛
    }
    
    /**
     * 根據適應症ID獲取對應的治療類別（使用靜態對應表）
     * @param indicationId 適應症ID
     * @return 治療類別陣列
     */
    public static String[] getTherapyTypesByIndicationId(Long indicationId) {
        return INDICATION_TO_THERAPY_MAP.getOrDefault(indicationId, new String[0]);
    }
    
    /**
     * 根據適應症ID獲取對應的治療類別（從資料庫查詢）
     * @param indicationId 適應症ID
     * @param api IndicationTherapyMappingAPI 實例
     * @return 治療類別陣列
     */
    public static String[] getTherapyTypesByIndicationIdFromDB(Long indicationId, IndicationTherapyMappingAPI api) {
        return api.getTherapyTypesByIndicationId(indicationId);
    }
    
    /**
     * 檢查適應症是否支援特定治療類別
     * @param indicationId 適應症ID
     * @param therapyType 治療類別 (OT, ST, PT, PS, PS)
     * @return true 如果支援，false 如果不支援
     */
    public static boolean isTherapySupported(Long indicationId, String therapyType) {
        String[] supportedTherapies = getTherapyTypesByIndicationId(indicationId);
        return Arrays.asList(supportedTherapies).contains(therapyType);
    }
    
    /**
     * 獲取治療類別的中文名稱
     * @param therapyType 治療類別代碼
     * @return 中文名稱
     */
    public static String getTherapyTypeName(String therapyType) {
        switch (therapyType) {
            case "OT": return "職能治療";
            case "ST": return "語言治療";
            case "PT": return "物理治療";
            case "PS": return "心理治療";
            default: return therapyType;
        }
    }
    
    /**
     * 獲取適應症對應的所有治療類別中文名稱
     * @param indicationId 適應症ID
     * @return 治療類別中文名稱陣列
     */
    public static String[] getTherapyTypeNamesByIndicationId(Long indicationId) {
        String[] therapyTypes = getTherapyTypesByIndicationId(indicationId);
        String[] therapyNames = new String[therapyTypes.length];
        
        for (int i = 0; i < therapyTypes.length; i++) {
            therapyNames[i] = getTherapyTypeName(therapyTypes[i]);
        }
        
        return therapyNames;
    }
    
    /**
     * 將適應症ID陣列轉換為所有支援的治療類別（去重）
     * @param indicationIds 適應症ID陣列
     * @return 所有支援的治療類別（去重後）
     */
    public static String[] getAllSupportedTherapyTypes(Long[] indicationIds) {
        return Arrays.stream(indicationIds)
                .flatMap(indicationId -> Arrays.stream(getTherapyTypesByIndicationId(indicationId)))
                .distinct()
                .toArray(String[]::new);
    }
    
    /**
     * 生成 JavaScript 對應物件字串，用於前端使用
     * @return JavaScript 物件字串
     */
    public static String generateJavaScriptMapping() {
        StringBuilder sb = new StringBuilder();
        sb.append("const indicationToTherapyMap = {\n");
        
        for (Map.Entry<Long, String[]> entry : INDICATION_TO_THERAPY_MAP.entrySet()) {
            sb.append("  ").append(entry.getKey()).append(": [");
            String[] therapies = entry.getValue();
            for (int i = 0; i < therapies.length; i++) {
                sb.append("'").append(therapies[i]).append("'");
                if (i < therapies.length - 1) {
                    sb.append(", ");
                }
            }
            sb.append("],\n");
        }
        
        sb.append("};");
        return sb.toString();
    }
}
