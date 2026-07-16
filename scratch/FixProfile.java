import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.charset.StandardCharsets;

public class FixProfile {
    public static void main(String[] args) throws Exception {
        Path path = Paths.get("c:/Users/NEHA/OneDrive/Desktop/jp/JobPortal/src/main/webapp/views/techperson/profile.jsp");
        String content = new String(Files.readAllBytes(path), StandardCharsets.UTF_8);

        // Sidebar link fix
        content = content.replace(
            "<a href=\"${pageContext.request.contextPath}/tech/dashboard\" class=\"nav-link active\">",
            "<a href=\"${pageContext.request.contextPath}/tech/dashboard\" class=\"nav-link\">"
        );
        content = content.replace(
            "<a href=\"${pageContext.request.contextPath}/tech/profile\" class=\"nav-link\">",
            "<a href=\"${pageContext.request.contextPath}/tech/profile\" class=\"nav-link active\">"
        );

        // Replace Title
        content = content.replace(
            "<h1><i class=\"fas fa-shield-halved\"></i> Tech Person Dashboard</h1>",
            "<h1><i class=\"fas fa-user\"></i> Profile</h1>"
        );

        // Replace the main body
        String startStr = "<!-- Stats Row 1 -->";
        String endStr = "<script>\n        // Sidebar Toggle for Mobile";
        int startIdx = content.indexOf(startStr);
        int endIdx = content.indexOf(endStr, startIdx);

        if (startIdx != -1 && endIdx != -1) {
            String formContent = 
                "<div class=\"profile-card\" style=\"background: rgba(255, 255, 255, 0.95); border: 1px solid var(--border-color); border-radius: var(--radius-lg); padding: 30px; backdrop-filter: blur(20px); max-width: 800px; margin: 0 auto;\">\n" +
                "    <div class=\"profile-header\" style=\"display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; border-bottom: 1px solid rgba(0,0,0,0.1); padding-bottom: 20px;\">\n" +
                "        <div class=\"profile-title\" style=\"font-size: 20px; font-weight: 700; color: #1e293b; display: flex; align-items: center; gap: 12px;\">\n" +
                "            <i class=\"fas fa-user-circle\" style=\"color: var(--primary); font-size: 32px;\"></i>\n" +
                "            Tech Person Profile\n" +
                "        </div>\n" +
                "        <button type=\"button\" class=\"btn-edit\" id=\"editBtn\" onclick=\"enableEdit()\" style=\"background: var(--primary); color: white; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 8px;\">\n" +
                "            <i class=\"fas fa-edit\"></i> Edit Profile\n" +
                "        </button>\n" +
                "    </div>\n\n" +
                "    <c:if test=\"${not empty message}\">\n" +
                "        <div style=\"background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 12px; border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(16, 185, 129, 0.3);\">\n" +
                "            ${message}\n" +
                "        </div>\n" +
                "    </c:if>\n" +
                "    <c:if test=\"${not empty error}\">\n" +
                "        <div style=\"background: rgba(239, 68, 68, 0.1); color: #ef4444; padding: 12px; border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(239, 68, 68, 0.3);\">\n" +
                "            ${error}\n" +
                "        </div>\n" +
                "    </c:if>\n\n" +
                "    <form action=\"${pageContext.request.contextPath}/tech/profile/update\" method=\"POST\" id=\"profileForm\">\n" +
                "        <div style=\"margin-bottom: 20px;\">\n" +
                "            <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: #64748b;\">Full Name</label>\n" +
                "            <input type=\"text\" name=\"name\" value=\"${techPerson.name}\" disabled required style=\"width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "        </div>\n" +
                "        <div style=\"margin-bottom: 20px;\">\n" +
                "            <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: #64748b;\">Email Address</label>\n" +
                "            <input type=\"email\" name=\"email\" value=\"${techPerson.email}\" disabled required style=\"width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "        </div>\n" +
                "        <div style=\"margin-bottom: 20px;\">\n" +
                "            <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: #64748b;\">New Password (leave blank to keep current)</label>\n" +
                "            <input type=\"password\" name=\"password\" placeholder=\"Enter new password\" disabled style=\"width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "        </div>\n" +
                "        \n" +
                "        <div style=\"text-align: right; margin-top: 30px;\">\n" +
                "            <button type=\"button\" id=\"cancelBtn\" onclick=\"cancelEdit()\" style=\"display: none; background: transparent; color: #64748b; border: 1px solid #cbd5e1; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer; margin-right: 12px;\">\n" +
                "                Cancel\n" +
                "            </button>\n" +
                "            <button type=\"submit\" id=\"saveBtn\" style=\"display: none; background: var(--primary); color: white; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer;\">\n" +
                "                <i class=\"fas fa-save\"></i> Save Changes\n" +
                "            </button>\n" +
                "        </div>\n" +
                "    </form>\n" +
                "</div>\n" +
                "</div>\n\n" +
                "<script>\n" +
                "    function enableEdit() {\n" +
                "        const inputs = document.querySelectorAll('#profileForm input');\n" +
                "        inputs.forEach(input => {\n" +
                "            input.disabled = false;\n" +
                "            input.style.background = '#ffffff';\n" +
                "            input.style.border = '1px solid var(--primary)';\n" +
                "        });\n" +
                "        document.getElementById('editBtn').style.display = 'none';\n" +
                "        document.getElementById('saveBtn').style.display = 'inline-block';\n" +
                "        document.getElementById('cancelBtn').style.display = 'inline-block';\n" +
                "    }\n\n" +
                "    function cancelEdit() {\n" +
                "        const inputs = document.querySelectorAll('#profileForm input');\n" +
                "        inputs.forEach(input => {\n" +
                "            input.disabled = true;\n" +
                "            input.style.background = '#f8fafc';\n" +
                "            input.style.border = '1px solid #e2e8f0';\n" +
                "        });\n" +
                "        document.getElementById('editBtn').style.display = 'inline-flex';\n" +
                "        document.getElementById('saveBtn').style.display = 'none';\n" +
                "        document.getElementById('cancelBtn').style.display = 'none';\n" +
                "        document.getElementById('profileForm').reset();\n" +
                "    }\n" +
                "</script>\n";

            content = content.substring(0, startIdx) + formContent + content.substring(endIdx); 
        }

        Files.write(path, content.getBytes(StandardCharsets.UTF_8));
    }
}
