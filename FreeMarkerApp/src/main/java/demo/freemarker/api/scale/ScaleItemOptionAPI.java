package demo.freemarker.api.scale;

import java.util.ArrayList;
import java.util.List;

import demo.freemarker.dao.scale.ScaleItemOptionDAO;
import demo.freemarker.model.scale.ScaleItemOption;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;

public class ScaleItemOptionAPI implements API {

    private final static ScaleItemOptionAPI INSTANCE = new ScaleItemOptionAPI();

    public final static ScaleItemOptionAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "ScaleItemOptionAPI";
    }

    @Override
    public String getVersion() {
        return "20250429.2";
    }

    @Override
    public String getDescription() {
        return "量表項目選項 API";
    }
    
    @APIDefine(description = "取得所有量表項目選項")
    public List<ScaleItemOption> list(){
        List<ScaleItemOption> list = new ArrayList<>();
        try {
            List<IntIdDataEntity> entities = ScaleItemOptionDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : entities) {
                list.add((ScaleItemOption) entity);
            }
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }
    
    @APIDefine(description = "根據ID取得量表項目選項")
    public ScaleItemOption getScaleItemOption(Long id) {
        try {
            return (ScaleItemOption) ScaleItemOptionDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "新增量表項目選項")
    public void createScaleItemOption(ScaleItemOption scaleItemOption) {
        try {
            ScaleItemOptionDAO.getInstance().create(scaleItemOption);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "更新量表項目選項")
    public void updateScaleItemOption(ScaleItemOption scaleItemOption) {
        try {
            ScaleItemOptionDAO.getInstance().edit(scaleItemOption);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "刪除量表項目選項")
    public void deleteScaleItemOption(Long id) {
        try {
            ScaleItemOptionDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據量表項目ID取得量表項目選項")
    public List<ScaleItemOption> listScalesItemOptionByScaleItemId(Long scaleItemId) {
        try {
            return ScaleItemOptionDAO.getInstance().findByScaleItemId(scaleItemId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
}
