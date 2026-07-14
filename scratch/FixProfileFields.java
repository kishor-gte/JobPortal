import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.charset.StandardCharsets;

public class FixProfileFields {
    public static void main(String[] args) throws Exception {
        Path path = Paths.get("c:/Users/NEHA/OneDrive/Desktop/jp/JobPortal/src/main/webapp/views/techperson/profile.jsp");
        String content = new String(Files.readAllBytes(path), StandardCharsets.UTF_8);

        String startStr = "<form action=\"${pageContext.request.contextPath}/tech/profile/update\" method=\"POST\" id=\"profileForm\">";
        String endStr = "</form>";
        int startIdx = content.indexOf(startStr);
        int endIdx = content.indexOf(endStr, startIdx);

        if (startIdx != -1 && endIdx != -1) {
            String formContent = 
                "<form action=\"${pageContext.request.contextPath}/tech/profile/update\" method=\"POST\" id=\"profileForm\" enctype=\"multipart/form-data\">\n" +
                "    <div style=\"display: flex; gap: 30px; margin-bottom: 24px;\">\n" +
                "        <!-- Profile Pic Section -->\n" +
                "        <div style=\"flex: 0 0 150px; text-align: center;\">\n" +
                "            <div style=\"width: 150px; height: 150px; border-radius: 50%; border: 3px solid var(--primary); overflow: hidden; margin-bottom: 12px; background: #f8fafc; display: flex; align-items: center; justify-content: center;\">\n" +
                "                <c:choose>\n" +
                "                    <c:when test=\"${not empty techPerson.profilePic}\">\n" +
                "                        <img src=\"${pageContext.request.contextPath}/resources/profile_pics/${techPerson.profilePic}\" alt=\"Profile Pic\" style=\"width: 100%; height: 100%; object-fit: cover;\">\n" +
                "                    </c:when>\n" +
                "                    <c:otherwise>\n" +
                "                        <i class=\"fas fa-user\" style=\"font-size: 64px; color: #cbd5e1;\"></i>\n" +
                "                    </c:otherwise>\n" +
                "                </c:choose>\n" +
                "            </div>\n" +
                "            <label id=\"picLabel\" for=\"profilePicInput\" style=\"display: none; background: var(--primary); color: white; padding: 6px 12px; border-radius: 6px; cursor: pointer; font-size: 13px; font-weight: 600;\">\n" +
                "                <i class=\"fas fa-upload\"></i> Upload Pic\n" +
                "            </label>\n" +
                "            <input type=\"file\" id=\"profilePicInput\" name=\"profilePicFile\" accept=\"image/*\" style=\"display: none;\">\n" +
                "        </div>\n\n" +
                "        <!-- Details Section -->\n" +
                "        <div style=\"flex: 1; display: grid; grid-template-columns: 1fr 1fr; gap: 20px;\">\n" +
                "            <div>\n" +
                "                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: #64748b;\">Full Name</label>\n" +
                "                <input type=\"text\" name=\"name\" value=\"${techPerson.name}\" disabled required style=\"width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "            </div>\n" +
                "            <div>\n" +
                "                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: #64748b;\">Username</label>\n" +
                "                <input type=\"text\" name=\"username\" value=\"${techPerson.username}\" disabled style=\"width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "            </div>\n" +
                "            <div>\n" +
                "                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: #64748b;\">Email Address</label>\n" +
                "                <input type=\"email\" name=\"email\" value=\"${techPerson.email}\" disabled required style=\"width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "            </div>\n" +
                "            <div>\n" +
                "                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: #64748b;\">Phone Number</label>\n" +
                "                <input type=\"text\" name=\"phone\" value=\"${techPerson.phone}\" disabled style=\"width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "            </div>\n" +
                "            <div style=\"grid-column: span 2;\">\n" +
                "                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: #64748b;\">Address</label>\n" +
                "                <input type=\"text\" name=\"address\" value=\"${techPerson.address}\" disabled style=\"width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "            </div>\n" +
                "            <div>\n" +
                "                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: #64748b;\">Designation</label>\n" +
                "                <input type=\"text\" name=\"designation\" value=\"${techPerson.designation}\" disabled style=\"width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "            </div>\n" +
                "            <div>\n" +
                "                <label style=\"display: block; margin-bottom: 8px; font-weight: 500; color: #64748b;\">New Password (leave blank to keep current)</label>\n" +
                "                <input type=\"password\" name=\"password\" placeholder=\"Enter new password\" disabled style=\"width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;\">\n" +
                "            </div>\n" +
                "        </div>\n" +
                "    </div>\n" +
                "    \n" +
                "    <div style=\"text-align: right; margin-top: 20px; border-top: 1px solid rgba(0,0,0,0.1); padding-top: 20px;\">\n" +
                "        <button type=\"button\" id=\"cancelBtn\" onclick=\"cancelEdit()\" style=\"display: none; background: transparent; color: #64748b; border: 1px solid #cbd5e1; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer; margin-right: 12px;\">\n" +
                "            Cancel\n" +
                "        </button>\n" +
                "        <button type=\"submit\" id=\"saveBtn\" style=\"display: none; background: var(--primary); color: white; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer;\">\n" +
                "            <i class=\"fas fa-save\"></i> Save Changes\n" +
                "        </button>\n" +
                "    </div>\n" +
                "</form>";

            content = content.substring(0, startIdx) + formContent + content.substring(endIdx + 7);
            
            // Also fix the JS to show the picUpload button
            content = content.replace("document.getElementById('editBtn').style.display = 'none';", "document.getElementById('editBtn').style.display = 'none';\n        document.getElementById('picLabel').style.display = 'inline-block';");
            content = content.replace("document.getElementById('editBtn').style.display = 'inline-flex';", "document.getElementById('editBtn').style.display = 'inline-flex';\n        document.getElementById('picLabel').style.display = 'none';");
            
            Files.write(path, content.getBytes(StandardCharsets.UTF_8));
        }
    }
}
