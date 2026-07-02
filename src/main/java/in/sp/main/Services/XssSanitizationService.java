package in.sp.main.Services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.regex.Pattern;

/**
 * Service to sanitize user input and prevent XSS attacks.
 * Removes or escapes potentially dangerous HTML and JavaScript content.
 */
@Service
public class XssSanitizationService {

    private static final Logger logger = LoggerFactory.getLogger(XssSanitizationService.class);

    // Pattern to match script tags and event handlers
    private static final Pattern SCRIPT_PATTERN = Pattern.compile("<script[^>]*>[\\s\\S]*?</script>", Pattern.CASE_INSENSITIVE);
    private static final Pattern JAVASCRIPT_PROTOCOL = Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE);
    private static final Pattern ON_EVENT_PATTERN = Pattern.compile("\\s(on\\w+)\\s*=\\s*\"[^\"]*\"|\\s(on\\w+)\\s*=\\s*'[^']*'|\\s(on\\w+)\\s*=\\s*[^\\s>]*", Pattern.CASE_INSENSITIVE);
    private static final Pattern IFRAME_PATTERN = Pattern.compile("<iframe[^>]*>[\\s\\S]*?</iframe>", Pattern.CASE_INSENSITIVE);
    private static final Pattern OBJECT_PATTERN = Pattern.compile("<object[^>]*>[\\s\\S]*?</object>", Pattern.CASE_INSENSITIVE);
    private static final Pattern EMBED_PATTERN = Pattern.compile("<embed[^>]*>", Pattern.CASE_INSENSITIVE);
    private static final Pattern FORM_PATTERN = Pattern.compile("<form[^>]*>[\\s\\S]*?</form>", Pattern.CASE_INSENSITIVE);
    private static final Pattern INPUT_PATTERN = Pattern.compile("<input[^>]*>", Pattern.CASE_INSENSITIVE);

    /**
     * Sanitize a string input by removing potentially dangerous HTML/JS content.
     * 
     * @param input the raw user input
     * @return sanitized string safe for display
     */
    public String sanitize(String input) {
        if (input == null || input.isEmpty()) {
            return input;
        }

        String original = input;
        String sanitized = input;

        // Remove script tags
        sanitized = SCRIPT_PATTERN.matcher(sanitized).replaceAll("");
        
        // Remove javascript: protocol
        sanitized = JAVASCRIPT_PROTOCOL.matcher(sanitized).replaceAll("");
        
        // Remove event handlers (onclick, onload, etc.)
        sanitized = ON_EVENT_PATTERN.matcher(sanitized).replaceAll("");
        
        // Remove iframes
        sanitized = IFRAME_PATTERN.matcher(sanitized).replaceAll("");
        
        // Remove objects
        sanitized = OBJECT_PATTERN.matcher(sanitized).replaceAll("");
        
        // Remove embeds
        sanitized = EMBED_PATTERN.matcher(sanitized).replaceAll("");
        
        // Remove forms
        sanitized = FORM_PATTERN.matcher(sanitized).replaceAll("");
        
        // Remove input tags
        sanitized = INPUT_PATTERN.matcher(sanitized).replaceAll("");

        // Escape HTML special characters
        sanitized = escapeHtml(sanitized);

        if (!original.equals(sanitized)) {
            logger.debug("XSS sanitization applied. Original length: {}, Sanitized length: {}", 
                         original.length(), sanitized.length());
        }

        return sanitized;
    }

    /**
     * Escape HTML special characters to prevent XSS.
     * 
     * @param input the input string
     * @return string with HTML special characters escaped
     */
    private String escapeHtml(String input) {
        if (input == null) {
            return null;
        }

        StringBuilder escaped = new StringBuilder();
        for (char c : input.toCharArray()) {
            switch (c) {
                case '<':
                    escaped.append("&lt;");
                    break;
                case '>':
                    escaped.append("&gt;");
                    break;
                case '"':
                    escaped.append("&quot;");
                    break;
                case '\'':
                    escaped.append("&#x27;");
                    break;
                case '&':
                    escaped.append("&amp;");
                    break;
                case '/':
                    escaped.append("&#x2F;");
                    break;
                default:
                    escaped.append(c);
            }
        }
        return escaped.toString();
    }

    /**
     * Sanitize input for use in SQL LIKE clauses (escape special characters).
     * 
     * @param input the search input
     * @return sanitized string for SQL LIKE
     */
    public String sanitizeForSqlLike(String input) {
        if (input == null) {
            return null;
        }
        // Escape SQL LIKE special characters
        return input.replace("%", "\\%")
                   .replace("_", "\\_")
                   .replace("[", "\\[");
    }
}
