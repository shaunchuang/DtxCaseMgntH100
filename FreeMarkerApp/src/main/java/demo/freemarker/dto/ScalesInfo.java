package demo.freemarker.dto;

import static demo.freemarker.dto.ScaleForm.evaluatorTypeList;
import static demo.freemarker.dto.ScaleForm.typeItemList;
import demo.freemarker.model.scale.Scale;
import java.util.Locale;
import java.util.Map;

public class ScalesInfo {

    private Long id;
    private String catId;
    private String catName;
    private String name;
    private String type;
    private String evaluator;
    private String desc;
    private String version;

    public ScalesInfo(Scale scales, Locale locale) {
        this.id = scales.getId();
        this.catId = scales.getCategory();
        this.catName = Scale.TreatmentType.getAbbrListMap(locale).getOrDefault(catId, catId);
        this.name = scales.getName();
        this.type = codeToType(scales.getType());
        this.evaluator = codeToEvaluator(scales.getEvaluator());
        this.desc = scales.getDescription();
        this.version = scales.getVersion();
    }

    public String codeToType(String typeCode) {
        for (Map<String, String> map : typeItemList) {
            for (Map.Entry<String, String> entry : map.entrySet()) {
                if (entry.getKey().equals(typeCode)) {
                    return entry.getValue();
                }
            }
        }

        return typeCode; // Return the original code if no match is found
    }

    public String codeToEvaluator(String evaluatorCode) {
        for (Map<String, String> map : evaluatorTypeList) {
            for (Map.Entry<String, String> entry : map.entrySet()) {
                if (entry.getKey().equals(evaluatorCode)) {
                    return entry.getValue();
                }
            }
        }

        return evaluatorCode; // Return the original code if no match is found
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCatId() {
        return catId;
    }

    public void setCatId(String catId) {
        this.catId = catId;
    }

    public String getCatName() {
        return catName;
    }

    public void setCatName(String catName) {
        this.catName = catName;
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


}
