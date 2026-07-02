package com.example.demo.controller;

import com.example.demo.dao.*;
import com.example.demo.model.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/ai-evaluation")
public class AIEvaluationController {

    @Autowired
    private AIEvaluationDAO aiEvaluationDAO;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private PerformanceDAO performanceDAO;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null)
            return "redirect:/login";

        List<AIEvaluation> evaluations;
        if ("STUDENT".equals(user.getRole())) {
            evaluations = aiEvaluationDAO.findByStudentId(user.getId());
        } else {
            evaluations = aiEvaluationDAO.findAll();
        }

        // Calculate averages
        double avgCommunication = evaluations.stream().mapToDouble(AIEvaluation::getCommunicationScore).average()
                .orElse(0);
        double avgTechnical = evaluations.stream().mapToDouble(AIEvaluation::getTechnicalScore).average().orElse(0);
        double avgConfidence = evaluations.stream().mapToDouble(AIEvaluation::getConfidenceScore).average().orElse(0);
        double avgOverall = evaluations.stream().mapToDouble(AIEvaluation::getOverallScore).average().orElse(0);

        model.addAttribute("user", user);
        model.addAttribute("evaluations", evaluations);
        model.addAttribute("avgCommunication", String.format("%.1f", avgCommunication));
        model.addAttribute("avgTechnical", String.format("%.1f", avgTechnical));
        model.addAttribute("avgConfidence", String.format("%.1f", avgConfidence));
        model.addAttribute("avgOverall", String.format("%.1f", avgOverall));
        model.addAttribute("totalEvaluations", evaluations.size());
        return "ai-evaluation";
    }

    @GetMapping("/detail/{id}")
    public String evaluationDetail(@PathVariable Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null)
            return "redirect:/login";

        AIEvaluation evaluation = aiEvaluationDAO.findById(id);
        if (evaluation == null)
            return "redirect:/ai-evaluation/dashboard";

        model.addAttribute("user", user);
        model.addAttribute("evaluation", evaluation);
        return "ai-evaluation-detail";
    }
}
