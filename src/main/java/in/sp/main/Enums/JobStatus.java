package in.sp.main.Enums;



public enum JobStatus {
    OPEN("Open"),
    CLOSED("Closed");

    private final String displayName;

    JobStatus(String displayName) {
        this.displayName = displayName;
    }

    @Override
    public String toString() {
        return displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
