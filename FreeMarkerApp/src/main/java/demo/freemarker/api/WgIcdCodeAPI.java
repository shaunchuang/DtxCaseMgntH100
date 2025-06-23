package demo.freemarker.api;

import demo.freemarker.dao.WgIcdCodeDAO;
import demo.freemarker.model.WgIcdCode;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;

public class WgIcdCodeAPI implements API {

    private final static WgIcdCodeAPI INSTANCE = new WgIcdCodeAPI();

    public final static WgIcdCodeAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "WgIcdCodeAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "ICD 碼 API";
    }

    public List<WgIcdCode> listWgIcdCode() {
        try {
            List<WgIcdCode> output = new ArrayList<>();
            List<IntIdDataEntity> list = WgIcdCodeDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((WgIcdCode) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public WgIcdCode getWgIcdCode(long id) {
        try {
            return (WgIcdCode) WgIcdCodeDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createWgIcdCode(WgIcdCode icdCode) {
        try {
            WgIcdCodeDAO.getInstance().create(icdCode);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateWgIcdCode(WgIcdCode icdCode) {
        try {
            WgIcdCodeDAO.getInstance().edit(icdCode);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteWgIcdCode(long id) {
        try {
            WgIcdCodeDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據ICD碼搜尋")
    public WgIcdCode searchByCode(String code) {
        try {
            return WgIcdCodeDAO.getInstance().searchByCode(code);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據純ICD碼搜尋")
    public List<WgIcdCode> searchByPureCode(String pureCode) {
        try {
            return WgIcdCodeDAO.getInstance().searchByPureCode(pureCode);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public WgIcdCode getByPureCode(String pureCode) {
        try {
            return WgIcdCodeDAO.getInstance().searchByPureCode(pureCode).get(0);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
}
