package in.sp.main.Controllers;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpEntity;
import org.springframework.http.MediaType;
import org.springframework.http.HttpMethod;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

@RestController
@RequestMapping("/api")
public class ChatController {

    @Value("${gemini.api.key:AIzaSyCr_gUF2YzV16dICNphMfnkyjBFurYLKaM}")
    private String geminiApiKey;

    private static final String GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";

    @PostMapping("/chat")
    public ResponseEntity<?> chat(@RequestBody Map<String, String> request) {
        String userMessage = request.get("message");
        
        if (userMessage == null || userMessage.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("error", "Message is required"));
        }

        try {
            // Check if API key is configured
            if (geminiApiKey == null || geminiApiKey.isEmpty() || geminiApiKey.equals("YOUR_API_KEY_HERE")) {
                // Return fallback response if API key is not configured
                String response = generateFallbackResponse(userMessage);
                return ResponseEntity.ok(Map.of("response", response));
            }

            // Prepare request for Gemini API
            Map<String, Object> geminiRequest = new HashMap<>();
            List<Map<String, Object>> contents = new ArrayList<>();
            
            Map<String, Object> content = new HashMap<>();
            List<Map<String, Object>> parts = new ArrayList<>();
            
            Map<String, Object> textPart = new HashMap<>();
            textPart.put("text", userMessage);
            parts.add(textPart);
            
            content.put("parts", parts);
            contents.add(content);
            
            geminiRequest.put("contents", contents);

            // Set up headers
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            // Create HTTP entity
            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(geminiRequest, headers);

            // Make API call
            RestTemplate restTemplate = new RestTemplate();
            String url = GEMINI_API_URL + "?key=" + geminiApiKey;
            
            ResponseEntity<Map> response = restTemplate.exchange(
                url,
                HttpMethod.POST,
                entity,
                Map.class
            );

            // Extract response
            Map<String, Object> responseBody = response.getBody();
            String botResponse = extractGeminiResponse(responseBody);
            
            return ResponseEntity.ok(Map.of("response", botResponse));
            
        } catch (Exception e) {
            // Return fallback response on error
            String fallbackResponse = generateFallbackResponse(userMessage);
            return ResponseEntity.ok(Map.of("response", fallbackResponse));
        }
    }

    private String extractGeminiResponse(Map<String, Object> responseBody) {
        try {
            if (responseBody != null && responseBody.containsKey("candidates")) {
                List<Map<String, Object>> candidates = (List<Map<String, Object>>) responseBody.get("candidates");
                if (!candidates.isEmpty()) {
                    Map<String, Object> candidate = candidates.get(0);
                    Map<String, Object> content = (Map<String, Object>) candidate.get("content");
                    List<Map<String, Object>> parts = (List<Map<String, Object>>) content.get("parts");
                    if (!parts.isEmpty()) {
                        return (String) parts.get(0).get("text");
                    }
                }
            }
        } catch (Exception e) {
            // Fallback if parsing fails
        }
        return "I'm sorry, I couldn't process your request. Please try again.";
    }

    private String generateFallbackResponse(String message) {
        String lowerMessage = message.toLowerCase();
        
        if (lowerMessage.contains("job") && (lowerMessage.contains("search") || lowerMessage.contains("find") || lowerMessage.contains("browse"))) {
            return "You can browse all available jobs by clicking on 'Browse Jobs' in the JobSeekers menu. We have jobs across various categories including Development, Design, Marketing, and more!";
        }
        
        if (lowerMessage.contains("apply") || lowerMessage.contains("application")) {
            return "To apply for jobs, you need to create your profile first. Click on 'Create/Update Profile' in the JobSeekers menu to get started. Once your profile is complete, you can apply to any job!";
        }
        
        if (lowerMessage.contains("company") && (lowerMessage.contains("register") || lowerMessage.contains("post"))) {
            return "Companies can register by clicking on 'Register Company' under the Employers menu. Once registered and verified, you can post jobs and find the best candidates!";
        }
        
        if (lowerMessage.contains("login") || lowerMessage.contains("sign in")) {
            return "You can login as a JobSeeker, Company, or Recruiter using the login buttons in the navigation menu. If you don't have an account, please register first.";
        }
        
        if (lowerMessage.contains("profile") || lowerMessage.contains("resume") || lowerMessage.contains("cv")) {
            return "Create or update your profile by clicking 'Create/Update Profile' in the JobSeekers menu. You can also upload a video resume to stand out to employers!";
        }
        
        if (lowerMessage.contains("contact") || lowerMessage.contains("support") || lowerMessage.contains("help")) {
            return "For support, you can: 1) Use the WhatsApp button at the bottom right, 2) Email us at support@jobu.com, or 3) Check our FAQ section in the footer.";
        }
        
        if (lowerMessage.contains("badge") || lowerMessage.contains("assessment") || lowerMessage.contains("skill")) {
            return "Earn skill badges by completing assessments! Click on 'Your Badges' under the JobSeekers menu to view available assessments and your earned badges.";
        }
        
        if (lowerMessage.contains("interview") || lowerMessage.contains("mock")) {
            return "We offer mock interview features and AI-powered evaluations. Check the 'Assessments' section to practice and improve your interview skills!";
        }
        
        if (lowerMessage.contains("video") && lowerMessage.contains("resume")) {
            return "Upload your video resume by clicking 'Upload Video Resume' in the JobSeekers menu. Video resumes help you showcase your personality and communication skills!";
        }
        
        if (lowerMessage.contains("qna") || lowerMessage.contains("question")) {
            return "Visit our Q&A section by clicking 'Ask or View Questions' in the JobSeekers menu. You can ask career-related questions or help others by answering!";
        }
        
        // Default response
        return "I'm here to help with your job search and recruitment needs! I can assist with:\n\n" +
               "• Finding and browsing jobs\n" +
               "• Creating/updating your profile\n" +
               "• Company registration\n" +
               "• Skill assessments and badges\n" +
               "• Interview preparation\n" +
               "• General support\n\n" +
               "What would you like to know more about?";
    }
}
