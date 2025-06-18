package demo.freemarker.api.scale;

import java.util.ArrayList;
import java.util.List;

import demo.freemarker.dao.scale.ScaleLevelDAO;
import demo.freemarker.model.scale.ScaleLevel;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;

public class ScaleLevelAPI implements API {
    
    private final static ScaleLevelAPI INSTANCE = new ScaleLevelAPI();

    public final static ScaleLevelAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "ScaleLevelAPI";
    }

    @Override
    public String getVersion() {
        return "20250423.1";
    }

    @Override
    public String getDescription() {
        return "量表等級 API";
    }
    
    public List<ScaleLevel> list() {
        List<ScaleLevel> list = new ArrayList<>();
        try {
            List<IntIdDataEntity> entities = ScaleLevelDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : entities) {
                list.add((ScaleLevel) entity);
            }
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    @APIDefine(description = "根據ID取得量表等級")
    public ScaleLevel getScaleLevel(Long id) {
        try {
            return (ScaleLevel) ScaleLevelDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "新增量表等級")
    public void createScaleLevel(ScaleLevel scaleLevel) {
        try {
            ScaleLevelDAO.getInstance().create(scaleLevel);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "更新量表等級")
    public void updateScaleLevel(ScaleLevel scaleLevel) {
        try {
            ScaleLevelDAO.getInstance().edit(scaleLevel);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "刪除量表等級")
    public void deleteScaleLevel(Long id) {
        try {
            ScaleLevelDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據量表ID取得量表等級")
    public List<ScaleLevel> listByScaleId(Long scaleId) {
        try {
            return ScaleLevelDAO.getInstance().findByScaleId(scaleId);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public ScaleLevel findByScaleId(Long scaleId){
        try {
            return ScaleLevelDAO.getInstance().findByScaleId(scaleId).get(0);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據量表ID取得量表等級")
    public String findLevelNameById(Long levelId){
        try {
            ScaleLevel scaleLevel = getScaleLevel(levelId);
            return scaleLevel.getLevel();
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據量表ID和分數取得量表等級")
    public ScaleLevel findByScore(Long scaleId, Integer score) {
        try {
            return ScaleLevelDAO.getInstance().findByScore(scaleId, score);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
}
