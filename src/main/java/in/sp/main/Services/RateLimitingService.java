package in.sp.main.Services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Service to implement rate limiting for various operations like email sending.
 * Prevents abuse and spam by limiting the number of requests per email/IP within a time window.
 */
@Service
public class RateLimitingService {

    private static final Logger logger = LoggerFactory.getLogger(RateLimitingService.class);

    // Rate limit configuration
    private static final int MAX_EMAIL_REQUESTS = 3;  // Max 3 emails per window
    private static final long RATE_LIMIT_WINDOW_MS = 15 * 60 * 1000; // 15 minutes window

    // Store request timestamps per email
    private final Map<String, RequestWindow> emailRequestWindows = new ConcurrentHashMap<>();

    /**
     * Inner class to track requests within a time window
     */
    private static class RequestWindow {
        private final long windowStart;
        private int requestCount;

        RequestWindow(long windowStart) {
            this.windowStart = windowStart;
            this.requestCount = 0;
        }

        boolean isExpired(long currentTime, long windowDurationMs) {
            return (currentTime - windowStart) > windowDurationMs;
        }

        void increment() {
            requestCount++;
        }

        int getRequestCount() {
            return requestCount;
        }
    }

    /**
     * Check if an email request is allowed for the given email address.
     * 
     * @param email the email address to check
     * @return true if the request is allowed, false if rate limited
     */
    public boolean isEmailAllowed(String email) {
        if (email == null || email.isEmpty()) {
            return false;
        }

        long currentTime = Instant.now().toEpochMilli();
        String key = email.toLowerCase().trim();

        RequestWindow window = emailRequestWindows.get(key);

        if (window == null || window.isExpired(currentTime, RATE_LIMIT_WINDOW_MS)) {
            // Create new window
            window = new RequestWindow(currentTime);
            emailRequestWindows.put(key, window);
        }

        if (window.getRequestCount() >= MAX_EMAIL_REQUESTS) {
            logger.warn("Rate limit exceeded for email: {}", email);
            return false;
        }

        window.increment();
        logger.debug("Email request allowed for: {}. Count: {}/{}", 
                     email, window.getRequestCount(), MAX_EMAIL_REQUESTS);
        return true;
    }

    /**
     * Get the number of remaining allowed requests for an email.
     * 
     * @param email the email address to check
     * @return number of remaining requests in the current window
     */
    public int getRemainingRequests(String email) {
        if (email == null || email.isEmpty()) {
            return 0;
        }

        long currentTime = Instant.now().toEpochMilli();
        String key = email.toLowerCase().trim();

        RequestWindow window = emailRequestWindows.get(key);

        if (window == null || window.isExpired(currentTime, RATE_LIMIT_WINDOW_MS)) {
            return MAX_EMAIL_REQUESTS;
        }

        return Math.max(0, MAX_EMAIL_REQUESTS - window.getRequestCount());
    }

    /**
     * Get the time in milliseconds until the rate limit resets for an email.
     * 
     * @param email the email address to check
     * @return milliseconds until reset, or 0 if not rate limited
     */
    public long getTimeUntilReset(String email) {
        if (email == null || email.isEmpty()) {
            return 0;
        }

        long currentTime = Instant.now().toEpochMilli();
        String key = email.toLowerCase().trim();

        RequestWindow window = emailRequestWindows.get(key);

        if (window == null || window.isExpired(currentTime, RATE_LIMIT_WINDOW_MS)) {
            return 0;
        }

        long elapsed = currentTime - window.windowStart;
        return Math.max(0, RATE_LIMIT_WINDOW_MS - elapsed);
    }
}
