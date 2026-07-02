package in.sp.main.Enums;



public enum EmploymentType {
    FULLTIME("Full Time"),
    PARTTIME("Part Time"),
    INTERNSHIP("Internship"),
    FREELANCE("Freelance");

    private final String displayName;

    EmploymentType(String displayName) {
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
