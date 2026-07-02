package in.sp.main.Services;

import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Service to track login attempts and implement account lockout
 * Prevents brute force attacks by locking accounts after failed attempts
 */
@Service
public class LoginAttemptService {
    
    private static final int MAX_ATTEMPTS = 5;
    private static final long LOCKOUT_DURATION_MINUTES = 30;
    
    // Track failed login attempts per email
    private final ConcurrentHashMap<String, Integer> attempts = new ConcurrentHashMap<>();
    
    // Track lockout times per email
    private final ConcurrentHashMap<String, LocalDateTime> lockouts = new ConcurrentHashMap<>();
    
    /**
     * Record a failed login attempt
     */
    public void loginFailed(String email) {
        int currentAttempts = attempts.getOrDefault(email, 0);
        attempts.put(email, currentAttempts + 1);
        
        // Lock account if max attempts reached
        if (currentAttempts + 1 >= MAX_ATTEMPTS) {
            lockouts.put(email, LocalDateTime.now());
        }
    }
    
    /**
     * Clear attempts on successful login
     */
    public void loginSucceeded(String email) {
        attempts.remove(email);
        lockouts.remove(email);
    }
    
    /**
     * Check if account is locked
     */
    public boolean isLocked(String email) {
        LocalDateTime lockoutTime = lockouts.get(email);
        if (lockoutTime == null) {
            return false;
        }
        
        // Check if lockout period has expired
        long minutesSinceLockout = java.time.temporal.ChronoUnit.MINUTES.between(
            lockoutTime, LocalDateTime.now());
        
        if (minutesSinceLockout > LOCKOUT_DURATION_MINUTES) {
            // Lockout expired, clear it
            lockouts.remove(email);
            attempts.remove(email);
            return false;
        }
        
        return true;
    }
    
    /**
     * Get remaining attempts
     */
    public int getRemainingAttempts(String email) {
        int currentAttempts = attempts.getOrDefault(email, 0);
        return Math.max(0, MAX_ATTEMPTS - currentAttempts);
    }
    
    /**
     * Get current attempt count
     */
    public int getAttemptCount(String email) {
        return attempts.getOrDefault(email, 0);
    }
    
    /**
     * Manually unlock account (for admin use)
     */
    public void unlockAccount(String email) {
        attempts.remove(email);
        lockouts.remove(email);
    }
    
    /**
     * Get lockout remaining time in minutes
     */
    public long getLockoutRemainingMinutes(String email) {
        LocalDateTime lockoutTime = lockouts.get(email);
        if (lockoutTime == null) {
            return 0;
        }
        
        long minutesSinceLockout = java.time.temporal.ChronoUnit.MINUTES.between(
            lockoutTime, LocalDateTime.now());
        
        return Math.max(0, LOCKOUT_DURATION_MINUTES - minutesSinceLockout);
    }
}
