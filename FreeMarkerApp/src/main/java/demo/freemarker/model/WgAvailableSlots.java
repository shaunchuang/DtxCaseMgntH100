package demo.freemarker.model;

import itri.sstc.framework.core.database.IntIdDataEntity;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "wg_available_slots")
@NamedQueries({
    @NamedQuery(name = "WgAvailableSlots.findByDoctor", query = "SELECT w FROM WgAvailableSlots w WHERE w.doctor = :doctor"),
    @NamedQuery(name = "WgAvailableSlots.findBySlotDate", query = "SELECT w FROM WgAvailableSlots w WHERE w.slotDate = :slotDate"),
    @NamedQuery(name = "WgAvailableSlots.findAvailable", query = "SELECT w FROM WgAvailableSlots w WHERE w.isBooked = false"),
    @NamedQuery(name = "WgAvailableSlots.findByDoctorAndDate", query = "SELECT w FROM WgAvailableSlots w WHERE w.doctor = :doctor AND w.slotDate = :slotDate AND  w.isBooked = true"),
    @NamedQuery(name = "WgAvailableSlots.findByDoctorAndDateRange", query = "SELECT w FROM WgAvailableSlots w WHERE w.doctor = :doctor AND w.slotDate >= :startDate AND w.slotDate <= :endDate AND w.isBooked = false"),
    @NamedQuery(name = "WgAvailableSlots.findByDoctorAndBeforeDate", query = "SELECT w FROM WgAvailableSlots w WHERE w.doctor = :doctor AND w.slotDate < :slotDate"),
    @NamedQuery(name = "WgAvailableSlots.findAvailableByDoctorAndAfterDate", query = "SELECT w FROM WgAvailableSlots w WHERE w.doctor = :doctor AND w.slotDate >= :startDate AND w.isBooked = false")
})
public class WgAvailableSlots implements IntIdDataEntity, Serializable {

    private static final long serialVersionUID = 6895651421520312351L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

    @Column(name = "\"doctor\"")
	private Long doctor;       // 醫師或治療師的ID

    @Column(name = "\"slot_date\"")
    @Temporal(TemporalType.DATE)
    private Date slotDate;     // 可預約日期

    @Column(name = "\"slot_begin_time\"")
    @Temporal(TemporalType.TIME)
    private Date slotBeginTime; // 時段開始時間

    @Column(name = "\"slot_end_time\"")
    @Temporal(TemporalType.TIME)
    private Date slotEndTime;   // 時段結束時間

    @Column(name = "\"is_booked\"")
    private boolean isBooked;    // 該時段是否已被預約

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getDoctor() {
        return doctor;
    }

    public void setDoctor(Long doctor) {
        this.doctor = doctor;
    }

    public Date getSlotDate() {
        return slotDate;
    }

    public void setSlotDate(Date slotDate) {
        this.slotDate = slotDate;
    }

    public Date getSlotBeginTime() {
        return slotBeginTime;
    }

    public void setSlotBeginTime(Date slotBeginTime) {
        this.slotBeginTime = slotBeginTime;
    }

    public Date getSlotEndTime() {
        return slotEndTime;
    }

    public void setSlotEndTime(Date slotEndTime) {
        this.slotEndTime = slotEndTime;
    }

    public boolean isIsBooked() {
        return isBooked;
    }

    public void setIsBooked(boolean isBooked) {
        this.isBooked = isBooked;
    }

    
}
