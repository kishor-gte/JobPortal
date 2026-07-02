package com.example.demo.controller;

import com.example.demo.dao.ChatMessageDAO;
import com.example.demo.dao.UserDAO;
import com.example.demo.model.ChatMessage;
import com.example.demo.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private ChatMessageDAO chatMessageDAO;

    @Autowired
    private UserDAO userDAO;

    private User getLoggedInUser(HttpSession session) {
        return (User) session.getAttribute("loggedInUser");
    }

    @GetMapping
    public String chatIndex(HttpSession session, Model model) {
        User user = getLoggedInUser(session);
        if (user == null) {
            return "redirect:/login";
        }

        // Interveiwers see students, students see interviewers
        List<User> contacts;
        if ("STUDENT".equals(user.getRole())) {
            contacts = userDAO.findByRole("INTERVIEWER");
        } else if ("INTERVIEWER".equals(user.getRole())) {
            contacts = userDAO.findByRole("STUDENT");
        } else {
            // ADMIN can see both for testing/support if needed, but let's restrict to INTERVIEWER
            contacts = userDAO.findByRole("INTERVIEWER");
            contacts.addAll(userDAO.findByRole("STUDENT"));
            // filter out self
            contacts = contacts.stream().filter(u -> !u.getId().equals(user.getId())).collect(Collectors.toList());
        }

        model.addAttribute("user", user);
        model.addAttribute("contacts", contacts);
        model.addAttribute("selectedPartnerId", null);
        return "chat";
    }

    @GetMapping("/{partnerId}")
    public String viewChat(@PathVariable Long partnerId, HttpSession session, Model model) {
        User user = getLoggedInUser(session);
        if (user == null) {
            return "redirect:/login";
        }

        List<User> contacts;
        if ("STUDENT".equals(user.getRole())) {
            contacts = userDAO.findByRole("INTERVIEWER");
        } else if ("INTERVIEWER".equals(user.getRole())) {
            contacts = userDAO.findByRole("STUDENT");
        } else {
            contacts = userDAO.findByRole("INTERVIEWER");
            contacts.addAll(userDAO.findByRole("STUDENT"));
            contacts = contacts.stream().filter(u -> !u.getId().equals(user.getId())).collect(Collectors.toList());
        }

        User partner = userDAO.findById(partnerId);
        if (partner == null) {
            return "redirect:/chat";
        }

        // Mark messages as read
        chatMessageDAO.markAsRead(partnerId, user.getId());

        List<ChatMessage> messages = chatMessageDAO.getConversation(user.getId(), partnerId);

        model.addAttribute("user", user);
        model.addAttribute("contacts", contacts);
        model.addAttribute("partner", partner);
        model.addAttribute("selectedPartnerId", partnerId);
        model.addAttribute("messages", messages);
        return "chat";
    }

    @PostMapping("/send")
    public String sendMessage(@RequestParam Long receiverId, @RequestParam String content,
                              HttpSession session, RedirectAttributes redirectAttributes) {
        User user = getLoggedInUser(session);
        if (user == null) {
            return "redirect:/login";
        }

        if (content != null && !content.trim().isEmpty()) {
            ChatMessage msg = new ChatMessage();
            msg.setSenderId(user.getId());
            msg.setReceiverId(receiverId);
            msg.setContent(content.trim());
            chatMessageDAO.save(msg);
        }

        return "redirect:/chat/" + receiverId;
    }
}
