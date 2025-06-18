package demo.freemarker.api;

import demo.freemarker.dao.DiseaseCategoryDAO;
import demo.freemarker.model.DiseaseCategory;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class DiseaseCategoryAPI implements API {

    private final static DiseaseCategoryAPI INSTANCE = new DiseaseCategoryAPI();

    public final static DiseaseCategoryAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "DiseaseCategoryAPI";
    }

    @Override
    public String getVersion() {
        return "20250610.01";
    }

    @Override
    public String getDescription() {
        return "疾病分類 API";
    }

    public List<DiseaseCategory> list() {
        try {
            List<DiseaseCategory> output = new ArrayList<>();
            List<IntIdDataEntity> list = DiseaseCategoryDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((DiseaseCategory) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    

public List<DiseaseCategory> listLocale(Locale locale) {
    try {
        List<IntIdDataEntity> rawList = DiseaseCategoryDAO
            .getInstance()
            .findEntities();

        List<DiseaseCategory> output = new ArrayList<>(rawList.size());
        for (IntIdDataEntity entity : rawList) {
            DiseaseCategory mc = (DiseaseCategory) entity;
            String localized = mc.getLocaleName(locale);
            mc.setName(localized);
            output.add(mc);
        }

        return output;
    } catch (Exception ex) {
        throw new RuntimeException(ex.getMessage(), ex);
    }
}

    public DiseaseCategory getDiseaseCategory(long id) {
        try {
            return (DiseaseCategory) DiseaseCategoryDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createDiseaseCategory(DiseaseCategory diseaseCategory) {
        try {
            DiseaseCategoryDAO.getInstance().create(diseaseCategory);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateDiseaseCategory(DiseaseCategory diseaseCategory) {
        try {
            DiseaseCategoryDAO.getInstance().edit(diseaseCategory);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteDiseaseCategory(long id) {
        try {
            DiseaseCategoryDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
}
