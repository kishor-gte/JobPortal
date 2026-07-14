import java.nio.file.Files;
import java.nio.file.Paths;

public class Modifier {
    public static void main(String[] args) throws Exception {
        String path = "c:/Users/NEHA/OneDrive/Desktop/jp/JobPortal/src/main/webapp/views/techperson/profile.jsp";
        String content = new String(Files.readAllBytes(Paths.get(path)), "UTF-8");

        String styleReplace = "        body.light-mode .btn-logout {\\n" +
                              "            background: rgba(239, 68, 68, 0.05) !important;\\n" +
                              "            border-color: rgba(239, 68, 68, 0.2) !important;\\n" +
                              "            color: #ef4444 !important;\\n" +
                              "        }\\n" +
                              "    </style>";

        String styleReplacement = "        body.light-mode .btn-logout {\\n" +
                              "            background: rgba(239, 68, 68, 0.05) !important;\\n" +
                              "            border-color: rgba(239, 68, 68, 0.2) !important;\\n" +
                              "            color: #ef4444 !important;\\n" +
                              "        }\\n" +
                              "        /* Profile Styles */\\n" +
                              "        .profile-card { background: rgba(255, 255, 255, 0.95); border: 1px solid var(--border-color); border-radius: var(--radius-lg); padding: 30px; backdrop-filter: blur(20px); max-width: 800px; margin: 0 auto; }\\n" +
                              "        .form-group { margin-bottom: 20px; }\\n" +
                              "        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #fff; }\\n" +
                              "        .form-control { width: 100%; padding: 12px 16px; border: 1px solid var(--border-color); border-radius: 12px; font-family: 'Inter', sans-serif; font-size: 15px; transition: var(--transition); background: rgba(0,0,0,0.2); color: #fff; }\\n" +
                              "        .form-control:focus { outline: none; border-color: var(--primary); box-shadow: 0 0 0 3px rgba(25, 167, 123, 0.1); background: rgba(0,0,0,0.4); }\\n" +
                              "        .form-control:disabled { background: rgba(255,255,255,0.05); color: rgba(255,255,255,0.5); cursor: not-allowed; border-color: transparent; }\\n" +
                              "        .btn-edit, .btn-save { padding: 12px 24px; border: none; border-radius: 12px; font-weight: 600; font-size: 15px; cursor: pointer; transition: var(--transition); display: inline-flex; align-items: center; gap: 8px; box-shadow: var(--shadow-sm); color: white; }\\n" +
                              "        .btn-edit { background: var(--gradient-primary); }\\n" +
                              "        .btn-save { background: #10b981; display: none; }\\n" +
                              "        .btn-edit:hover, .btn-save:hover { transform: translateY(-2px); box-shadow: var(--shadow-md); }\\n" +
                              "        .profile-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; border-bottom: 1px solid var(--border-color); padding-bottom: 20px; }\\n" +
                              "        .profile-title { font-size: 24px; font-weight: 700; color: #fff; display: flex; align-items: center; gap: 12px; }\\n" +
                              "        body.light-mode .profile-card { background: #ffffff; border-color: #e2e8f0; }\\n" +
                              "        body.light-mode .form-group label { color: #1e293b; }\\n" +
                              "        body.light-mode .profile-title { color: #0f172a; }\\n" +
                              "        body.light-mode .form-control { border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b; }\\n" +
                              "        body.light-mode .form-control:focus { background: #fff; }\\n" +
                              "        body.light-mode .form-control:disabled { background: #f1f5f9; color: #64748b; }\\n" +
                              "    </style>";

        // Normalize line endings for replacement
        content = content.replace("\\r\\n", "\\n");
        content = content.replace(styleReplace, styleReplacement);

        // Active link fix
        content = content.replace("href=\\"${pageContext.request.contextPath}/tech/dashboard\\" class=\\"nav-link active\\"", "href=\\"${pageContext.request.contextPath}/tech/dashboard\\" class=\\"nav-link\\"");
        content = content.replace("href=\\"${pageContext.request.contextPath}/tech/profile\\" class=\\"nav-link\\"", "href=\\"${pageContext.request.contextPath}/tech/profile\\" class=\\"nav-link active\\"");

        // Main content fix
        String mainContentStart = "<div class=\\"main-content\\">\\n        <div class=\\"top-bar\\">\\n            <h1><i class=\\"fas fa-shield-halved\\"></i> Tech Person Dashboard</h1>";
        String mainContentReplacement = "<div class=\\"main-content\\">\\n        <div class=\\"top-bar\\">\\n            <h1><i class=\\"fas fa-user\\"></i> Profile</h1>";
        content = content.replace(mainContentStart, mainContentReplacement);

        // Remove stats and add profile form
        int startIdx = content.indexOf("        <!-- Stats Row 1 -->");
        int endIdx = content.indexOf("    <script>\\n        // Sidebar Toggle for Mobile");
        
        if (startIdx != -1 && endIdx != -1) {
            String profileForm = "        <div class=\\"profile-card\\">\\n" +
            "            <div class=\\"profile-header\\">\\n" +
            "                <div class=\\"profile-title\\">\\n" +
            "                    <i class=\\"fas fa-user-circle\\" style=\\"color: var(--primary); font-size: 32px;\\"></i>\\n" +
            "                    Tech Person Profile\\n" +
            "                </div>\\n" +
            "                <button type=\\"button\\" class=\\"btn-edit\\" id=\\"editBtn\\" onclick=\\"enableEdit()\\">\\n" +
            "                    <i class=\\"fas fa-edit\\"></i> Edit Profile\\n" +
            "                </button>\\n" +
            "            </div>\\n" +
            "\\n" +
            "            <c:if test=\\"${not empty message}\\">\\n" +
            "                <div style=\\"background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 12px; border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(16, 185, 129, 0.3);\\">\\n" +
            "                    ${message}\\n" +
            "                </div>\\n" +
            "            </c:if>\\n" +
            "            <c:if test=\\"${not empty error}\\">\\n" +
            "                <div style=\\"background: rgba(239, 68, 68, 0.1); color: #ef4444; padding: 12px; border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(239, 68, 68, 0.3);\\">\\n" +
            "                    ${error}\\n" +
            "                </div>\\n" +
            "            </c:if>\\n" +
            "\\n" +
            "            <form action=\\"${pageContext.request.contextPath}/tech/profile/update\\" method=\\"POST\\" id=\\"profileForm\\">\\n" +
            "                <div class=\\"form-group\\">\\n" +
            "                    <label>Full Name</label>\\n" +
            "                    <input type=\\"text\\" class=\\"form-control\\" name=\\"name\\" value=\\"${techPerson.name}\\" disabled required>\\n" +
            "                </div>\\n" +
            "                <div class=\\"form-group\\">\\n" +
            "                    <label>Email Address</label>\\n" +
            "                    <input type=\\"email\\" class=\\"form-control\\" name=\\"email\\" value=\\"${techPerson.email}\\" disabled required>\\n" +
            "                </div>\\n" +
            "                <div class=\\"form-group\\">\\n" +
            "                    <label>Phone Number</label>\\n" +
            "                    <input type=\\"text\\" class=\\"form-control\\" name=\\"phone\\" value=\\"${techPerson.phone}\\" disabled required>\\n" +
            "                </div>\\n" +
            "                <div class=\\"form-group\\">\\n" +
            "                    <label>New Password (leave blank to keep current)</label>\\n" +
            "                    <input type=\\"password\\" class=\\"form-control\\" name=\\"password\\" placeholder=\\"Enter new password\\" disabled>\\n" +
            "                </div>\\n" +
            "                \\n" +
            "                <div style=\\"text-align: right; margin-top: 30px;\\">\\n" +
            "                    <button type=\\"button\\" class=\\"btn-logout\\" id=\\"cancelBtn\\" style=\\"display: none; display: inline-flex; margin-right: 12px;\\" onclick=\\"cancelEdit()\\">\\n" +
            "                        Cancel\\n" +
            "                    </button>\\n" +
            "                    <button type=\\"submit\\" class=\\"btn-save\\" id=\\"saveBtn\\">\\n" +
            "                        <i class=\\"fas fa-save\\"></i> Save Changes\\n" +
            "                    </button>\\n" +
            "                </div>\\n" +
            "            </form>\\n" +
            "        </div>\\n" +
            "    </div>\\n\\n" +
            "    <script>\\n" +
            "        function enableEdit() {\\n" +
            "            const inputs = document.querySelectorAll('#profileForm .form-control');\\n" +
            "            inputs.forEach(input => input.disabled = false);\\n" +
            "            document.getElementById('editBtn').style.display = 'none';\\n" +
            "            document.getElementById('saveBtn').style.display = 'inline-flex';\\n" +
            "            document.getElementById('cancelBtn').style.display = 'inline-flex';\\n" +
            "        }\\n" +
            "\\n" +
            "        function cancelEdit() {\\n" +
            "            const inputs = document.querySelectorAll('#profileForm .form-control');\\n" +
            "            inputs.forEach(input => input.disabled = true);\\n" +
            "            document.getElementById('editBtn').style.display = 'inline-flex';\\n" +
            "            document.getElementById('saveBtn').style.display = 'none';\\n" +
            "            document.getElementById('cancelBtn').style.display = 'none';\\n" +
            "            document.getElementById('profileForm').reset();\\n" +
            "        }\\n\\n";
            
            content = content.substring(0, startIdx) + profileForm + content.substring(endIdx);
        }

        Files.write(Paths.get(path), content.getBytes("UTF-8"));
    }
}
