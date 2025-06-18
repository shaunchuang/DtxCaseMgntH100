package demo.freemarker.dto;

public class TrainingEvent{

    public int serialno;
    public String name;
    public String gender;
    public String age;
    public String indication; //適應症(這個我已經有寫方法，你暫時先以null呈現)
    public String therapCat; //治療領域
    public String therapist; //治療師名字
    public String lesson; //教案名稱
    public String frequency; //治療師專用--訓練頻率
    public String times; //治療師專用--訓練次數
    public String beginDate; //治療師專用--起始日期
    public String duration; //治療師專用--訓練時長
    public Boolean isAbnormal = false;
    
    public TrainingEvent() {

    }
    
    public TrainingEvent(int serialno, String name, String gender, String age, String indication,
            String therapCat, String therapist, String lesson, String frequency, String times,
            String beginDate, String duration, Boolean isAbnormal){
        this.serialno = serialno;
        this.name = name;
        this.gender = gender;
        this.age = age;
        this.indication = indication;
        this.therapCat = therapCat;
        this.therapist = therapist;
        this.lesson = lesson;
        this.frequency = frequency;
        this.times = times;
        this.beginDate = beginDate;
        this.duration = duration;
        this.isAbnormal = isAbnormal;
    }

    public int getSerialno() {
        return serialno;
    }

    public String getName() {
        return name;
    }

    public String getGender() {
        return gender;
    }

    public String getAge() {
        return age;
    }

    public String getIndication() {
        return indication;
    }

    public String getTherapCat() {
        return therapCat;
    }

    public String getTherapist() {
        return therapist;
    }

    public String getLesson() {
        return lesson;
    }

    public String getFrequency() {
        return frequency;
    }

    public String getTimes() {
        return times;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public String getDuration() {
        return duration;
    }

    public Boolean getIsAbnormal() {
        return isAbnormal;
    }
    
    public void setSerialno(int serialno) {
        this.serialno = serialno;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public void setIndication(String indication) {
        this.indication = indication;
    }

    public void setTherapCat(String therapCat) {
        this.therapCat = therapCat;
    }

    public void setTherapist(String therapist) {
        this.therapist = therapist;
    }

    public void setLesson(String lesson) {
        this.lesson = lesson;
    }

    public void setFrequency(String frequency) {
        this.frequency = frequency;
    }

    public void setTimes(String times) {
        this.times = times;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public void setIsAbnormal(Boolean isAbnormal) {
        this.isAbnormal = isAbnormal;
    }
    
    @Override
    public String toString() {
        return "TrainingEvent{" +
                "serialno=" + serialno +
                ", name='" + name + '\'' +
                ", gender='" + gender + '\'' +
                ", age='" + age + '\'' +
                ", indication='" + indication + '\'' +
                ", therapCat='" + therapCat + '\'' +
                ", therapist='" + therapist + '\'' +
                ", lesson='" + lesson + '\'' +
                ", frequency='" + frequency + '\'' +
                ", times='" + times + '\'' +
                ", beginDate='" + beginDate + '\'' +
                ", duration='" + duration + '\'' +
                ", isAbnormal=" + isAbnormal +
                '}';
    }

}
