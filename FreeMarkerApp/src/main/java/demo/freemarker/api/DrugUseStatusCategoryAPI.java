package demo.freemarker.api;

import demo.freemarker.dao.DrugUseStatusCategoryDAO;
import demo.freemarker.model.DrugUseStatusCategory;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;

/**
 * 毒品使用狀態分類 API
 */
public class DrugUseStatusCategoryAPI implements API {
    private final static DrugUseStatusCategoryAPI INSTANCE = new DrugUseStatusCategoryAPI();

    public final static DrugUseStatusCategoryAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "DrugUseStatusCategoryAPI";
    }

    @Override
    public String getVersion() {
        return "20250612.01";
    }

    @Override
    public String getDescription() {
        return "毒品使用狀態分類 API";
    }

    public List<DrugUseStatusCategory> listAll() {
        try {
            List<DrugUseStatusCategory> output = new ArrayList<>();
            List<IntIdDataEntity> list = DrugUseStatusCategoryDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((DrugUseStatusCategory) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public DrugUseStatusCategory getById(long id) {
        try {
            return (DrugUseStatusCategory) DrugUseStatusCategoryDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void create(DrugUseStatusCategory entity) {
        try {
            DrugUseStatusCategoryDAO.getInstance().create(entity);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void update(DrugUseStatusCategory entity) {
        try {
            DrugUseStatusCategoryDAO.getInstance().edit(entity);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void delete(long id) {
        try {
            DrugUseStatusCategoryDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<DrugUseStatusCategory> listByName(String name) {
        return DrugUseStatusCategoryDAO.getInstance().findByName(name);
    }
}
