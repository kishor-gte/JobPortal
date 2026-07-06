package in.sp.main.Controllers;

import in.sp.main.Entities.Company;
import in.sp.main.Entities.TechPerson;
import in.sp.main.Services.CompanyServices;
import in.sp.main.Services.TechPersonServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/techperson")
public class TechPersonController {

    @Autowired
    private TechPersonServices techPersonServices;

    @Autowired
    private CompanyServices companyService;

    @RequestMapping(value = "/register/{companyId}", method = RequestMethod.GET)
    public String showRegistrationForm(@PathVariable Long companyId, Model model) {
        Company company = companyService.getCompany(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found"));
        model.addAttribute("company", company);
        return "techperson/registerTechPerson";
    }

    @RequestMapping(value = "/register1/{companyId}", method = RequestMethod.POST)
    public String registerTechPerson(@ModelAttribute TechPerson techperson,
            @RequestParam Long companyId,
            RedirectAttributes redirectAttributes) {
        Company company = companyService.getCompany(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found"));
        if (!company.isVerified()) {
            redirectAttributes.addFlashAttribute("error", "Company not yet approved.");
            return "redirect:/techperson/register/" + companyId;
        }
        techperson.setCompany(company);
        techPersonServices.createTechPerson(techperson);
        redirectAttributes.addFlashAttribute("message", "Tech Person registered successfully!");
        return "redirect:/techperson/list";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listTechPersons(Model model, HttpSession session) {
        Company company = (Company) session.getAttribute("loggedInCompany");
        if (company != null) {
            List<TechPerson> techpersons = techPersonServices.getTechPersonsByCompany(company.getId());
            model.addAttribute("techpersons", techpersons);
            model.addAttribute("company", company);
        } else {
            return "redirect:/company/login";
        }
        return "techperson/techPersonList";
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String deleteTechPerson(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        TechPerson techperson = techPersonServices.findTechPersonById(id);
        if (techperson == null) {
            redirectAttributes.addFlashAttribute("error", "Tech Person not found.");
            return "redirect:/techperson/list";
        }
        techPersonServices.deleteTechPerson(id);
        redirectAttributes.addFlashAttribute("message", "Tech Person deleted successfully.");
        return "redirect:/techperson/list";
    }
}
