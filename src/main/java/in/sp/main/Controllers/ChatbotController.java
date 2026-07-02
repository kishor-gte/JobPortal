package in.sp.main.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import in.sp.main.Services.ChatbotService;

@RestController
public class ChatbotController {

    @Autowired
    private ChatbotService chatbotService;

    @RequestMapping(value = "/chatbot", method = RequestMethod.POST)
    public String chatbot(@RequestParam String message) {
        return chatbotService.getReply(message);
    }
}
