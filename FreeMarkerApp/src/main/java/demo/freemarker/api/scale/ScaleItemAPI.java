package demo.freemarker.api.scale;

import demo.freemarker.dao.scale.ScaleItemDAO;
import demo.freemarker.model.scale.ScaleItem;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;

public class ScaleItemAPI implements API {
    
    private final static ScaleItemAPI INSTANCE = new ScaleItemAPI();

    public final static ScaleItemAPI getInstance() {
        return INSTANCE;
    }


    @Override
    public String getName() {
        return "ScaleItemAPI";
    }

    @Override
    public String getVersion() {
        return "20250429.1";
    }

    @Override
    public String getDescription() {
        return "量表項目 API";
    }

    @APIDefine(description = "根據ID取得量表項目")
    public ScaleItem getScaleItem(Long id) {
        try {
            return (ScaleItem) ScaleItemDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "新增量表項目")
    public void createScaleItem(ScaleItem scaleItem) {
        try {
            ScaleItemDAO.getInstance().create(scaleItem);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "更新量表項目")
    public void updateScaleItem(ScaleItem scaleItem) {
        try {
            ScaleItemDAO.getInstance().edit(scaleItem);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "刪除量表項目")
    public void deleteScaleItem(Long id) {
        try {
            ScaleItemDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    public List<ScaleItem> list() {
        List<ScaleItem> list = new ArrayList<>();
        try {
            List<IntIdDataEntity> entities = ScaleItemDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : entities) {
                list.add((ScaleItem) entity);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }
    }

    @APIDefine(description = "根據量表ID取得量表項目")
    public List<ScaleItem> listScaleItemByScaleId(Long scaleId) {
        try {
            return ScaleItemDAO.getInstance().findByScaleId(scaleId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<ScaleItem> listScaleItemByScaleIdAndSectionId(Long scaleId, Long sectionId) {
        try {
            return ScaleItemDAO.getInstance().findByScaleIdAndSectionId(scaleId, sectionId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<ScaleItem> listChildScaleItem(Long parentScleItemId) {
        try {
            return ScaleItemDAO.getInstance().findByChildScaleItemId(parentScleItemId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<String> listEvaluationType(Long scaleId, Long sectionId) {
        List<String> evaluationTypes = new ArrayList<>();
        try {
            List<ScaleItem> scaleItems = ScaleItemDAO.getInstance().findByScaleIdAndSectionId(scaleId, sectionId);
            for (ScaleItem scaleItem : scaleItems) {
                evaluationTypes.add(scaleItem.getEvaluationType());
            }
            return evaluationTypes;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public Boolean hasParentItem(Long scaleItemId) {
        try {
            ScaleItem scaleItem = ScaleItemDAO.getInstance().findById(scaleItemId);
            return scaleItem.getParentItemId() != null && scaleItem.getParentItemId() > 0;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public Long findParentItemNo(Long childItemId) {
        try {
            return ScaleItemDAO.getInstance().findParentItemNo(childItemId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
}
