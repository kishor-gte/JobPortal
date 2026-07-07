package in.sp.main.Entities;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import in.sp.main.Enums.ServiceStatus;
import jakarta.persistence.*;

@Entity
@Table(name = "sports_services")
public class SportsService {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /* ================= BASIC ================= */
    @Column(nullable = false)
    private String serviceTitle;

    @Column(nullable = false)
    private String sportType;


    @Lob
    @Column(columnDefinition = "LONGTEXT")
    private String description;

    /* ================= PRICING ================= */
    private double basePrice;
    private Double taxPercent;
    private Double refundableDeposit;
    private String pricingUnit;

    private Integer advancePaymentPercent; // A
    private Integer minimumBookingNoticeHours; // A

    /* ================= CAPACITY ================= */
    private int durationInHours;
    private int maxParticipants;

    private Integer recommendedTeamSizeMin; // C
    private Integer recommendedTeamSizeMax; // C
    private String experienceLevel; // BEGINNER / INTERMEDIATE / PROFESSIONAL

    /* ================= INCLUSIONS ================= */
    private boolean refereeIncluded;
    private boolean equipmentIncluded;
    private boolean groundIncluded;
    private boolean medicalSupport;

    @Lob @Column(columnDefinition = "TEXT")
    private String otherInclusions;

    /* ================= CUSTOMIZATION ================= */
    private boolean customizable;

    @Lob @Column(columnDefinition = "TEXT")
    private String customizationOptions;

    /* ================= LOCATION ================= */
    private String city;
    private String venueName;

    @Lob @Column(columnDefinition = "TEXT")
    private String venueAddress;

    private String googleMapUrl;

    /* ================= MEDIA ================= */
    private String coverImageUrl;

    @ElementCollection
    private List<String> galleryImageUrls = new ArrayList<>();

    /* ================= RULES & LEGAL ================= */
    @Lob @Column(columnDefinition = "TEXT")
    private String rulesAndGuidelines;

    @Lob @Column(columnDefinition = "TEXT")
    private String requirementsFromClient;

    @Lob @Column(columnDefinition = "TEXT")
    private String termsAndConditions; // F

    @Lob @Column(columnDefinition = "TEXT")
    private String liabilityDisclaimer; // F

    /* ================= SAFETY & BACKUP ================= */
    private boolean insuranceCovered; // B

    @Lob @Column(columnDefinition = "TEXT")
    private String insuranceDetails; // B

    @Lob @Column(columnDefinition = "TEXT")
    private String safetyStandardsFollowed; // B

    private boolean weatherBackupAvailable; // A
    private boolean backupVenueAvailable; // A

    /* ================= AVAILABILITY ================= */
    private boolean availableOnWeekdays;
    private boolean availableOnWeekends;

    private LocalTime availableFrom;
    private LocalTime availableTo;

    private Integer maxBookingsPerDay; // E
    private boolean allowsMultipleTeams; // E

    /* ================= ADMIN CONTROLS ================= */
    @Lob @Column(columnDefinition = "TEXT")
    private String internalNotes; // D

    private Integer priorityScore; // D
    private boolean featured; // D

    @Enumerated(EnumType.STRING)
    private ServiceStatus status = ServiceStatus.ACTIVE;


	// Getters and Setters

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getServiceTitle() {
		return serviceTitle;
	}

	public void setServiceTitle(String serviceTitle) {
		this.serviceTitle = serviceTitle;
	}

	public String getSportType() {
		return sportType;
	}

	public void setSportType(String sportType) {
		this.sportType = sportType;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getBasePrice() {
		return basePrice;
	}

	public void setBasePrice(double basePrice) {
		this.basePrice = basePrice;
	}

	public Double getTaxPercent() {
		return taxPercent;
	}

	public void setTaxPercent(Double taxPercent) {
		this.taxPercent = taxPercent;
	}

	public Double getRefundableDeposit() {
		return refundableDeposit;
	}

	public void setRefundableDeposit(Double refundableDeposit) {
		this.refundableDeposit = refundableDeposit;
	}

	public String getPricingUnit() {
		return pricingUnit;
	}

	public void setPricingUnit(String pricingUnit) {
		this.pricingUnit = pricingUnit;
	}

	public int getDurationInHours() {
		return durationInHours;
	}

	public void setDurationInHours(int durationInHours) {
		this.durationInHours = durationInHours;
	}

	public int getMaxParticipants() {
		return maxParticipants;
	}

	public void setMaxParticipants(int maxParticipants) {
		this.maxParticipants = maxParticipants;
	}

	public boolean isRefereeIncluded() {
		return refereeIncluded;
	}

	public void setRefereeIncluded(boolean refereeIncluded) {
		this.refereeIncluded = refereeIncluded;
	}

	public boolean isEquipmentIncluded() {
		return equipmentIncluded;
	}

	public void setEquipmentIncluded(boolean equipmentIncluded) {
		this.equipmentIncluded = equipmentIncluded;
	}

	public boolean isGroundIncluded() {
		return groundIncluded;
	}

	public void setGroundIncluded(boolean groundIncluded) {
		this.groundIncluded = groundIncluded;
	}

	public boolean isMedicalSupport() {
		return medicalSupport;
	}

	public void setMedicalSupport(boolean medicalSupport) {
		this.medicalSupport = medicalSupport;
	}

	public String getOtherInclusions() {
		return otherInclusions;
	}

	public void setOtherInclusions(String otherInclusions) {
		this.otherInclusions = otherInclusions;
	}

	public boolean isCustomizable() {
		return customizable;
	}

	public void setCustomizable(boolean customizable) {
		this.customizable = customizable;
	}

	public String getCustomizationOptions() {
		return customizationOptions;
	}

	public void setCustomizationOptions(String customizationOptions) {
		this.customizationOptions = customizationOptions;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getVenueName() {
		return venueName;
	}

	public void setVenueName(String venueName) {
		this.venueName = venueName;
	}

	public String getVenueAddress() {
		return venueAddress;
	}

	public void setVenueAddress(String venueAddress) {
		this.venueAddress = venueAddress;
	}

	public String getGoogleMapUrl() {
		return googleMapUrl;
	}

	public void setGoogleMapUrl(String googleMapUrl) {
		this.googleMapUrl = googleMapUrl;
	}

	public String getCoverImageUrl() {
		if (coverImageUrl != null && !coverImageUrl.isEmpty() && !coverImageUrl.startsWith("/") && !coverImageUrl.startsWith("http")) {
			return "/" + coverImageUrl;
		}
		return coverImageUrl;
	}

	public void setCoverImageUrl(String coverImageUrl) {
		this.coverImageUrl = coverImageUrl;
	}

	public List<String> getGalleryImageUrls() {
		if (galleryImageUrls != null) {
			java.util.List<String> formattedUrls = new java.util.ArrayList<>();
			for (String url : galleryImageUrls) {
				if (url != null && !url.isEmpty() && !url.startsWith("/") && !url.startsWith("http")) {
					formattedUrls.add("/" + url);
				} else {
					formattedUrls.add(url);
				}
			}
			return formattedUrls;
		}
		return galleryImageUrls;
	}

	public void setGalleryImageUrls(List<String> galleryImageUrls) {
		this.galleryImageUrls = galleryImageUrls;
	}

	public String getRulesAndGuidelines() {
		return rulesAndGuidelines;
	}

	public void setRulesAndGuidelines(String rulesAndGuidelines) {
		this.rulesAndGuidelines = rulesAndGuidelines;
	}

	public String getRequirementsFromClient() {
		return requirementsFromClient;
	}

	public void setRequirementsFromClient(String requirementsFromClient) {
		this.requirementsFromClient = requirementsFromClient;
	}

	public boolean isAvailableOnWeekends() {
		return availableOnWeekends;
	}

	public void setAvailableOnWeekends(boolean availableOnWeekends) {
		this.availableOnWeekends = availableOnWeekends;
	}

	public boolean isAvailableOnWeekdays() {
		return availableOnWeekdays;
	}

	public void setAvailableOnWeekdays(boolean availableOnWeekdays) {
		this.availableOnWeekdays = availableOnWeekdays;
	}

	public LocalTime getAvailableFrom() {
		return availableFrom;
	}

	public void setAvailableFrom(LocalTime availableFrom) {
		this.availableFrom = availableFrom;
	}

	public LocalTime getAvailableTo() {
		return availableTo;
	}

	public void setAvailableTo(LocalTime availableTo) {
		this.availableTo = availableTo;
	}

	public ServiceStatus getStatus() {
		return status;
	}

	public void setStatus(ServiceStatus status) {
		this.status = status;
	}

	public Integer getAdvancePaymentPercent() {
		return advancePaymentPercent;
	}

	public void setAdvancePaymentPercent(Integer advancePaymentPercent) {
		this.advancePaymentPercent = advancePaymentPercent;
	}

	public Integer getMinimumBookingNoticeHours() {
		return minimumBookingNoticeHours;
	}

	public void setMinimumBookingNoticeHours(Integer minimumBookingNoticeHours) {
		this.minimumBookingNoticeHours = minimumBookingNoticeHours;
	}

	public Integer getRecommendedTeamSizeMin() {
		return recommendedTeamSizeMin;
	}

	public void setRecommendedTeamSizeMin(Integer recommendedTeamSizeMin) {
		this.recommendedTeamSizeMin = recommendedTeamSizeMin;
	}

	public Integer getRecommendedTeamSizeMax() {
		return recommendedTeamSizeMax;
	}

	public void setRecommendedTeamSizeMax(Integer recommendedTeamSizeMax) {
		this.recommendedTeamSizeMax = recommendedTeamSizeMax;
	}

	public String getExperienceLevel() {
		return experienceLevel;
	}

	public void setExperienceLevel(String experienceLevel) {
		this.experienceLevel = experienceLevel;
	}

	public String getTermsAndConditions() {
		return termsAndConditions;
	}

	public void setTermsAndConditions(String termsAndConditions) {
		this.termsAndConditions = termsAndConditions;
	}

	public String getLiabilityDisclaimer() {
		return liabilityDisclaimer;
	}

	public void setLiabilityDisclaimer(String liabilityDisclaimer) {
		this.liabilityDisclaimer = liabilityDisclaimer;
	}

	public boolean isInsuranceCovered() {
		return insuranceCovered;
	}

	public void setInsuranceCovered(boolean insuranceCovered) {
		this.insuranceCovered = insuranceCovered;
	}

	public String getInsuranceDetails() {
		return insuranceDetails;
	}

	public void setInsuranceDetails(String insuranceDetails) {
		this.insuranceDetails = insuranceDetails;
	}

	public String getSafetyStandardsFollowed() {
		return safetyStandardsFollowed;
	}

	public void setSafetyStandardsFollowed(String safetyStandardsFollowed) {
		this.safetyStandardsFollowed = safetyStandardsFollowed;
	}

	public boolean isWeatherBackupAvailable() {
		return weatherBackupAvailable;
	}

	public void setWeatherBackupAvailable(boolean weatherBackupAvailable) {
		this.weatherBackupAvailable = weatherBackupAvailable;
	}

	public boolean isBackupVenueAvailable() {
		return backupVenueAvailable;
	}

	public void setBackupVenueAvailable(boolean backupVenueAvailable) {
		this.backupVenueAvailable = backupVenueAvailable;
	}

	public Integer getMaxBookingsPerDay() {
		return maxBookingsPerDay;
	}

	public void setMaxBookingsPerDay(Integer maxBookingsPerDay) {
		this.maxBookingsPerDay = maxBookingsPerDay;
	}

	public boolean isAllowsMultipleTeams() {
		return allowsMultipleTeams;
	}

	public void setAllowsMultipleTeams(boolean allowsMultipleTeams) {
		this.allowsMultipleTeams = allowsMultipleTeams;
	}

	public String getInternalNotes() {
		return internalNotes;
	}

	public void setInternalNotes(String internalNotes) {
		this.internalNotes = internalNotes;
	}

	public Integer getPriorityScore() {
		return priorityScore;
	}

	public void setPriorityScore(Integer priorityScore) {
		this.priorityScore = priorityScore;
	}

	public boolean isFeatured() {
		return featured;
	}

	public void setFeatured(boolean featured) {
		this.featured = featured;
	}


}
