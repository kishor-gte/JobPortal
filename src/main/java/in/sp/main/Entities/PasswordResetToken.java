package in.sp.main.Entities;

import java.time.LocalDateTime;

import in.sp.main.Enums.UserType;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class PasswordResetToken {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String email;
    private String token;

    @Enumerated(EnumType.STRING)
    private UserType userType;

    private LocalDateTime createdAt;
    private int expirationMinutes;

    public boolean isExpired() {
        return createdAt.plusMinutes(expirationMinutes).isBefore(LocalDateTime.now());
    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public UserType getUserType() {
		return userType;
	}

	public void setUserType(UserType userType) {
		this.userType = userType;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public int getExpirationMinutes() {
		return expirationMinutes;
	}

	public void setExpirationMinutes(int expirationMinutes) {
		this.expirationMinutes = expirationMinutes;
	}

	public PasswordResetToken(String email, String token, UserType userType, int expirationMinutes) {
		this.email = email;
		this.token = token;
		this.userType = userType;
		this.expirationMinutes = expirationMinutes;
		this.createdAt = LocalDateTime.now();
	}
	

	public PasswordResetToken() {
		super();
	}


}

