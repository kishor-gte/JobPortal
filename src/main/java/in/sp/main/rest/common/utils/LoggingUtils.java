package in.sp.main.rest.common.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggingUtils {
    
    private static final Logger logger = LoggerFactory.getLogger(LoggingUtils.class);

    public static void logApiCall(String endpoint, String method, String userId) {
        logger.info("API Called: {} {} by User ID: {}", method, endpoint, userId != null ? userId : "Anonymous");
    }

    public static void logApiError(String endpoint, Exception ex) {
        logger.error("API Error at {}: {}", endpoint, ex.getMessage(), ex);
    }
}
