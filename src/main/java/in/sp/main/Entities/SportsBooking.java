package in.sp.main.Entities;

import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;

@Entity
@Table(name = "sports_bookings")
public class SportsBooking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /* ================= WHO BOOKED ================= */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recruiter_id", nullable = false)
    private Recruiter recruiter;

    /* ================= WHAT SERVICE ================= */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "service_id", nullable = false)
    private SportsService service;

    /* ================= EVENT DETAILS ================= */
    private LocalDate eventDate;

    private Integer expectedParticipants;

    private Double finalPrice;

    /* ================= BOOKING STATUS ================= */
    @Column(nullable = false)
    private String status;
    // REQUESTED, PAYMENT_PENDING, CONFIRMED,
    // IN_PROGRESS, COMPLETED, CANCELLED, REFUNDED

    /* ================= AUDIT ================= */
    private LocalDateTime bookedAt;

    private LocalDateTime updatedAt;

    /* ================= CANCELLATION ================= */
    private String cancellationReason;

    private LocalDateTime cancelledAt;


    /* ================= PAYMENT ================= */
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "payment_id")
    private Payment payment;

    
    /* ================= CONVENIENCE ================= */
    @PrePersist
    public void onCreate() {
        this.bookedAt = LocalDateTime.now();
        this.status = "REQUESTED";
    }

    @PreUpdate
    public void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Recruiter getRecruiter() {
		return recruiter;
	}

	public void setRecruiter(Recruiter recruiter) {
		this.recruiter = recruiter;
	}

	public SportsService getService() {
		return service;
	}

	public void setService(SportsService service) {
		this.service = service;
	}

	public LocalDate getEventDate() {
		return eventDate;
	}

	public void setEventDate(LocalDate eventDate) {
		this.eventDate = eventDate;
	}

	public Integer getExpectedParticipants() {
		return expectedParticipants;
	}

	public void setExpectedParticipants(Integer expectedParticipants) {
		this.expectedParticipants = expectedParticipants;
	}

	public Double getFinalPrice() {
		return finalPrice;
	}

	public void setFinalPrice(Double finalPrice) {
		this.finalPrice = finalPrice;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public LocalDateTime getBookedAt() {
		return bookedAt;
	}

	public void setBookedAt(LocalDateTime bookedAt) {
		this.bookedAt = bookedAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getCancellationReason() {
		return cancellationReason;
	}

	public void setCancellationReason(String cancellationReason) {
		this.cancellationReason = cancellationReason;
	}

	public LocalDateTime getCancelledAt() {
		return cancelledAt;
	}

	public void setCancelledAt(LocalDateTime cancelledAt) {
		this.cancelledAt = cancelledAt;
	}

	public Payment getPayment() {
		return payment;
	}

	public void setPayment(Payment payment) {
		this.payment = payment;
	}

    // getters & setters
    
    
}
