package in.sp.main.Enums;

import jakarta.persistence.Transient;

public enum AccountStatus {

    ACTIVE("ACTIVE"),
    DEACTIVATED("DEACTIVATED"),
    BANNED("BANNED"),
    OPEN_TO_WORK("Open to Work"),
    EMPLOYED_OPEN_TO_OPPORTUNITY("Employed but Open"),
    ACTIVELY_APPLYING("Actively Applying"),
    NOT_OPEN_TO_WORK("Not Looking");

    private final String displayName;

    AccountStatus(String displayName) {
        this.displayName = displayName;
    }
    @Transient
    public String getDisplayName() {
        return displayName;
    }
}
