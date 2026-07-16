import re

with open('src/main/java/in/sp/main/Controllers/TechDashboardController.java', 'r', encoding='utf-8') as f:
    content = f.read()

old_user_search = """        if (search != null && !search.trim().isEmpty()) {
            String q = search.toLowerCase().trim();
            filteredJobSeekers = filteredJobSeekers.stream()
                .filter(u -> u.getName() != null && u.getName().toLowerCase().contains(q))
                .collect(java.util.stream.Collectors.toList());
        }"""

new_user_search = """        if (search != null && !search.trim().isEmpty()) {
            String q = search.toLowerCase().trim();
            filteredJobSeekers = filteredJobSeekers.stream()
                .filter(u -> (u.getName() != null && u.getName().toLowerCase().contains(q)) || 
                             (u.getEmail() != null && u.getEmail().toLowerCase().contains(q)))
                .sorted((u1, u2) -> {
                    String n1 = u1.getName() != null ? u1.getName().toLowerCase() : "";
                    String n2 = u2.getName() != null ? u2.getName().toLowerCase() : "";
                    String e1 = u1.getEmail() != null ? u1.getEmail().toLowerCase() : "";
                    String e2 = u2.getEmail() != null ? u2.getEmail().toLowerCase() : "";
                    
                    boolean exact1 = n1.equals(q) || e1.equals(q);
                    boolean exact2 = n2.equals(q) || e2.equals(q);
                    if (exact1 && !exact2) return -1;
                    if (!exact1 && exact2) return 1;
                    
                    boolean starts1 = n1.startsWith(q) || e1.startsWith(q);
                    boolean starts2 = n2.startsWith(q) || e2.startsWith(q);
                    if (starts1 && !starts2) return -1;
                    if (!starts1 && starts2) return 1;
                    
                    return n1.compareTo(n2);
                })
                .collect(java.util.stream.Collectors.toList());
        }"""
content = content.replace(old_user_search, new_user_search)

old_manage_categories = """    @RequestMapping(value = "/manage-categories", method = RequestMethod.GET)
    public String manageCategories(HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        model.addAttribute("techPerson", techPerson);
        
        model.addAttribute("categories", categoryDAO.findAll());

        return "techperson/manage-categories";
    }"""

new_manage_categories = """    @RequestMapping(value = "/manage-categories", method = RequestMethod.GET)
    public String manageCategories(@RequestParam(required = false) String search, HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        model.addAttribute("techPerson", techPerson);
        
        java.util.List<Category> allCategories = categoryDAO.findAll();
        if (search != null && !search.trim().isEmpty()) {
            String q = search.toLowerCase().trim();
            allCategories = allCategories.stream()
                .filter(c -> c.getName() != null && c.getName().toLowerCase().contains(q))
                .sorted((c1, c2) -> {
                    String n1 = c1.getName() != null ? c1.getName().toLowerCase() : "";
                    String n2 = c2.getName() != null ? c2.getName().toLowerCase() : "";
                    if (n1.equals(q) && !n2.equals(q)) return -1;
                    if (!n1.equals(q) && n2.equals(q)) return 1;
                    if (n1.startsWith(q) && !n2.startsWith(q)) return -1;
                    if (!n1.startsWith(q) && n2.startsWith(q)) return 1;
                    return n1.compareTo(n2);
                })
                .collect(java.util.stream.Collectors.toList());
        }
        
        model.addAttribute("categories", allCategories);
        model.addAttribute("searchQuery", search);

        return "techperson/manage-categories";
    }"""
content = content.replace(old_manage_categories, new_manage_categories)

old_add_category = """    @RequestMapping(value = "/add-category", method = RequestMethod.POST)
    public String addCategory(@RequestParam String name, @RequestParam(required = false) String description, 
                              @RequestParam(required = false, defaultValue = "fas fa-folder") String icon, 
                              @RequestParam(required = false, defaultValue = "#19A77B") String color, 
                              HttpSession session, RedirectAttributes redirectAttributes) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        
        Category category = new Category();
        category.setName(name);
        category.setDescription(description);
        category.setIcon(icon);
        category.setColor(color);
        
        int res = categoryDAO.save(category);
        if (res > 0) {
            redirectAttributes.addFlashAttribute("success", "Category added successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to add category");
        }
        return "redirect:/tech/manage-categories";
    }"""

new_add_category = """    @RequestMapping(value = "/add-category", method = RequestMethod.POST)
    public String addCategory(@RequestParam String name, @RequestParam(required = false) String description, 
                              @RequestParam(required = false, defaultValue = "fas fa-folder") String icon, 
                              @RequestParam(required = false, defaultValue = "#19A77B") String color, 
                              HttpSession session, RedirectAttributes redirectAttributes) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        
        java.util.List<Category> existing = categoryDAO.findAll();
        boolean exists = existing.stream().anyMatch(c -> c.getName() != null && c.getName().equalsIgnoreCase(name.trim()));
        if(exists) {
            redirectAttributes.addFlashAttribute("error", "Category already exists!");
            return "redirect:/tech/manage-categories";
        }
        
        Category category = new Category();
        category.setName(name);
        category.setDescription(description);
        category.setIcon(icon);
        category.setColor(color);
        
        int res = categoryDAO.save(category);
        if (res > 0) {
            redirectAttributes.addFlashAttribute("success", "Category added successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to add category");
        }
        return "redirect:/tech/manage-categories";
    }"""
content = content.replace(old_add_category, new_add_category)

with open('src/main/java/in/sp/main/Controllers/TechDashboardController.java', 'w', encoding='utf-8', newline='') as f:
    f.write(content)

print("Replacement done!")
