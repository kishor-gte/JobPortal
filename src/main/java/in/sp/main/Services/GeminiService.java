package in.sp.main.Services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class GeminiService {

    @Value("${gemini.api.key:}")
    private String geminiApiKey;

    @Autowired
    @Qualifier("geminiRestTemplate")
    private RestTemplate restTemplate;

    public String generateContent(String prompt) throws Exception {
        if (geminiApiKey == null || geminiApiKey.isEmpty() || geminiApiKey.equals("YOUR_API_KEY_HERE")) {
            throw new Exception("Gemini API key is not configured in application properties.");
        }

        Map<String, Object> geminiRequest = new HashMap<>();
        List<Map<String, Object>> contents = new ArrayList<>();
        Map<String, Object> content = new HashMap<>();
        List<Map<String, Object>> parts = new ArrayList<>();
        Map<String, Object> textPart = new HashMap<>();
        
        textPart.put("text", prompt);
        parts.add(textPart);
        content.put("parts", parts);
        contents.add(content);
        geminiRequest.put("contents", contents);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String url;
        if (geminiApiKey.startsWith("AIza")) {
            url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + geminiApiKey;
        } else {
            url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";
            headers.setBearerAuth(geminiApiKey);
        }

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(geminiRequest, headers);

        
        ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);
        Map<String, Object> responseBody = response.getBody();
        
        String aiResponseText = "";
        try {
            List<Map<String, Object>> candidates = (List<Map<String, Object>>) responseBody.get("candidates");
            if (candidates != null && !candidates.isEmpty()) {
                Map<String, Object> cand = candidates.get(0);
                Map<String, Object> resContent = (Map<String, Object>) cand.get("content");
                List<Map<String, Object>> resParts = (List<Map<String, Object>>) resContent.get("parts");
                if (resParts != null && !resParts.isEmpty()) {
                    aiResponseText = (String) resParts.get(0).get("text");
                }
            }
        } catch (Exception e) {
            throw new Exception("Failed to parse the JSON structure of the Gemini API response.", e);
        }

        if (aiResponseText.isEmpty()) {
            throw new Exception("Received an empty text response from the AI.");
        }

        return aiResponseText;
    }
}
