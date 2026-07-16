import os
import re

directory = r"c:\Users\NEHA\OneDrive\Desktop\jp\JobPortal\src\main\webapp\views\techperson"

sidebar_html = """    <div class="sidebar" id="mainSidebar">
        <div class="sidebar-logo">
            <div class="icon"><i class="fas fa-laptop-code"></i></div>
            <h2>Tech Person</h2>
        </div>
        <div class="nav-section">
            <h4>Overview</h4>
            <a href="${pageContext.request.contextPath}/tech/dashboard" class="nav-link">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
        </div>
        <div class="nav-section">
            <h4>Management</h4>
            <a href="${pageContext.request.contextPath}/tech/manage-users" class="nav-link">
                <i class="fas fa-users-cog"></i> Manage Users
            </a>
            <a href="${pageContext.request.contextPath}/tech/manage-questions" class="nav-link">
                <i class="fas fa-question-circle"></i> Manage Questions
            </a>
            <a href="${pageContext.request.contextPath}/tech/manage-categories" class="nav-link">
                <i class="fas fa-tags"></i> Manage Categories
            </a>
        </div>
        <div class="nav-section">
            <h4>Evaluation</h4>
            <a href="${pageContext.request.contextPath}/tech/results" class="nav-link">
                <i class="fas fa-poll"></i> Results
            </a>
            <a href="${pageContext.request.contextPath}/tech/ai-evaluation" class="nav-link">
                <i class="fas fa-robot"></i> AI Evaluation
            </a>
        </div>
        <div class="nav-section">
            <h4>Competitions</h4>
            <a href="${pageContext.request.contextPath}/tech/conduct-competition" class="nav-link">
                <i class="fas fa-trophy"></i> Conduct Competition
            </a>
            <a href="${pageContext.request.contextPath}/tech/manage-competitions" class="nav-link">
                <i class="fas fa-tasks"></i> Manage Competitions
            </a>
            <a href="${pageContext.request.contextPath}/tech/competition-results" class="nav-link">
                <i class="fas fa-chart-bar"></i> Competition Results
            </a>
            <a href="${pageContext.request.contextPath}/tech/competition-recordings" class="nav-link">
                <i class="fas fa-video"></i> Competition Recordings
            </a>
        </div>
        <div class="nav-section">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/tech/logout" class="nav-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>"""

# Find <div class="sidebar" id="mainSidebar"> ... </div>
# which is followed by <div class="main-content">
pattern = re.compile(r'<div class="sidebar"\s+id="mainSidebar">.*?(?=</div>\s*<div class="main-content">)</div>', re.DOTALL)

for filename in os.listdir(directory):
    if filename.endswith(".jsp"):
        filepath = os.path.join(directory, filename)
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # determine active link to keep it highlighted, based on filename
        # this is tricky since we replace it, but we can do a quick active class addition after replacement
        
        new_content = pattern.sub(sidebar_html, content)
        
        # Add active class based on file
        if filename == "dashboard.jsp":
            new_content = new_content.replace('href="${pageContext.request.contextPath}/tech/dashboard" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/dashboard" class="nav-link active"')
        elif filename == "manage-users.jsp" or filename.startswith("manage-users-"):
            new_content = new_content.replace('href="${pageContext.request.contextPath}/tech/manage-users" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/manage-users" class="nav-link active"')
        elif filename == "manage-questions.jsp" or filename == "add-coding-question.jsp" or filename == "add-interview-question.jsp":
            new_content = new_content.replace('href="${pageContext.request.contextPath}/tech/manage-questions" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/manage-questions" class="nav-link active"')
        elif filename == "manage-categories.jsp":
            new_content = new_content.replace('href="${pageContext.request.contextPath}/tech/manage-categories" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/manage-categories" class="nav-link active"')
        elif filename == "results.jsp":
            new_content = new_content.replace('href="${pageContext.request.contextPath}/tech/results" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/results" class="nav-link active"')
        elif filename == "ai-evaluation.jsp":
            new_content = new_content.replace('href="${pageContext.request.contextPath}/tech/ai-evaluation" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/ai-evaluation" class="nav-link active"')
        elif filename == "conduct-competition.jsp":
            new_content = new_content.replace('href="${pageContext.request.contextPath}/tech/conduct-competition" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/conduct-competition" class="nav-link active"')
        elif filename == "manage-competitions.jsp" or filename == "edit-competition.jsp":
            new_content = new_content.replace('href="${pageContext.request.contextPath}/tech/manage-competitions" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/manage-competitions" class="nav-link active"')
        elif filename == "competition-results.jsp":
            new_content = new_content.replace('href="${pageContext.request.contextPath}/tech/competition-results" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/competition-results" class="nav-link active"')
        elif filename == "competition-recordings.jsp":
            new_content = new_content.replace('href="${pageContext.request.contextPath}/tech/competition-recordings" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/competition-recordings" class="nav-link active"')
            
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        
        print(f"Updated {filename}")
