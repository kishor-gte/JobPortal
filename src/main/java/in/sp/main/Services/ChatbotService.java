package in.sp.main.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.ChatbotResponse;
import in.sp.main.Repositories.ChatbotRepository;

@Service
public class ChatbotService {

    @Autowired
    private ChatbotRepository repo;

    public String getReply(String message) {

        message = message.toLowerCase();
        List<ChatbotResponse> responses = repo.findAll();

        for (ChatbotResponse r : responses) {
            if (message.contains(r.getKeyword().toLowerCase())) {
                return r.getResponse();
            }
        }

        return "Sorry, I didn’t understand. Please check Help section.";
    }
}
