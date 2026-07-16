package in.sp.main.Services;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import in.sp.main.dto.ResumeAnalysisResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AtsScoreService {

    @Autowired
    private GeminiService geminiService;

    public ResumeAnalysisResponse analyzeResume(String resumeText) {
        ResumeAnalysisResponse response = new ResumeAnalysisResponse();
        
        if (resumeText == null || resumeText.trim().isEmpty()) {
            response.setSuccess(false);
            response.setErrorMessage("Could not extract text from the resume. The file may be empty or an image-based PDF.");
            return response;
        }

        // Truncate text if it's overly long to avoid token limits
        if (resumeText.length() > 25000) {
            resumeText = resumeText.substring(0, 25000);
        }

        String prompt = "You are an expert ATS (Applicant Tracking System) software and technical recruiter. " +
                "Analyze the following resume text and provide an ATS score out of 100 based on standard criteria (keyword optimization, formatting, clarity, quantifiable achievements). " +
                "Also provide brief, actionable feedback in 2-3 sentences on how to improve the resume. " +
                "IMPORTANT: You MUST respond ONLY with a valid JSON object matching this exact structure: {\"score\": 85, \"feedback\": \"Your feedback here.\"} " +
                "Do not wrap it in markdown block quotes. Resume Text: \n" + resumeText;

        try {
            String aiResponseText = geminiService.generateContent(prompt);
            
            // Clean response (sometimes it has markdown code block like ```json ... ```)
            aiResponseText = aiResponseText.replaceAll("(?s)^```json\\s*", "").replaceAll("(?s)\\s*```$", "").trim();

            JsonObject jsonResponse = new Gson().fromJson(aiResponseText, JsonObject.class);
            int score = jsonResponse.has("score") ? jsonResponse.get("score").getAsInt() : 0;
            String feedback = jsonResponse.has("feedback") ? jsonResponse.get("feedback").getAsString() : "No feedback provided.";

            response.setScore(score);
            response.setFeedback(feedback);
            response.setSuccess(true);
        } catch (Exception e) {
            // Log a clean one-line message to keep the console clean when falling back
            System.out.println("[ATS Analyzer] Live Gemini AI API is currently offline or restricted. Using local rules-based analyzer instead.");
            response = generateFallbackAnalysis(resumeText);
        }

        return response;
    }

    private ResumeAnalysisResponse generateFallbackAnalysis(String resumeText) {
        ResumeAnalysisResponse response = new ResumeAnalysisResponse();
        int score = 65; // Base score
        java.util.List<String> feedbackItems = new java.util.ArrayList<>();
        
        String lowerText = resumeText.toLowerCase();
        
        // Check for sections
        boolean hasSkills = lowerText.contains("skills") || lowerText.contains("technologies");
        boolean hasEducation = lowerText.contains("education") || lowerText.contains("university") || lowerText.contains("college");
        boolean hasExperience = lowerText.contains("experience") || lowerText.contains("work") || lowerText.contains("employment");
        boolean hasProjects = lowerText.contains("projects");
        
        if (hasSkills) {
            score += 10;
        } else {
            feedbackItems.add("Add a dedicated 'Skills' section listing your technical capabilities.");
        }
        
        if (hasEducation) {
            score += 10;
        } else {
            feedbackItems.add("Ensure your academic background and 'Education' section is clearly visible.");
        }
        
        if (hasExperience) {
            score += 10;
        } else {
            feedbackItems.add("Include a detailed 'Work Experience' section with your previous roles.");
        }
        
        if (hasProjects) {
            score += 5;
        } else {
            feedbackItems.add("Consider adding a 'Projects' section to showcase practical applications of your skills.");
        }
        
        // Check for contact details
        boolean hasEmail = lowerText.contains("@") && (lowerText.contains(".com") || lowerText.contains(".org") || lowerText.contains(".edu") || lowerText.contains(".in"));
        if (hasEmail) {
            score += 5;
        } else {
            feedbackItems.add("Make sure your contact email is clearly listed at the top of the resume.");
        }
        
        // Word count analysis
        String[] words = resumeText.split("\\s+");
        if (words.length < 200) {
            score -= 10;
            feedbackItems.add("Your resume seems very short. Expand on your descriptions and details.");
        } else if (words.length > 800) {
            score -= 5;
            feedbackItems.add("Your resume is quite long. Try to keep it concise and under 2 pages.");
        }
        
        // Cap score
        if (score > 100) score = 100;
        if (score < 0) score = 0;
        
        String feedback;
        if (feedbackItems.isEmpty()) {
            feedback = "Excellent resume! It is well-structured, covers all essential sections, and has a good length. Focus on tailoring it to specific job descriptions.";
        } else {
            feedback = "Your resume has a solid base. To improve: " + String.join(" ", feedbackItems.subList(0, Math.min(2, feedbackItems.size())));
        }
        
        response.setScore(score);
        response.setFeedback(feedback + " (Analyzed locally)");
        response.setSuccess(true);
        return response;
    }
}
