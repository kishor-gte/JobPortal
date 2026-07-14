$path = "c:\Users\NEHA\OneDrive\Desktop\jp\JobPortal\src\main\webapp\views\techperson\profile.jsp"
$content = [System.IO.File]::ReadAllText($path)

$styleFind = @'
        body.light-mode .btn-logout {
            background: rgba(239, 68, 68, 0.05) !important;
            border-color: rgba(239, 68, 68, 0.2) !important;
            color: #ef4444 !important;
        }
    </style>
'@

$styleReplace = @'
        body.light-mode .btn-logout {
            background: rgba(239, 68, 68, 0.05) !important;
            border-color: rgba(239, 68, 68, 0.2) !important;
            color: #ef4444 !important;
        }
        /* Profile Styles */
        .profile-card { background: rgba(255, 255, 255, 0.95); border: 1px solid var(--border-color); border-radius: var(--radius-lg); padding: 30px; backdrop-filter: blur(20px); max-width: 800px; margin: 0 auto; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #fff; }
        .form-control { width: 100%; padding: 12px 16px; border: 1px solid var(--border-color); border-radius: 12px; font-family: 'Inter', sans-serif; font-size: 15px; transition: var(--transition); background: rgba(0,0,0,0.2); color: #fff; }
        .form-control:focus { outline: none; border-color: var(--primary); box-shadow: 0 0 0 3px rgba(25, 167, 123, 0.1); background: rgba(0,0,0,0.4); }
        .form-control:disabled { background: rgba(255,255,255,0.05); color: rgba(255,255,255,0.5); cursor: not-allowed; border-color: transparent; }
        .btn-edit, .btn-save { padding: 12px 24px; border: none; border-radius: 12px; font-weight: 600; font-size: 15px; cursor: pointer; transition: var(--transition); display: inline-flex; align-items: center; gap: 8px; box-shadow: var(--shadow-sm); color: white; }
        .btn-edit { background: var(--gradient-primary); }
        .btn-save { background: #10b981; display: none; }
        .btn-edit:hover, .btn-save:hover { transform: translateY(-2px); box-shadow: var(--shadow-md); }
        .profile-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; border-bottom: 1px solid var(--border-color); padding-bottom: 20px; }
        .profile-title { font-size: 24px; font-weight: 700; color: #fff; display: flex; align-items: center; gap: 12px; }
        body.light-mode .profile-card { background: #ffffff; border-color: #e2e8f0; }
        body.light-mode .form-group label { color: #1e293b; }
        body.light-mode .profile-title { color: #0f172a; }
        body.light-mode .form-control { border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b; }
        body.light-mode .form-control:focus { background: #fff; }
        body.light-mode .form-control:disabled { background: #f1f5f9; color: #64748b; }
    </style>
'@

# Normalize line endings to find the string robustly
$content = $content.Replace("`r`n", "`n")
$styleFind = $styleFind.Replace("`r`n", "`n")
$content = $content.Replace($styleFind, $styleReplace)

$navFind1 = 'href="${pageContext.request.contextPath}/tech/dashboard" class="nav-link active"'
$navReplace1 = 'href="${pageContext.request.contextPath}/tech/dashboard" class="nav-link"'
$content = $content.Replace($navFind1, $navReplace1)

$navFind2 = 'href="${pageContext.request.contextPath}/tech/profile" class="nav-link"'
$navReplace2 = 'href="${pageContext.request.contextPath}/tech/profile" class="nav-link active"'
$content = $content.Replace($navFind2, $navReplace2)

$headerFind = '<h1><i class="fas fa-shield-halved"></i> Tech Person Dashboard</h1>'
$headerReplace = '<h1><i class="fas fa-user"></i> Profile</h1>'
$content = $content.Replace($headerFind, $headerReplace)

$startIdx = $content.IndexOf("        <!-- Stats Row 1 -->")
$endIdx = $content.IndexOf("    </div>`n`n    <script>`n        // Sidebar Toggle for Mobile")
if ($endIdx -eq -1) {
    $endIdx = $content.IndexOf("    </div>`n    `n    <script>")
}
if ($endIdx -eq -1) {
    $endIdx = $content.IndexOf("    </div>`n    <script>")
}

if ($startIdx -ne -1 -and $endIdx -ne -1) {
    $profileForm = @'
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-title">
                    <i class="fas fa-user-circle" style="color: var(--primary); font-size: 32px;"></i>
                    Tech Person Profile
                </div>
                <button type="button" class="btn-edit" id="editBtn" onclick="enableEdit()">
                    <i class="fas fa-edit"></i> Edit Profile
                </button>
            </div>

            <c:if test="${not empty message}">
                <div style="background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 12px; border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(16, 185, 129, 0.3);">
                    ${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div style="background: rgba(239, 68, 68, 0.1); color: #ef4444; padding: 12px; border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(239, 68, 68, 0.3);">
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/tech/profile/update" method="POST" id="profileForm">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" class="form-control" name="name" value="${techPerson.name}" disabled required>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" class="form-control" name="email" value="${techPerson.email}" disabled required>
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" class="form-control" name="phone" value="${techPerson.phone}" disabled required>
                </div>
                <div class="form-group">
                    <label>New Password (leave blank to keep current)</label>
                    <input type="password" class="form-control" name="password" placeholder="Enter new password" disabled>
                </div>
                
                <div style="text-align: right; margin-top: 30px;">
                    <button type="button" class="btn-logout" id="cancelBtn" style="display: none; display: inline-flex; margin-right: 12px;" onclick="cancelEdit()">
                        Cancel
                    </button>
                    <button type="submit" class="btn-save" id="saveBtn">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                </div>
            </form>
        </div>
'@
    $jsFunctions = @'

    <script>
        function enableEdit() {
            const inputs = document.querySelectorAll('#profileForm .form-control');
            inputs.forEach(input => input.disabled = false);
            document.getElementById('editBtn').style.display = 'none';
            document.getElementById('saveBtn').style.display = 'inline-flex';
            document.getElementById('cancelBtn').style.display = 'inline-flex';
        }

        function cancelEdit() {
            const inputs = document.querySelectorAll('#profileForm .form-control');
            inputs.forEach(input => input.disabled = true);
            document.getElementById('editBtn').style.display = 'inline-flex';
            document.getElementById('saveBtn').style.display = 'none';
            document.getElementById('cancelBtn').style.display = 'none';
            document.getElementById('profileForm').reset();
        }
'@
    
    $content = $content.Substring(0, $startIdx) + $profileForm + "`n    </div>`n" + $jsFunctions + $content.Substring($endIdx + 11)
} else {
    Write-Host "Could not find start/end bounds for profile form replacement"
    Write-Host "Start: $startIdx, End: $endIdx"
}

[System.IO.File]::WriteAllText($path, $content)
