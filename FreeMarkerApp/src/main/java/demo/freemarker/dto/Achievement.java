package demo.freemarker.dto;

public class Achievement {
    private String apiname;
    private int achieved;
    private long unlocktime;

    public Achievement() {

    }

    public Achievement(String apiname, int achieved, long unlocktime) {
        this.apiname = apiname;
        this.achieved = achieved;
        this.unlocktime = unlocktime;
    }

    public String getApiname() {
        return apiname;
    }

    public void setApiname(String apiname) {
        this.apiname = apiname;
    }

    public int getAchieved() {
        return achieved;
    }

    public void setAchieved(int achieved) {
        this.achieved = achieved;
    }

    public long getUnlocktime() {
        return unlocktime;
    }

    public void setUnlocktime(long unlocktime) {
        this.unlocktime = unlocktime;
    }

    @Override
    public String toString() {
        return "Achievement{" + "apiname='" + apiname + '\'' + ", achieved=" + achieved + ", unlocktime="
                + unlocktime + '}';
    }
}
