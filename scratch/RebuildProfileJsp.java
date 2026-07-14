import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.charset.StandardCharsets;

public class RebuildProfileJsp {
    public static void main(String[] args) throws Exception {
        Path path = Paths.get("c:/Users/NEHA/OneDrive/Desktop/jp/JobPortal/src/main/webapp/views/techperson/profile.jsp");
        String content = new String(Files.readAllBytes(path), StandardCharsets.UTF_8);
        content = content.replace("\r\n", "\n");

        // First add the custom CSS classes in the style tag if not present
        String styleMarker = "</style>";
        int styleMarkerIdx = content.indexOf(styleMarker);
        if (styleMarkerIdx != -1) {
            String cssOverrides = 
                "\n        /* Custom Form Input Styles */\n" +
                "        .profile-form-control {\n" +
                "            width: 100%;\n" +
                "            padding: 12px 16px;\n" +
                "            border-radius: 12px;\n" +
                "            border: 1px solid var(--border-color);\n" +
                "            background: rgba(255, 255, 255, 0.05);\n" +
                "            color: var(--text-primary);\n" +
                "            font-size: 14px;\n" +
                "            font-weight: 500;\n" +
                "            transition: var(--transition);\n" +
                "        }\n" +
                "        .profile-form-control:focus {\n" +
                "            outline: none;\n" +
                "            border-color: var(--primary);\n" +
                "            box-shadow: 0 0 10px rgba(25, 167, 123, 0.15);\n" +
                "            background: rgba(255, 255, 255, 0.08);\n" +
                "        }\n" +
                "        .profile-form-control:disabled {\n" +
                "            background: rgba(255, 255, 255, 0.02);\n" +
                "            color: var(--text-tertiary);\n" +
                "            cursor: not-allowed;\n" +
                "            border-color: rgba(255, 255, 255, 0.04);\n" +
                "        }\n" +
                "        body.light-mode .profile-form-control {\n" +
                "            background: #ffffff;\n" +
                "            color: #1e293b;\n" +
                "            border-color: #cbd5e1;\n" +
                "        }\n" +
                "        body.light-mode .profile-form-control:focus {\n" +
                "            background: #ffffff;\n" +
                "            border-color: var(--primary);\n" +
                "        }\n" +
                "        body.light-mode .profile-form-control:disabled {\n" +
                "            background: #f1f5f9;\n" +
                "            color: #94a3b8;\n" +
                "            border-color: #e2e8f0;\n" +
                "        }\n" +
                "        .form-section-title {\n" +
                "            font-size: 16px;\n" +
                "            font-weight: 600;\n" +
                "            color: var(--primary);\n" +
                "            margin: 24px 0 16px 0;\n" +
                "            padding-bottom: 8px;\n" +
                "            border-bottom: 1px solid var(--border-color);\n" +
                "            display: flex;\n" +
                "            align-items: center;\n" +
                "            gap: 8px;\n" +
                "        }\n" +
                "        .profile-grid {\n" +
                "            display: grid;\n" +
                "            grid-template-columns: repeat(2, 1fr);\n" +
                "            gap: 20px;\n" +
                "        }\n" +
                "        @media (max-width: 768px) {\n" +
                "            .profile-grid {\n" +
                "                grid-template-columns: 1fr;\n" +
                "            }\n" +
                "        }\n";
            content = content.substring(0, styleMarkerIdx) + cssOverrides + content.substring(styleMarkerIdx);
        }

        // Now replace the main content block
        String startStr = "<!-- Stats Row 1 -->";
        String endStr = "<script>\n        // Sidebar Toggle for Mobile";
        int startIdx = content.indexOf(startStr);
        int endIdx = content.indexOf(endStr, startIdx);

        if (startIdx != -1 && endIdx != -1) {
            String formContent = 
                "<!-- Profile Form Card -->\n" +
                "        <div class=\"card\" style=\"max-width: 900px; margin: 0 auto 30px auto; padding: 30px; border-radius: var(--radius-lg); backdrop-filter: blur(20px);\">\n" +
                "            <div style=\"display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 1px solid var(--border-color); padding-bottom: 15px;\">\n" +
                "                <h2 style=\"font-size: 20px; font-weight: 600; color: var(--primary); display: flex; align-items: center; gap: 10px; margin: 0;\">\n" +
                "                    <i class=\"fas fa-user-circle\"></i> Profile Settings\n" +
                "                </h2>\n" +
                "                <button type=\"button\" class=\"btn-edit\" id=\"editBtn\" onclick=\"enableEdit()\" style=\"background: var(--primary); color: white; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 8px;\">\n" +
                "                    <i class=\"fas fa-edit\"></i> Edit Profile\n" +
                "                </button>\n" +
                "            </div>\n\n" +
                "            <c:if test=\"${not empty message}\">\n" +
                "                <div style=\"background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 12px; border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(16, 185, 129, 0.3);\">\n" +
                "                    ${message}\n" +
                "                </div>\n" +
                "            </c:if>\n" +
                "            <c:if test=\"${not empty error}\">\n" +
                "                <div style=\"background: rgba(239, 68, 68, 0.1); color: #ef4444; padding: 12px; border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(239, 68, 68, 0.3);\">\n" +
                "                    ${error}\n" +
                "                </div>\n" +
                "            </c:if>\n\n" +
                "            <form action=\"${pageContext.request.contextPath}/tech/profile/update\" method=\"POST\" id=\"profileForm\" enctype=\"multipart/form-data\">\n" +
                "                <div style=\"display: flex; gap: 30px; margin-bottom: 24px; flex-wrap: wrap;\">\n" +
                "                    \n" +
                "                    <!-- Profile Photo (upload with image preview) -->\n" +
                "                    <div style=\"flex: 0 0 200px; text-align: center; margin: 0 auto;\">\n" +
                "                        <div style=\"width: 150px; height: 150px; border-radius: 50%; border: 3px solid var(--primary); overflow: hidden; margin: 0 auto 15px auto; background: rgba(255,255,255,0.05); display: flex; align-items: center; justify-content: center; position: relative;\">\n" +
                "                            <c:choose>\n" +
                "                                <c:when test=\"${not empty techPerson.profilePic}\">\n" +
                "                                    <img src=\"${pageContext.request.contextPath}/resources/profile_pics/${techPerson.profilePic}\" id=\"picPreview\" style=\"width: 100%; height: 100%; object-fit: cover;\">\n" +
                "                                </c:when>\n" +
                "                                <c:otherwise>\n" +
                "                                    <img src=\"\" id=\"picPreview\" style=\"width: 100%; height: 100%; object-fit: cover; display: none;\">\n" +
                "                                    <i class=\"fas fa-user\" id=\"picFallback\" style=\"font-size: 64px; color: var(--text-tertiary);\"></i>\n" +
                "                                </c:otherwise>\n" +
                "                            </c:choose>\n" +
                "                        </div>\n" +
                "                        <label id=\"picLabel\" for=\"profilePicInput\" style=\"display: none; background: var(--primary); color: white; padding: 8px 16px; border-radius: 8px; cursor: pointer; font-size: 13px; font-weight: 600; transition: var(--transition);\">\n" +
                "                            <i class=\"fas fa-camera\"></i> Upload Photo\n" +
                "                        </label>\n" +
                "                        <input type=\"file\" id=\"profilePicInput\" name=\"profilePicFile\" accept=\"image/*\" style=\"display: none;\" onchange=\"previewImage(event)\">\n" +
                "                    </div>\n\n" +
                "                    <!-- Form Fields -->\n" +
                "                    <div style=\"flex: 1; min-width: 280px;\">\n" +
                "                        \n" +
                "                        <!-- Personal Information -->\n" +
                "                        <div class=\"form-section-title\">\n" +
                "                            <i class=\"fas fa-user\"></i> Personal Information\n" +
                "                        </div>\n" +
                "                        <div class=\"profile-grid\">\n" +
                "                            <div>\n" +
                "                                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: var(--text-secondary); font-size: 14px;\">Full Name</label>\n" +
                "                                <input type=\"text\" name=\"name\" value=\"${techPerson.name}\" class=\"profile-form-control\" disabled required>\n" +
                "                            </div>\n" +
                "                            <div>\n" +
                "                                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: var(--text-secondary); font-size: 14px;\">Email Address</label>\n" +
                "                                <input type=\"email\" name=\"email\" value=\"${techPerson.email}\" class=\"profile-form-control\" disabled required>\n" +
                "                            </div>\n" +
                "                            <div style=\"grid-column: span 2;\">\n" +
                "                                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: var(--text-secondary); font-size: 14px;\">Mobile Number</label>\n" +
                "                                <input type=\"text\" name=\"phone\" value=\"${techPerson.phone}\" class=\"profile-form-control\" disabled>\n" +
                "                            </div>\n" +
                "                        </div>\n\n" +
                "                        <!-- Professional Information -->\n" +
                "                        <div class=\"form-section-title\">\n" +
                "                            <i class=\"fas fa-briefcase\"></i> Professional Information\n" +
                "                        </div>\n" +
                "                        <div class=\"profile-grid\">\n" +
                "                            <div>\n" +
                "                                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: var(--text-secondary); font-size: 14px;\">Employee ID (read-only)</label>\n" +
                "                                <input type=\"text\" name=\"employeeId\" value=\"${techPerson.employeeId}\" class=\"profile-form-control\" disabled readonly style=\"background: rgba(255, 255, 255, 0.02); color: var(--text-tertiary);\">\n" +
                "                            </div>\n" +
                "                            <div>\n" +
                "                                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: var(--text-secondary); font-size: 14px;\">Designation</label>\n" +
                "                                <input type=\"text\" name=\"designation\" value=\"${techPerson.designation}\" class=\"profile-form-control\" disabled>\n" +
                "                            </div>\n" +
                "                            <div>\n" +
                "                                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: var(--text-secondary); font-size: 14px;\">Department</label>\n" +
                "                                <input type=\"text\" name=\"department\" value=\"${techPerson.department}\" class=\"profile-form-control\" disabled>\n" +
                "                            </div>\n" +
                "                            <div>\n" +
                "                                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: var(--text-secondary); font-size: 14px;\">Experience (Years)</label>\n" +
                "                                <input type=\"text\" name=\"experience\" value=\"${techPerson.experience}\" class=\"profile-form-control\" disabled>\n" +
                "                            </div>\n" +
                "                            <div style=\"grid-column: span 2;\">\n" +
                "                                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: var(--text-secondary); font-size: 14px;\">Primary Technology</label>\n" +
                "                                <input type=\"text\" name=\"primaryTechnology\" value=\"${techPerson.primaryTechnology}\" class=\"profile-form-control\" disabled>\n" +
                "                            </div>\n" +
                "                        </div>\n\n" +
                "                        <!-- Account Information -->\n" +
                "                        <div class=\"form-section-title\">\n" +
                "                            <i class=\"fas fa-id-card\"></i> Account Information\n" +
                "                        </div>\n" +
                "                        <div class=\"profile-grid\">\n" +
                "                            <div>\n" +
                "                                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: var(--text-secondary); font-size: 14px;\">Username</label>\n" +
                "                                <input type=\"text\" name=\"username\" value=\"${techPerson.username}\" class=\"profile-form-control\" disabled>\n" +
                "                            </div>\n" +
                "                            <div>\n" +
                "                                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: var(--text-secondary); font-size: 14px;\">Role</label>\n" +
                "                                <input type=\"text\" name=\"role\" value=\"Tech Person\" class=\"profile-form-control\" disabled readonly style=\"background: rgba(255, 255, 255, 0.02); color: var(--text-tertiary); font-weight: 600;\">\n" +
                "                            </div>\n" +
                "                        </div>\n\n" +
                "                        <!-- Security -->\n" +
                "                        <div class=\"form-section-title\">\n" +
                "                            <i class=\"fas fa-shield-alt\"></i> Security\n" +
                "                        </div>\n" +
                "                        <div class=\"profile-grid\">\n" +
                "                            <div>\n" +
                "                                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: var(--text-secondary); font-size: 14px;\">Change Password</label>\n" +
                "                                <input type=\"password\" name=\"password\" placeholder=\"New Password\" class=\"profile-form-control\" disabled>\n" +
                "                            </div>\n" +
                "                            <div>\n" +
                "                                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: var(--text-secondary); font-size: 14px;\">Confirm New Password</label>\n" +
                "                                <input type=\"password\" name=\"confirmPassword\" placeholder=\"Confirm New Password\" class=\"profile-form-control\" disabled>\n" +
                "                            </div>\n" +
                "                        </div>\n\n" +
                "                    </div>\n" +
                "                </div>\n\n" +
                "                <!-- Buttons -->\n" +
                "                <div style=\"text-align: right; margin-top: 25px; border-top: 1px solid var(--border-color); padding-top: 20px;\">\n" +
                "                    <button type=\"button\" id=\"cancelBtn\" onclick=\"cancelEdit()\" style=\"display: none; background: transparent; color: var(--text-secondary); border: 1px solid var(--border-color); padding: 10px 24px; border-radius: 8px; font-weight: 600; cursor: pointer; margin-right: 12px; transition: var(--transition);\">\n" +
                "                        Cancel\n" +
                "                    </button>\n" +
                "                    <button type=\"submit\" id=\"saveBtn\" style=\"display: none; background: var(--primary); color: white; border: none; padding: 10px 24px; border-radius: 8px; font-weight: 600; cursor: pointer; transition: var(--transition);\">\n" +
                "                        <i class=\"fas fa-save\"></i> Update Profile\n" +
                "                    </button>\n" +
                "                </div>\n" +
                "            </form>\n" +
                "        </div>\n" +
                "        \n" +
                "        <script>\n" +
                "            function enableEdit() {\n" +
                "                const inputs = document.querySelectorAll('.profile-form-control');\n" +
                "                inputs.forEach(input => {\n" +
                "                    if (input.name !== 'employeeId' && input.name !== 'role') {\n" +
                "                        input.disabled = false;\n" +
                "                    }\n" +
                "                });\n" +
                "                document.getElementById('editBtn').style.display = 'none';\n" +
                "                document.getElementById('saveBtn').style.display = 'inline-block';\n" +
                "                document.getElementById('cancelBtn').style.display = 'inline-block';\n" +
                "                document.getElementById('picLabel').style.display = 'inline-block';\n" +
                "            }\n\n" +
                "            function cancelEdit() {\n" +
                "                const inputs = document.querySelectorAll('.profile-form-control');\n" +
                "                inputs.forEach(input => {\n" +
                "                    input.disabled = true;\n" +
                "                });\n" +
                "                document.getElementById('editBtn').style.display = 'inline-flex';\n" +
                "                document.getElementById('saveBtn').style.display = 'none';\n" +
                "                document.getElementById('cancelBtn').style.display = 'none';\n" +
                "                document.getElementById('picLabel').style.display = 'none';\n" +
                "                document.getElementById('profileForm').reset();\n" +
                "                // Reset image preview if cancelled\n" +
                "                var preview = document.getElementById('picPreview');\n" +
                "                var fallback = document.getElementById('picFallback');\n" +
                "                <c:choose>\n" +
                "                    <c:when test=\"${not empty techPerson.profilePic}\">\n" +
                "                        preview.src = '${pageContext.request.contextPath}/resources/profile_pics/${techPerson.profilePic}';\n" +
                "                        preview.style.display = 'block';\n" +
                "                        if (fallback) fallback.style.display = 'none';\n" +
                "                    </c:when>\n" +
                "                    <c:otherwise>\n" +
                "                        preview.style.display = 'none';\n" +
                "                        if (fallback) fallback.style.display = 'block';\n" +
                "                    </c:otherwise>\n" +
                "                </c:choose>\n" +
                "            }\n\n" +
                "            function previewImage(event) {\n" +
                "                var reader = new FileReader();\n" +
                "                reader.onload = function() {\n" +
                "                    var output = document.getElementById('picPreview');\n" +
                "                    output.src = reader.result;\n" +
                "                    output.style.display = 'block';\n" +
                "                    var fallback = document.getElementById('picFallback');\n" +
                "                    if (fallback) fallback.style.display = 'none';\n" +
                "                };\n" +
                "                reader.readAsDataURL(event.target.files[0]);\n" +
                "            }\n" +
                "        </script>\n";

            content = content.substring(0, startIdx) + formContent + content.substring(endIdx);
            
            Files.write(path, content.getBytes(StandardCharsets.UTF_8));
            System.out.println("profile.jsp updated successfully!");
        } else {
            System.out.println("Could not find start/end string indicators in profile.jsp!");
        }
    }
}
