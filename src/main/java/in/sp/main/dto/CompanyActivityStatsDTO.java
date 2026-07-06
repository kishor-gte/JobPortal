package in.sp.main.dto;

public class CompanyActivityStatsDTO {
    private long totalViews;
    private long totalApplications;
    private long totalSaved;
    private long totalWithdrawn;
    private long todayActivities;
    private long thisWeekActivities;

    public CompanyActivityStatsDTO() {
    }

    public CompanyActivityStatsDTO(long totalViews, long totalApplications, long totalSaved, long totalWithdrawn, long todayActivities, long thisWeekActivities) {
        this.totalViews = totalViews;
        this.totalApplications = totalApplications;
        this.totalSaved = totalSaved;
        this.totalWithdrawn = totalWithdrawn;
        this.todayActivities = todayActivities;
        this.thisWeekActivities = thisWeekActivities;
    }

    public long getTotalViews() {
        return totalViews;
    }

    public void setTotalViews(long totalViews) {
        this.totalViews = totalViews;
    }

    public long getTotalApplications() {
        return totalApplications;
    }

    public void setTotalApplications(long totalApplications) {
        this.totalApplications = totalApplications;
    }

    public long getTotalSaved() {
        return totalSaved;
    }

    public void setTotalSaved(long totalSaved) {
        this.totalSaved = totalSaved;
    }

    public long getTotalWithdrawn() {
        return totalWithdrawn;
    }

    public void setTotalWithdrawn(long totalWithdrawn) {
        this.totalWithdrawn = totalWithdrawn;
    }

    public long getTodayActivities() {
        return todayActivities;
    }

    public void setTodayActivities(long todayActivities) {
        this.todayActivities = todayActivities;
    }

    public long getThisWeekActivities() {
        return thisWeekActivities;
    }

    public void setThisWeekActivities(long thisWeekActivities) {
        this.thisWeekActivities = thisWeekActivities;
    }
}
