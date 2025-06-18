package demo.freemarker.api;

import demo.freemarker.dao.WgAvailableSlotsDAO;
import demo.freemarker.model.WgAvailableSlots;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class WgAvailableSlotsAPI implements API {

    private final static WgAvailableSlotsAPI INSTANCE = new WgAvailableSlotsAPI();

    public final static WgAvailableSlotsAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "WgAvailableSlotsAPI";
    }

    @Override
    public String getVersion() {
        return "20250324.01";
    }

    @Override
    public String getDescription() {
        return "醫師可用時段 API";
    }

    public List<WgAvailableSlots> listWgAvailableSlots() {
        try {

            List<WgAvailableSlots> output = new ArrayList<>();
            List<IntIdDataEntity> list = WgAvailableSlotsDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((WgAvailableSlots) entity);
            }
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public WgAvailableSlots getWgAvailableSlot(long id) {
        try {
            return (WgAvailableSlots) WgAvailableSlotsDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createWgAvailableSlot(WgAvailableSlots slot) {
        try {
            WgAvailableSlotsDAO.getInstance().create(slot);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateWgAvailableSlot(WgAvailableSlots slot) {
        try {
            WgAvailableSlotsDAO.getInstance().edit(slot);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteWgAvailableSlot(long id) {
        try {
            WgAvailableSlotsDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<WgAvailableSlots> findAvailableSlotsByDoctorAndDateRange(Long doctorId, Date startDate, Date endDate) {
        try {
            return  WgAvailableSlotsDAO.getInstance().listByDoctorIdAndDateRange(doctorId, startDate, endDate);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }

    }
    
    public List<WgAvailableSlots> listByDoctorIdAndDate(Long doctorId, Date date) {
        try{
            return WgAvailableSlotsDAO.getInstance().listByDoctorIdAndDate(doctorId, date);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

}
