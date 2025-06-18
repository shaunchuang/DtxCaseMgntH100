package demo.freemarker.dto;

import demo.freemarker.model.scale.ScaleLevel;
import demo.freemarker.core.StringUtils;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ScaleForm {

    private Long id;
    private String name;
    private String type;
    private String evaluator;
    private String desc;
    private String version;
    private Date createTime;
    private PatientInfo patientInfo;
    private AssessmentFinalResult result;
    private List<ScaleLevel> levels = new ArrayList<>();
    private List<Section> sections = new ArrayList<>();
    private List<QuestionItem> items = new ArrayList<>();

    public static List<Map<String, String>> typeItemList = Arrays.asList(
            createMap("binary", "二元選擇"),
            createMap("multiple_choice", "多選項對應分數"),
            createMap("scale", "尺度評分"),
            createMap("multi_evaluation", "綜合評估")
    );

    public static List<Map<String, String>> evaluatorTypeList = Arrays.asList(
            createMap("C", "個案/家屬"),
            createMap("E", "專業醫護人員")
    );

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getEvaluator() {
        return evaluator;
    }

    public void setEvaluator(String evaluator) {
        this.evaluator = evaluator;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public PatientInfo getPatientInfo() {
        return patientInfo;
    }

    public void setPatientInfo(PatientInfo patientInfo) {
        this.patientInfo = patientInfo;
    }

    public static List<Map<String, String>> getTypeItemList() {
        return typeItemList;
    }

    public static void setTypeItemList(List<Map<String, String>> typeItemList) {
        ScaleForm.typeItemList = typeItemList;
    }

    public static List<Map<String, String>> getEvaluatorTypeList() {
        return evaluatorTypeList;
    }

    public static void setEvaluatorTypeList(List<Map<String, String>> evaluatorTypeList) {
        ScaleForm.evaluatorTypeList = evaluatorTypeList;
    }

    
    
    public AssessmentFinalResult getResult() {
        return result;
    }

    public void setResult(AssessmentFinalResult result) {
        this.result = result;
    }

    public List<ScaleLevel> getLevels() {
        return levels;
    }

    public void setLevels(List<ScaleLevel> levels) {
        this.levels = levels;
    }

    public List<Section> getSections() {
        return sections;
    }

    public void setSections(List<Section> sections) {
        this.sections = sections;
    }

    public List<QuestionItem> getItems() {
        return items;
    }

    public void setItems(List<QuestionItem> items) {
        this.items = items;
    }

    public Map<String, String> getTypeItemMap() {
        Map<String, String> options = new LinkedHashMap<>();
        for (Map<String, String> map : typeItemList) {
            for (Map.Entry<String, String> entry : map.entrySet()) {
                options.put(entry.getKey(), entry.getKey() + "　(" + entry.getValue() + ")");
            }
        }
        return options;
    }

    public Map<String, String> getEvaluatorTypeMap() {
        Map<String, String> options = new LinkedHashMap<>();
        for (Map<String, String> map : evaluatorTypeList) {
            for (Map.Entry<String, String> entry : map.entrySet()) {
                options.put(entry.getKey(), entry.getValue());
            }
        }
        return options;
    }

    public void format() {
        this.name = StringUtils.isEmpty(this.name) ? null : StringUtils.trim(this.name).toLowerCase();
        this.version = StringUtils.isEmpty(this.version) ? null : StringUtils.trim(this.version).toUpperCase();
        this.desc = StringUtils.isEmpty(this.desc) ? null : StringUtils.trim(this.desc).toUpperCase();

        if (this.levels != null) {
            for (ScaleLevel level : this.levels) {
                level.format();
            }
        }

        if (this.items != null) {
            for (QuestionItem item : this.items) {
                item.format();
            }
        }

        if (this.sections != null) {
            for (Section section : this.sections) {
                section.format();
            }
        }
    }

    public static Map<String, String> createMap(String key, String value) {
        Map<String, String> map = new HashMap<>();
        map.put(key, value);
        return map;
    }

}
