import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.charset.StandardCharsets;
import java.io.IOException;

public class CreateJSPs {
    public static void main(String[] args) throws IOException {
        String basePath = "c:/Users/NEHA/git/JobPortal/src/main/webapp/views/techperson/";
        String content = new String(Files.readAllBytes(Paths.get(basePath + "conduct-competition.jsp")), StandardCharsets.UTF_8);

        String startMarker = "        <form id=\"competitionForm\" onsubmit=\"saveCompetition(event)\">";
        String endMarker = "        </form>";
        String scriptStart = "    <script>";
        String scriptEnd = "    </script>";

        int startIdx = content.indexOf(startMarker);
        int endIdx = content.indexOf(endMarker, startIdx);
        int scriptStartIdx = content.indexOf(scriptStart, endIdx);
        int scriptEndIdx = content.indexOf(scriptEnd, scriptStartIdx);

        if (startIdx != -1 && endIdx != -1 && scriptStartIdx != -1) {
            String topPart = content.substring(0, startIdx);
            String middlePart = content.substring(endIdx + endMarker.length(), scriptStartIdx);
            String bottomPart = content.substring(scriptEndIdx + scriptEnd.length());

            String manage = topPart + "            <div class=\"dashboard-header\">\n" +
                "                <div class=\"header-content\">\n" +
                "                    <h1>Manage Competitions</h1>\n" +
                "                    <p>View, edit, and publish your coding competitions.</p>\n" +
                "                </div>\n" +
                "            </div>\n" +
                "            \n" +
                "            <div class=\"competitions-grid\" style=\"display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; margin-top: 24px;\">\n" +
                "                <c:choose>\n" +
                "                    <c:when test=\"${not empty competitions}\">\n" +
                "                        <c:forEach var=\"comp\" items=\"${competitions}\">\n" +
                "                            <div class=\"form-card\" style=\"padding: 20px; animation: slideUp 0.5s ease-out forwards;\">\n" +
                "                                <div style=\"display:flex; justify-content:space-between; align-items:flex-start; margin-bottom: 12px;\">\n" +
                "                                    <h3 style=\"font-size:18px; margin:0; color:var(--text-primary);\">${comp.title}</h3>\n" +
                "                                    <span class=\"badge ${comp.status eq 'PUBLISHED' ? 'bg-success' : 'bg-warning'}\">${comp.status}</span>\n" +
                "                                </div>\n" +
                "                                <p style=\"color:var(--text-secondary); font-size:13px; margin-bottom: 16px;\">\n" +
                "                                    Difficulty: <strong>${comp.difficulty}</strong> | Questions: <strong>${comp.numberOfQuestions}</strong>\n" +
                "                                </p>\n" +
                "                                <div style=\"font-size:13px; color:var(--text-secondary); margin-bottom: 8px;\">\n" +
                "                                    <i class=\"fas fa-calendar-alt\"></i> ${comp.examStartTime}\n" +
                "                                </div>\n" +
                "                                <div style=\"font-size:13px; color:var(--text-secondary); margin-bottom: 20px;\">\n" +
                "                                    <i class=\"fas fa-users\"></i> Max: ${comp.maxParticipants}\n" +
                "                                </div>\n" +
                "                                <div style=\"display:flex; gap: 10px;\">\n" +
                "                                    <button class=\"btn-primary\" style=\"padding: 6px 12px; font-size: 13px; flex: 1;\">Edit</button>\n" +
                "                                    <button class=\"btn-secondary\" style=\"padding: 6px 12px; font-size: 13px; flex: 1; border-color: #ef4444; color: #ef4444;\">Delete</button>\n" +
                "                                </div>\n" +
                "                            </div>\n" +
                "                        </c:forEach>\n" +
                "                    </c:when>\n" +
                "                    <c:otherwise>\n" +
                "                        <div class=\"alert alert-info\" style=\"grid-column: 1 / -1; background: rgba(59, 130, 246, 0.1); color: #3b82f6; padding: 20px; border-radius: var(--radius-md); border: 1px solid rgba(59, 130, 246, 0.2);\">\n" +
                "                            <i class=\"fas fa-info-circle\"></i> You haven't created any competitions yet. <a href=\"conduct-competition\" style=\"color: #2563eb; font-weight: 600;\">Create one now</a>.\n" +
                "                        </div>\n" +
                "                    </c:otherwise>\n" +
                "                </c:choose>\n" +
                "            </div>\n" + middlePart + bottomPart;

            Files.write(Paths.get(basePath + "manage-competitions.jsp"), manage.getBytes(StandardCharsets.UTF_8));
            
            String results = topPart + "            <div class=\"dashboard-header\">\n" +
                "                <div class=\"header-content\">\n" +
                "                    <h1>Competition Results</h1>\n" +
                "                    <p>View leaderboards and detailed results of past competitions.</p>\n" +
                "                </div>\n" +
                "            </div>\n" +
                "            \n" +
                "            <div class=\"form-card\" style=\"margin-top: 24px;\">\n" +
                "                <div class=\"form-group\">\n" +
                "                    <label class=\"form-label\">Select Competition</label>\n" +
                "                    <select class=\"form-select\">\n" +
                "                        <option value=\"\">-- Choose a competition --</option>\n" +
                "                        <c:forEach var=\"comp\" items=\"${competitions}\">\n" +
                "                            <option value=\"${comp.id}\">${comp.title} (${comp.examStartTime})</option>\n" +
                "                        </c:forEach>\n" +
                "                    </select>\n" +
                "                </div>\n" +
                "                \n" +
                "                <div style=\"text-align:center; padding: 40px; color: var(--text-secondary);\">\n" +
                "                    <i class=\"fas fa-trophy\" style=\"font-size: 48px; color: #cbd5e1; margin-bottom: 16px; display:block;\"></i>\n" +
                "                    <p>Select a competition above to view its leaderboard and statistics.</p>\n" +
                "                </div>\n" +
                "            </div>\n" + middlePart + bottomPart;

            Files.write(Paths.get(basePath + "competition-results.jsp"), results.getBytes(StandardCharsets.UTF_8));
            System.out.println("JSP files generated successfully");
        } else {
            System.out.println("Markers not found");
        }
    }
}
