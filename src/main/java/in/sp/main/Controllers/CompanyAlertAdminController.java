package in.sp.main.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import in.sp.main.Entities.CompanyAlert;
import in.sp.main.Services.CompanyAlertCommentService;
import in.sp.main.Services.CompanyAlertService;

@Controller
@RequestMapping("/admin/alerts")
public class CompanyAlertAdminController {

    private final CompanyAlertService service;
    private final CompanyAlertCommentService commentService;

    public CompanyAlertAdminController(CompanyAlertService service,
                                       CompanyAlertCommentService commentService) {
        this.service = service;
        this.commentService = commentService;
    }

    // LIST
    @RequestMapping(method = RequestMethod.GET)
    public String adminAlertList(Model model) {
        model.addAttribute("alerts", service.getAllAlertsForAdmin());
        return "admin/admin-company-report-alerts";
    }

    // DETAIL
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String adminAlertDetail(@PathVariable Long id, Model model) {

        CompanyAlert alert = service.getAlertById(id)
                .orElseThrow(() -> new RuntimeException("Alert not found"));

        model.addAttribute("alert", alert);
        model.addAttribute("adminReplies", commentService.getAdminComments(id));
        model.addAttribute("comments", commentService.getUserComments(id));

        return "admin/admin-company-alert-detail";
    }

    // DELETE
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
    public String deleteAlert(@PathVariable Long id) {
        service.deleteAlert(id);
        return "redirect:/admin/alerts";
    }

    // ADMIN COMMENT
    @RequestMapping(value = "/{id}/comment", method = RequestMethod.POST)
    public String adminComment(@PathVariable Long id,
                               @RequestParam("commentText") String commentText) {

        CompanyAlert alert = service.getAlertById(id)
                .orElseThrow(() -> new RuntimeException("Alert not found"));

        commentService.saveAdminComment(alert, commentText);
        return "redirect:/admin/alerts/" + id;
    }
}
