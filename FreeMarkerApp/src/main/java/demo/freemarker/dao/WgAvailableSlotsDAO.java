package demo.freemarker.dao;

import demo.freemarker.api.WgTaskAPI;
import demo.freemarker.model.WgAvailableSlots;
import itri.sstc.framework.core.database.IntIdBaseDAO;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;

public class WgAvailableSlotsDAO extends IntIdBaseDAO {

    final static WgAvailableSlotsDAO instance = new WgAvailableSlotsDAO("DTXCASEMGNT_PU");

    public final static WgAvailableSlotsDAO getInstance() {
        return instance;
    }

    private WgAvailableSlotsDAO(String puName) {
        super(puName, WgAvailableSlots.class);
    }

    @Override
    public String getTableName() {
        return "WgAvailableSlots";
    }

    public List<WgAvailableSlots> listWgAvailableSlots(String param) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("WgAvailableSlots.findAll");
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<WgAvailableSlots>();
        } finally {
            em.close();
        }
    }

    public List<WgAvailableSlots> listByDoctorIdAndDate(Long doctorId, Date date) {
        EntityManager em = getEntityManager();
        try {
            Date startDate = truncateTime(date);
            
            Query q = em.createNamedQuery("WgAvailableSlots.findByDoctorAndDate");
            q.setParameter("doctor", doctorId);
            q.setParameter("slotDate", startDate);
            
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<WgAvailableSlots>();
        } finally {
            em.close();
        }
    }

    public List<WgAvailableSlots> listByDoctorIdAndBeforeDate(Long doctorId, Date date) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("WgAvailableSlots.findByDoctorIdAndBeforeDate");
            q.setParameter("doctorId", doctorId);
            q.setParameter("slotDate", date);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<WgAvailableSlots>();
        } finally {
            em.close();
        }
    }
    
    public List<WgAvailableSlots> listByDoctorIdAndAfterDate(Long doctorId, Date date) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("WgAvailableSlots.findAvailableByDoctorAndAfterDate");
            q.setParameter("doctor", doctorId);
            q.setParameter("startDate", date);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<WgAvailableSlots>();
        } finally {
            em.close();
        }
    }

    public List<WgAvailableSlots> listByDoctorIdAndDateRange(Long doctorId, Date startDate, Date endDate) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createNamedQuery("WgAvailableSlots.findByDoctorAndDateRange");
            q.setParameter("doctor", doctorId);
            q.setParameter("startDate", startDate);
            q.setParameter("endDate", endDate);
            return q.getResultList();
        } catch (Exception ex) {
            return new ArrayList<WgAvailableSlots>();
        } finally {
            em.close();
        }
    }

    public static Date truncateTime(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return cal.getTime();
    }
}
