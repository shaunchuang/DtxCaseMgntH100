package demo.freemarker.dto;

/* 個案管理平台-個案預約排程資訊專屬 */
public class CaseAppoEvent {
	public Long serialno;
	public Long caseno;
	public Long slotId;
	public String name;
	public String gender;
	public String age;
	public String indication;
	public String appoTime;
	public String checkinTime;
	public Boolean isFirstDiag = true;
        public String appoDate;
        public String doctorName;
        public String doctorAlias;

	public CaseAppoEvent() {
	}

	public CaseAppoEvent(Long serialno, Long caseno, Long slotId, String name, String gender, String age, String indication, String appoTime, String checkinTime, Boolean isFirstDiag) {
		this.serialno = serialno;
		this.caseno = caseno;
		this.slotId = slotId;
		this.name = name;
		this.gender = gender;
		this.age = age;
		this.indication = indication;
		this.appoTime = appoTime;
		this.checkinTime = checkinTime;
		this.isFirstDiag = isFirstDiag;
	}

	@Override
	public String toString() {
		return "CaseAppointment{caseno=" + caseno +
				", slotId='" + slotId + '\'' +
				", name='" + name + '\'' +
				", gender='" + gender + '\'' +
				", age='" + age + '\'' +
				", appoTime='" + appoTime + '\'' +
				", checkinTime='" + checkinTime + '\'' +
				", isFirstDiag='" + isFirstDiag + '\'' +
				'}';
	}

	public Long getSerialno() {
		return serialno;
	}

	public void setSerialno(Long serialno) {
		this.serialno = serialno;
	}

	public Long getCaseno() {
		return caseno;
	}

	public void setCaseno(Long caseno) {
		this.caseno = caseno;
	}

	public Long getSlotId() {
		return slotId;
	}

	public void setSlotId(Long slotId) {
		this.slotId = slotId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getIndication() {
		return indication;
	}

	public void setIndication(String indication) {
		this.indication = indication;
	}

	public String getAppoTime() {
		return appoTime;
	}

	public void setAppoTime(String appoTime) {
		this.appoTime = appoTime;
	}

	public String getCheckinTime() {
		return checkinTime;
	}

	public void setCheckinTime(String checkinTime) {
		this.checkinTime = checkinTime;
	}

	public Boolean getIsFirstDiag() {
		return isFirstDiag;
	}

	public void setIsFirstDiag(Boolean isFirstDiag) {
		this.isFirstDiag = isFirstDiag;
	}

        public String getAppoDate() {
            return appoDate;
        }

        public void setAppoDate(String appoDate) {
            this.appoDate = appoDate;
        }

        public String getDoctorName() {
            return doctorName;
        }

        public void setDoctorName(String doctorName) {
            this.doctorName = doctorName;
        }

        public String getDoctorAlias() {
            return doctorAlias;
        }

        public void setDoctorAlias(String doctorAlias) {
            this.doctorAlias = doctorAlias;
        }
}