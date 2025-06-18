package demo.freemarker.api;

import demo.freemarker.dao.MedicationCategoryDAO;
import demo.freemarker.model.MedicationCategory;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class MedicationCategoryAPI implements API {

    private final static MedicationCategoryAPI INSTANCE = new MedicationCategoryAPI();

    public final static MedicationCategoryAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "MedicationCategoryAPI";
    }

    @Override
    public String getVersion() {
        return "20250610.01";
    }

    @Override
    public String getDescription() {
        return "藥品分類 API";
    }    public List<MedicationCategory> listAll() {
        try {
            List<MedicationCategory> output = new ArrayList<>();
            List<IntIdDataEntity> list = MedicationCategoryDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((MedicationCategory) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    

public List<MedicationCategory> listLocale(Locale locale) {
    try {
        List<IntIdDataEntity> rawList = MedicationCategoryDAO
            .getInstance()
            .findEntities();

        List<MedicationCategory> output = new ArrayList<>(rawList.size());
        for (IntIdDataEntity entity : rawList) {
            MedicationCategory mc = (MedicationCategory) entity;
            String localized = mc.getLocaleName(locale);
            mc.setName(localized);
            output.add(mc);
        }

        return output;
    } catch (Exception ex) {
        // 包裝一下 exception，比直接丟 message 清楚
        throw new RuntimeException(
            "取得多語系用藥類別失敗: " + ex.getMessage(), ex
        );
    }
}    public MedicationCategory getById(long id) {
        try {
            return (MedicationCategory) MedicationCategoryDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void create(MedicationCategory entity) {
        try {
            MedicationCategoryDAO.getInstance().create(entity);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void update(MedicationCategory entity) {
        try {
            MedicationCategoryDAO.getInstance().edit(entity);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void delete(long id) {
        try {
            MedicationCategoryDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<MedicationCategory> listByName(String name) {
        return MedicationCategoryDAO.getInstance().findByName(name);
    }
}
