package demo.freemarker.api.scale;

import java.util.ArrayList;
import java.util.List;

import demo.freemarker.dao.scale.ScaleSectionDAO;
import demo.freemarker.model.scale.ScaleSection;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;

public class ScaleSectionAPI implements API {
        
        private final static ScaleSectionAPI INSTANCE = new ScaleSectionAPI();
    
        public final static ScaleSectionAPI getInstance() {
            return INSTANCE;
        }
    
        @Override
        public String getName() {
            return "ScaleSectionAPI";
        }
    
        @Override
        public String getVersion() {
            return "20250429.1";
        }
    
        @Override
        public String getDescription() {
            return "量表項目區段 API";
        }

        public List<ScaleSection> list() {
            List<ScaleSection> list = new ArrayList<>();
            try {
                List<IntIdDataEntity> entities = ScaleSectionDAO.getInstance().findEntities();
                for (IntIdDataEntity entity : entities) {
                    list.add((ScaleSection) entity);
                }
                return list;
            } catch (Exception e) {
                throw new RuntimeException(e.getMessage());
            }
        }
        
        @APIDefine(description = "根據ID取得量表項目區段")
        public ScaleSection getScaleSection(Long id) {
            try {
                return (ScaleSection) ScaleSectionDAO.getInstance().findEntity(id);
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }

        @APIDefine(description = "新增量表項目區段")
        public void createScaleSection(ScaleSection scaleSection) {
            try {
                ScaleSectionDAO.getInstance().create(scaleSection);
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }

        @APIDefine(description = "更新量表項目區段")
        public void updateScaleSection(ScaleSection scaleSection) {
            try {
                ScaleSectionDAO.getInstance().edit(scaleSection);
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }

        @APIDefine(description = "刪除量表項目區段")
        public void deleteScaleSection(Long id) {
            try {
                ScaleSectionDAO.getInstance().destroy(id);
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }

        @APIDefine(description = "根據量表ID取得量表項目區段")
        public List<ScaleSection> listScaleSectionByScaleId(Long scaleId) {
            try {
                return ScaleSectionDAO.getInstance().findByScaleId(scaleId);
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
}
