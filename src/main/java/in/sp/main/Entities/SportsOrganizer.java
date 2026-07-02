package in.sp.main.Entities;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

@Entity
public class SportsOrganizer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Basic Info
    private String organizationName;
    private String contactPersonName;
    private String email;
    private String password;
    private String phone;

    // Business Credibility
    private String registrationNumber;   // GST / Company Reg No
    private String gstNumber;
    private int yearsOfExperience;

    @Column(length = 2000)
    private String aboutOrganization;

    // Address
    private String address;
    private String city;
    private String state;
    private String country;
    private String pincode;

    // Sports Info
    private String sportsHandled; // Cricket, Football, Badminton etc (comma separated)
    private int eventsConducted;
    private String corporateClients; // Infosys, TCS etc

    // Verification
    private boolean verified; // Admin approval later

    // Bank / Payment
    private String bankName;
    private String accountNumber;
    private String ifscCode;
    private String upiId;

    // Audit
    private LocalDateTime createdAt;

	/*
	 * @OneToMany(mappedBy = "organizer", cascade = CascadeType.ALL) private
	 * List<SportsService> services;
	 */
    @OneToMany(mappedBy = "organizer", cascade = CascadeType.ALL)
    private List<OrganizerDocument> documents;

    @OneToMany(mappedBy = "organizer", cascade = CascadeType.ALL)
    private List<OrganizerEventPhoto> eventPhotos;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getOrganizationName() {
		return organizationName;
	}

	public void setOrganizationName(String organizationName) {
		this.organizationName = organizationName;
	}

	public String getContactPersonName() {
		return contactPersonName;
	}

	public void setContactPersonName(String contactPersonName) {
		this.contactPersonName = contactPersonName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRegistrationNumber() {
		return registrationNumber;
	}

	public void setRegistrationNumber(String registrationNumber) {
		this.registrationNumber = registrationNumber;
	}

	public String getGstNumber() {
		return gstNumber;
	}

	public void setGstNumber(String gstNumber) {
		this.gstNumber = gstNumber;
	}

	public int getYearsOfExperience() {
		return yearsOfExperience;
	}

	public void setYearsOfExperience(int yearsOfExperience) {
		this.yearsOfExperience = yearsOfExperience;
	}

	public String getAboutOrganization() {
		return aboutOrganization;
	}

	public void setAboutOrganization(String aboutOrganization) {
		this.aboutOrganization = aboutOrganization;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public String getSportsHandled() {
		return sportsHandled;
	}

	public void setSportsHandled(String sportsHandled) {
		this.sportsHandled = sportsHandled;
	}

	public int getEventsConducted() {
		return eventsConducted;
	}

	public void setEventsConducted(int eventsConducted) {
		this.eventsConducted = eventsConducted;
	}

	public String getCorporateClients() {
		return corporateClients;
	}

	public void setCorporateClients(String corporateClients) {
		this.corporateClients = corporateClients;
	}

	public boolean isVerified() {
		return verified;
	}

	public void setVerified(boolean verified) {
		this.verified = verified;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public String getIfscCode() {
		return ifscCode;
	}

	public void setIfscCode(String ifscCode) {
		this.ifscCode = ifscCode;
	}

	public String getUpiId() {
		return upiId;
	}

	public void setUpiId(String upiId) {
		this.upiId = upiId;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	/*
	 * public List<SportsService> getServices() { return services; }
	 * 
	 * public void setServices(List<SportsService> services) { this.services =
	 * services; }
	 */

	public List<OrganizerDocument> getDocuments() {
		return documents;
	}

	public void setDocuments(List<OrganizerDocument> documents) {
		this.documents = documents;
	}

	public List<OrganizerEventPhoto> getEventPhotos() {
		return eventPhotos;
	}

	public void setEventPhotos(List<OrganizerEventPhoto> eventPhotos) {
		this.eventPhotos = eventPhotos;
	}
    
    
    
}
