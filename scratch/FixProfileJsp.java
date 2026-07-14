import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.charset.StandardCharsets;

public class FixProfileJsp {
    public static void main(String[] args) throws Exception {
        Path path = Paths.get("c:/Users/NEHA/OneDrive/Desktop/jp/JobPortal/src/main/webapp/views/techperson/profile.jsp");
        String content = new String(Files.readAllBytes(path), StandardCharsets.UTF_8);

        String startStr = "<form action=\"${pageContext.request.contextPath}/tech/profile/update\" method=\"POST\" id=\"profileForm\" enctype=\"multipart/form-data\">";
        String endStr = "</form>";
        int startIdx = content.indexOf(startStr);
        int endIdx = content.indexOf(endStr, startIdx);

        if (startIdx != -1 && endIdx != -1) {
            String formContent = 
                "<form action=\"${pageContext.request.contextPath}/tech/profile/update\" method=\"POST\" id=\"profileForm\" enctype=\"multipart/form-data\">\n" +
                "    <div style=\"display: flex; gap: 30px; margin-bottom: 24px; flex-wrap: wrap;\">\n" +
                "        \n" +
                "        <!-- Left Sidebar: Profile Pic & Account -->\n" +
                "        <div style=\"flex: 0 0 250px;\">\n" +
                "            <!-- Personal Info: Photo -->\n" +
                "            <div style=\"text-align: center; margin-bottom: 30px;\">\n" +
                "                <div style=\"width: 150px; height: 150px; border-radius: 50%; border: 3px solid var(--primary); overflow: hidden; margin: 0 auto 12px auto; background: #f8fafc; display: flex; align-items: center; justify-content: center;\">\n" +
                "                    <c:choose>\n" +
                "                        <c:when test=\"${not empty techPerson.profilePic}\">\n" +
                "                            <img src=\"${pageContext.request.contextPath}/resources/profile_pics/${techPerson.profilePic}\" id=\"picPreview\" style=\"width: 100%; height: 100%; object-fit: cover;\">\n" +
                "                        </c:when>\n" +
                "                        <c:otherwise>\n" +
                "                            <img src=\"\" id=\"picPreview\" style=\"width: 100%; height: 100%; object-fit: cover; display: none;\">\n" +
                "                            <i class=\"fas fa-user\" id=\"picFallback\" style=\"font-size: 64px; color: #cbd5e1;\"></i>\n" +
                "                        </c:otherwise>\n" +
                "                    </c:choose>\n" +
                "                </div>\n" +
                "                <label id=\"picLabel\" for=\"profilePicInput\" style=\"display: none; background: var(--primary); color: white; padding: 6px 12px; border-radius: 6px; cursor: pointer; font-size: 13px; font-weight: 600;\">\n" +
                "                    <i class=\"fas fa-upload\"></i> Upload Pic\n" +
                "                </label>\n" +
                "                <input type=\"file\" id=\"profilePicInput\" name=\"profilePicFile\" accept=\"image/*\" style=\"display: none;\" onchange=\"previewImage(event)\">\n" +
                "            </div>\n\n" +
                "            <!-- Account Information -->\n" +
                "            <h3 style=\"font-size: 16px; color: #1e293b; margin-bottom: 12px; border-bottom: 1px solid #e2e8f0; padding-bottom: 8px;\"><i class=\"fas fa-id-badge\"></i> Account Information</h3>\n" +
                "            <div style=\"margin-bottom: 15px;\">\n" +
                "                <label style=\"display: block; margin-bottom: 5px; font-weight: 500; color: #64748b; font-size: 14px;\">Username</label>\n" +
                "                <input type=\"text\" name=\"username\" value=\"${techPerson.username}\" disabled style=\"width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; background: #f1f5f9; color: #1e293b;\">\n" +
                "            </div>\n" +
                "            <div style=\"margin-bottom: 15px;\">\n" +
                "                <label style=\"display: block; margin-bottom: 5px; font-weight: 500; color: #64748b; font-size: 14px;\">Role</label>\n" +
                "                <input type=\"text\" value=\"Tech Person\" disabled style=\"width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; background: #f1f5f9; color: #1e293b; font-weight: 600;\">\n" +
                "            </div>\n" +
                "        </div>\n\n" +
                "        <!-- Main Content Area -->\n" +
                "        <div style=\"flex: 1; min-width: 300px;\">\n" +
                "            \n" +
                "            <!-- Personal Information -->\n" +
                "            <h3 style=\"font-size: 16px; color: #1e293b; margin-bottom: 12px; border-bottom: 1px solid #e2e8f0; padding-bottom: 8px;\"><i class=\"fas fa-user\"></i> Personal Information</h3>\n" +
                "            <div style=\"display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 25px;\">\n" +
                "                <div>\n" +
                "                    <label style=\"display: block; margin-bottom: 5px; font-weight: 500; color: #64748b; font-size: 14px;\">Full Name</label>\n" +
                "                    <input type=\"text\" name=\"name\" value=\"${techPerson.name}\" disabled required style=\"width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "                </div>\n" +
                "                <div>\n" +
                "                    <label style=\"display: block; margin-bottom: 5px; font-weight: 500; color: #64748b; font-size: 14px;\">Email Address</label>\n" +
                "                    <input type=\"email\" name=\"email\" value=\"${techPerson.email}\" disabled required style=\"width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "                </div>\n" +
                "                <div>\n" +
                "                    <label style=\"display: block; margin-bottom: 5px; font-weight: 500; color: #64748b; font-size: 14px;\">Mobile Number</label>\n" +
                "                    <input type=\"text\" name=\"phone\" value=\"${techPerson.phone}\" disabled style=\"width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "                </div>\n" +
                "            </div>\n\n" +
                "            <!-- Professional Information -->\n" +
                "            <h3 style=\"font-size: 16px; color: #1e293b; margin-bottom: 12px; border-bottom: 1px solid #e2e8f0; padding-bottom: 8px;\"><i class=\"fas fa-briefcase\"></i> Professional Information</h3>\n" +
                "            <div style=\"display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 25px;\">\n" +
                "                <div>\n" +
                "                    <label style=\"display: block; margin-bottom: 5px; font-weight: 500; color: #64748b; font-size: 14px;\">Employee ID</label>\n" +
                "                    <input type=\"text\" name=\"employeeId\" value=\"${techPerson.employeeId}\" disabled style=\"width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; background: #f1f5f9; color: #1e293b;\">\n" +
                "                </div>\n" +
                "                <div>\n" +
                "                    <label style=\"display: block; margin-bottom: 5px; font-weight: 500; color: #64748b; font-size: 14px;\">Designation</label>\n" +
                "                    <input type=\"text\" name=\"designation\" value=\"${techPerson.designation}\" disabled style=\"width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "                </div>\n" +
                "                <div>\n" +
                "                    <label style=\"display: block; margin-bottom: 5px; font-weight: 500; color: #64748b; font-size: 14px;\">Department</label>\n" +
                "                    <input type=\"text\" name=\"department\" value=\"${techPerson.department}\" disabled style=\"width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "                </div>\n" +
                "                <div>\n" +
                "                    <label style=\"display: block; margin-bottom: 5px; font-weight: 500; color: #64748b; font-size: 14px;\">Experience (Years)</label>\n" +
                "                    <input type=\"number\" name=\"experience\" value=\"${techPerson.experience}\" disabled style=\"width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "                </div>\n" +
                "                <div style=\"grid-column: span 2;\">\n" +
                "                    <label style=\"display: block; margin-bottom: 5px; font-weight: 500; color: #64748b; font-size: 14px;\">Primary Technology</label>\n" +
                "                    <select name=\"primaryTechnology\" disabled style=\"width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "                        <option value=\"\">Select Technology</option>\n" +
                "                        <option value=\"Java\" ${techPerson.primaryTechnology == 'Java' ? 'selected' : ''}>Java</option>\n" +
                "                        <option value=\"Python\" ${techPerson.primaryTechnology == 'Python' ? 'selected' : ''}>Python</option>\n" +
                "                        <option value=\"JavaScript\" ${techPerson.primaryTechnology == 'JavaScript' ? 'selected' : ''}>JavaScript (React/Node)</option>\n" +
                "                        <option value=\"C++\" ${techPerson.primaryTechnology == 'C++' ? 'selected' : ''}>C++</option>\n" +
                "                        <option value=\"DevOps\" ${techPerson.primaryTechnology == 'DevOps' ? 'selected' : ''}>DevOps (AWS/Docker)</option>\n" +
                "                        <option value=\"Other\" ${techPerson.primaryTechnology == 'Other' ? 'selected' : ''}>Other</option>\n" +
                "                    </select>\n" +
                "                </div>\n" +
                "            </div>\n\n" +
                "            <!-- Security Information -->\n" +
                "            <h3 style=\"font-size: 16px; color: #1e293b; margin-bottom: 12px; border-bottom: 1px solid #e2e8f0; padding-bottom: 8px;\"><i class=\"fas fa-lock\"></i> Security</h3>\n" +
                "            <div style=\"display: grid; grid-template-columns: 1fr 1fr; gap: 15px;\">\n" +
                "                <div>\n" +
                "                    <label style=\"display: block; margin-bottom: 5px; font-weight: 500; color: #64748b; font-size: 14px;\">Change Password</label>\n" +
                "                    <input type=\"password\" name=\"password\" placeholder=\"New Password\" disabled style=\"width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "                </div>\n" +
                "                <div>\n" +
                "                    <label style=\"display: block; margin-bottom: 5px; font-weight: 500; color: #64748b; font-size: 14px;\">Confirm New Password</label>\n" +
                "                    <input type=\"password\" name=\"confirmPassword\" placeholder=\"Confirm Password\" disabled style=\"width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "                </div>\n" +
                "            </div>\n\n" +
                "        </div>\n" +
                "    </div>\n" +
                "    \n" +
                "    <div style=\"text-align: right; margin-top: 20px; border-top: 1px solid rgba(0,0,0,0.1); padding-top: 20px;\">\n" +
                "        <button type=\"button\" id=\"cancelBtn\" onclick=\"cancelEdit()\" style=\"display: none; background: transparent; color: #64748b; border: 1px solid #cbd5e1; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer; margin-right: 12px;\">\n" +
                "            Cancel\n" +
                "        </button>\n" +
                "        <button type=\"submit\" id=\"saveBtn\" style=\"display: none; background: var(--primary); color: white; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer;\">\n" +
                "            <i class=\"fas fa-save\"></i> Update Profile\n" +
                "        </button>\n" +
                "    </div>\n" +
                "</form>";

            content = content.substring(0, startIdx) + formContent + content.substring(endIdx + 7);
            
            // Add image preview JS function just before closing body
            String jsContent = "\n<script>\n" +
                "function previewImage(event) {\n" +
                "    var reader = new FileReader();\n" +
                "    reader.onload = function() {\n" +
                "        var output = document.getElementById('picPreview');\n" +
                "        output.src = reader.result;\n" +
                "        output.style.display = 'block';\n" +
                "        var fallback = document.getElementById('picFallback');\n" +
                "        if (fallback) fallback.style.display = 'none';\n" +
                "    };\n" +
                "    reader.readAsDataURL(event.target.files[0]);\n" +
                "}\n" +
                "</script>\n</body>";
            content = content.replace("</body>", jsContent);

            Files.write(path, content.getBytes(StandardCharsets.UTF_8));
        }
    }
}
