package demo.freemarker.api.healthinsurance;

import demo.freemarker.dao.healthinsurance.MedicalServicePaymentItemsDAO;
import demo.freemarker.model.healthinsurance.MedicalServicePaymentItems;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.List;

public class MedicalServicePaymentItemsAPI implements API {

    private final static MedicalServicePaymentItemsAPI INSTANCE = new MedicalServicePaymentItemsAPI();

    public final static MedicalServicePaymentItemsAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "MedicalServicePaymentItemsAPI";
    }

    @Override
    public String getVersion() {
        return "20250409.01";
    }

    @Override
    public String getDescription() {
        return "醫療服務支付項目 API";
    }

    public List<MedicalServicePaymentItems> listMedicalServicePaymentItems() {
        List<MedicalServicePaymentItems> output = new ArrayList<>();
        List<IntIdDataEntity> list = MedicalServicePaymentItemsDAO.getInstance().findEntities();
        for (IntIdDataEntity entity : list) {
            output.add((MedicalServicePaymentItems) entity);
        }
        return output;
    }

    public MedicalServicePaymentItems getMedicalServicePaymentItem(long id) {
        try {
            return (MedicalServicePaymentItems) MedicalServicePaymentItemsDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createMedicalServicePaymentItem(MedicalServicePaymentItems item) {
        try {
            MedicalServicePaymentItemsDAO.getInstance().create(item);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateMedicalServicePaymentItem(MedicalServicePaymentItems item) {
        try {
            MedicalServicePaymentItemsDAO.getInstance().edit(item);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteMedicalServicePaymentItem(long id) {
        try {
            MedicalServicePaymentItemsDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據代碼搜尋支付項目")
    public List<MedicalServicePaymentItems> searchByCode(String code) {
        try {
            return MedicalServicePaymentItemsDAO.getInstance().searchByCode(code);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據項目名稱搜尋支付項目")
    public List<MedicalServicePaymentItems> searchByItem(String item) {
        try {
            return MedicalServicePaymentItemsDAO.getInstance().searchByItem(item);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "根據代碼和項目名稱搜尋支付項目")
    public List<MedicalServicePaymentItems> searchByCodeAndItem(String code, String item) {
        try {
            return MedicalServicePaymentItemsDAO.getInstance().searchByCodeAndItem(code, item);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

        public MedicalServicePaymentItems findByCode(String code) {
        try {
            return MedicalServicePaymentItemsDAO.getInstance().findByCode(code);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
}