$directory = "c:\Users\NEHA\OneDrive\Desktop\jp\JobPortal\src\main\webapp\views\techperson"

$sidebarHtml = @"
    <div class="sidebar" id="mainSidebar">
        <div class="sidebar-logo">
            <div class="icon"><i class="fas fa-laptop-code"></i></div>
            <h2>Tech Person</h2>
        </div>
        <div class="nav-section">
            <h4>Overview</h4>
            <a href="`${pageContext.request.contextPath}/tech/dashboard" class="nav-link">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
        </div>
        <div class="nav-section">
            <h4>Management</h4>
            <a href="`${pageContext.request.contextPath}/tech/manage-users" class="nav-link">
                <i class="fas fa-users-cog"></i> Manage Users
            </a>
            <a href="`${pageContext.request.contextPath}/tech/manage-questions" class="nav-link">
                <i class="fas fa-question-circle"></i> Manage Questions
            </a>
            <a href="`${pageContext.request.contextPath}/tech/manage-categories" class="nav-link">
                <i class="fas fa-tags"></i> Manage Categories
            </a>
        </div>
        <div class="nav-section">
            <h4>Evaluation</h4>
            <a href="`${pageContext.request.contextPath}/tech/results" class="nav-link">
                <i class="fas fa-poll"></i> Results
            </a>
            <a href="`${pageContext.request.contextPath}/tech/ai-evaluation" class="nav-link">
                <i class="fas fa-robot"></i> AI Evaluation
            </a>
        </div>
        <div class="nav-section">
            <h4>Competitions</h4>
            <a href="`${pageContext.request.contextPath}/tech/conduct-competition" class="nav-link">
                <i class="fas fa-trophy"></i> Conduct Competition
            </a>
            <a href="`${pageContext.request.contextPath}/tech/manage-competitions" class="nav-link">
                <i class="fas fa-tasks"></i> Manage Competitions
            </a>
            <a href="`${pageContext.request.contextPath}/tech/competition-results" class="nav-link">
                <i class="fas fa-chart-bar"></i> Competition Results
            </a>
            <a href="`${pageContext.request.contextPath}/tech/competition-recordings" class="nav-link">
                <i class="fas fa-video"></i> Competition Recordings
            </a>
        </div>
        <div class="nav-section">
            <h4>Account</h4>
            <a href="`${pageContext.request.contextPath}/logout" class="nav-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
"@

$files = Get-ChildItem -Path $directory -Filter "*.jsp"
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    $newContent = $content -replace '(?s)<div class="sidebar" id="mainSidebar">.*?</div>\s*<div class="main-content">', "$sidebarHtml`r`n`r`n    <div class=`"main-content`">"
    
    if ($file.Name -eq "dashboard.jsp") {
        $newContent = $newContent -replace 'href="\$\{pageContext\.request\.contextPath\}/tech/dashboard" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/dashboard" class="nav-link active"'
    }
    elseif ($file.Name -match "manage-users") {
        $newContent = $newContent -replace 'href="\$\{pageContext\.request\.contextPath\}/tech/manage-users" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/manage-users" class="nav-link active"'
    }
    elseif ($file.Name -match "manage-questions" -or $file.Name -match "add-.*question") {
        $newContent = $newContent -replace 'href="\$\{pageContext\.request\.contextPath\}/tech/manage-questions" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/manage-questions" class="nav-link active"'
    }
    elseif ($file.Name -match "manage-categories") {
        $newContent = $newContent -replace 'href="\$\{pageContext\.request\.contextPath\}/tech/manage-categories" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/manage-categories" class="nav-link active"'
    }
    elseif ($file.Name -eq "results.jsp") {
        $newContent = $newContent -replace 'href="\$\{pageContext\.request\.contextPath\}/tech/results" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/results" class="nav-link active"'
    }
    elseif ($file.Name -eq "ai-evaluation.jsp") {
        $newContent = $newContent -replace 'href="\$\{pageContext\.request\.contextPath\}/tech/ai-evaluation" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/ai-evaluation" class="nav-link active"'
    }
    elseif ($file.Name -eq "conduct-competition.jsp") {
        $newContent = $newContent -replace 'href="\$\{pageContext\.request\.contextPath\}/tech/conduct-competition" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/conduct-competition" class="nav-link active"'
    }
    elseif ($file.Name -eq "manage-competitions.jsp" -or $file.Name -eq "edit-competition.jsp") {
        $newContent = $newContent -replace 'href="\$\{pageContext\.request\.contextPath\}/tech/manage-competitions" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/manage-competitions" class="nav-link active"'
    }
    elseif ($file.Name -eq "competition-results.jsp") {
        $newContent = $newContent -replace 'href="\$\{pageContext\.request\.contextPath\}/tech/competition-results" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/competition-results" class="nav-link active"'
    }
    elseif ($file.Name -eq "competition-recordings.jsp") {
        $newContent = $newContent -replace 'href="\$\{pageContext\.request\.contextPath\}/tech/competition-recordings" class="nav-link"', 'href="${pageContext.request.contextPath}/tech/competition-recordings" class="nav-link active"'
    }
    
    Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
    Write-Host "Updated $($file.Name)"
}
