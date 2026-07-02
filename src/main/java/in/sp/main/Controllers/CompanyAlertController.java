package in.sp.main.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import in.sp.main.Entities.CompanyAlert;
import in.sp.main.Entities.CompanyAlertComment;
import in.sp.main.Services.CompanyAlertCommentService;
import in.sp.main.Services.CompanyAlertService;

@Controller
@RequestMapping("/alerts")
public class CompanyAlertController {

    private final CompanyAlertService service;
    
    @Autowired
    private CompanyAlertCommentService commentService;


    public CompanyAlertController(CompanyAlertService service) {
        this.service = service;
    }

    // ================= USER SIDE =================

    // Show alert form
    @RequestMapping(value = "/report", method = RequestMethod.GET)
    public String showReportForm(Model model) {
        model.addAttribute("alert", new CompanyAlert());
        return "company/report-company";
    }

    // Save alert
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String saveAlert(@ModelAttribute("alert") CompanyAlert alert) {
        service.saveAlert(alert);
        return "redirect:/alerts/list";
    }

    // View alerts
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String viewAlerts(Model model) {
        model.addAttribute("alerts", service.getVisibleAlerts());
        return "company/report-list";
    }

    // ================= ADMIN SIDE =================

    // Admin view all alerts
    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String adminAlertList(Model model) {
        model.addAttribute("alerts", service.getAllAlertsForAdmin());
        return "admin-company-report-alerts";
    }

    // Verify alert
    @RequestMapping(value = "/admin/verify/{id}", method = RequestMethod.POST)
    public String verifyAlert(@PathVariable Long id) {
        service.verifyAlert(id);
        return "redirect:/alerts/admin";
    }

    // Hide alert
    @RequestMapping(value = "/admin/hide/{id}", method = RequestMethod.POST)
    public String hideAlert(@PathVariable Long id) {
        service.hideAlert(id);
        return "redirect:/alerts/admin";
    }
    
	/*
	 * @GetMapping("/{id}") public String viewAlertDetail(@PathVariable Long id,
	 * Model model) {
	 * 
	 * CompanyAlert alert = service.getVisibleAlertById(id) .orElseThrow(() -> new
	 * RuntimeException("Alert not found"));
	 * 
	 * model.addAttribute("alert", alert); return "company/company-alert-detail"; }
	 */

 // Agree / Same experience
    @RequestMapping(value = "/{id}/agree", method = RequestMethod.POST)
    @ResponseBody
    public String agreeWithReport(@PathVariable Long id) {
        service.agreeWithReport(id);
        return "OK";
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String viewAlertDetail(@PathVariable Long id, Model model) {

        CompanyAlert alert = service.getVisibleAlertById(id)
                .orElseThrow(() -> new RuntimeException("Alert not found"));

        model.addAttribute("alert", alert);
        model.addAttribute("comments", commentService.getComments(id));
        model.addAttribute("newComment", new CompanyAlertComment());

        return "company/company-alert-detail";
    }

    @RequestMapping(value = "/{id}/comment", method = RequestMethod.POST)
    public String addComment(
            @PathVariable Long id,
            @RequestParam("commentText") String commentText,
            @RequestParam(value = "commenterName", required = false) String commenterName,
            @RequestParam(value = "commenterEmail", required = false) String commenterEmail) {

        CompanyAlert alert = service.getVisibleAlertById(id)
                .orElseThrow(() -> new RuntimeException("Alert not found"));

        CompanyAlertComment comment = new CompanyAlertComment();
        comment.setAlert(alert);
        comment.setCommentText(commentText);
        comment.setCommenterName(commenterName);
        comment.setCommenterEmail(commenterEmail);
        // DO NOT SET ID
        // DO NOT SET commentedAt (auto)

        commentService.save(comment);

        return "redirect:/alerts/" + id;
    }



}
