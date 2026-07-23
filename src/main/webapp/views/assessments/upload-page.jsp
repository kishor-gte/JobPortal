<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Upload Assessment Questions | JobU Admin - Skill Assessment Manager</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    
    <style>
        /* ============================================
           PREMIUM COLOR SCHEME
           --primary: #19A77B
           --primary-dark: #148F69
           --accent: #3BC49A
           --bg-dark: #2E3E41
        ============================================ */
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --accent-light: #6ed4b2;
            --bg-dark: #2E3E41;
            --bg-dark-light: #3d5256;
            --bg-light: #eef3f0;
            --card-bg: rgba(255, 255, 255, 0.98);
            --text-dark: #1e2a2e;
            --text-muted: #5b7c6e;
            --success: #19A77B;
            --warning: #f59e0b;
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
            --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.08);
            --shadow-xl: 0 25px 50px -12px rgba(25, 167, 123, 0.25);
            --transition: all 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            --radius-sm: 12px;
            --radius-md: 16px;
            --radius-lg: 24px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: radial-gradient(ellipse at 20% 30%, #eef7f2 0%, #e0ece6 100%);
            color: var(--text-dark);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* animated background mesh */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 15% 30%, rgba(25,167,123,0.05) 0%, transparent 40%),
                radial-gradient(circle at 85% 70%, rgba(59,196,154,0.04) 0%, transparent 45%),
                radial-gradient(circle at 50% 90%, rgba(25,167,123,0.03) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: meshFloat 18s ease-in-out infinite alternate;
        }

        @keyframes meshFloat {
            0% { opacity: 0.5; transform: scale(1); }
            100% { opacity: 1; transform: scale(1.03); }
        }

        /* floating particles */
        body::after {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(circle at 20% 40%, rgba(25,167,123,0.06) 1px, transparent 1px);
            background-size: 32px 32px;
            pointer-events: none;
            animation: particleDrift 25s linear infinite;
        }

        @keyframes particleDrift {
            0% { background-position: 0 0; }
            100% { background-position: 65px 65px; }
        }

        /* floating decorative shapes */
        .floating-shape {
            position: fixed;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            opacity: 0.03;
            pointer-events: none;
            z-index: 0;
            filter: blur(45px);
        }

        /* Page Header Premium */
        .page-header {
            background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 2.5rem 0;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(59,196,154,0.15), transparent);
            border-radius: 50%;
            animation: floatGlow 15s ease-in-out infinite;
        }

        @keyframes floatGlow {
            0%, 100% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(-30px, 20px) scale(1.1); }
        }

        .page-header h1 {
            font-size: 2rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .page-header p {
            font-size: 1rem;
            opacity: 0.85;
            position: relative;
            z-index: 1;
        }

        /* Upload Card Premium */
        .upload-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            padding: 3rem;
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.1);
            max-width: 750px;
            margin: 0 auto;
            transition: var(--transition);
            animation: fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px) scale(0.96); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .upload-card:hover {
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        /* Upload Icon */
        .upload-icon {
            width: 90px;
            height: 90px;
            border-radius: 28px;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.06));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            color: var(--primary);
            margin: 0 auto 1.5rem;
            transition: var(--transition);
            animation: gentlePulse 2.5s ease-in-out infinite;
        }

        @keyframes gentlePulse {
            0%, 100% { box-shadow: 0 0 0 0 rgba(25,167,123,0.2); }
            50% { box-shadow: 0 0 0 15px rgba(25,167,123,0); }
        }

        /* Info Box */
        .info-box {
            background: rgba(25,167,123,0.06);
            border-left: 4px solid var(--primary);
            border-radius: var(--radius-sm);
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
            font-size: 0.85rem;
            color: var(--text-dark);
            transition: var(--transition);
        }

        .info-box i {
            color: var(--primary);
            margin-right: 0.5rem;
        }

        /* Form Elements */
        .form-label {
            font-weight: 700;
            color: var(--bg-dark);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .form-label i {
            color: var(--primary);
        }

        .form-control, .form-select {
            border-radius: var(--radius-sm);
            border: 2px solid #e2ede7;
            padding: 0.75rem 1rem;
            font-size: 0.9rem;
            transition: var(--transition);
            background: white;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.12);
            outline: none;
        }

        /* File Upload Premium */
        .file-upload-wrapper {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .file-upload-input {
            position: relative;
            overflow: hidden;
            width: 100%;
        }

        .file-upload-input input[type=file] {
            position: absolute;
            left: -9999px;
        }

        .file-upload-label {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            padding: 1.5rem;
            border: 2px dashed #e2ede7;
            border-radius: var(--radius-md);
            background: rgba(25,167,123,0.02);
            color: var(--text-muted);
            cursor: pointer;
            transition: var(--transition);
            flex-direction: column;
            text-align: center;
        }

        .file-upload-label:hover {
            border-color: var(--primary);
            background: rgba(25,167,123,0.05);
            color: var(--primary);
            transform: translateY(-2px);
        }

        .file-upload-label.has-file {
            border-color: var(--success);
            background: rgba(25, 167, 123, 0.05);
            color: var(--success);
        }

        .file-upload-icon {
            font-size: 2.5rem;
        }

        /* Checkbox Premium */
        .form-check {
            margin-top: 1.5rem;
            padding: 1rem 1.25rem;
            background: rgba(245, 158, 11, 0.06);
            border-radius: var(--radius-sm);
            border-left: 4px solid var(--warning);
            transition: var(--transition);
        }

        .form-check:hover {
            background: rgba(245, 158, 11, 0.1);
        }

        .form-check-input {
            width: 1.2rem;
            height: 1.2rem;
            cursor: pointer;
            accent-color: var(--warning);
        }

        .form-check-label {
            font-weight: 600;
            color: var(--text-dark);
            cursor: pointer;
            margin-left: 0.5rem;
        }

        /* Button Premium */
        .btn-upload {
            width: 100%;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1rem;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            margin-top: 1.5rem;
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            box-shadow: 0 8px 20px -8px rgba(25,167,123,0.4);
        }

        .btn-upload:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px -10px rgba(25,167,123,0.5);
        }

        .btn-upload i {
            transition: transform 0.2s;
        }

        .btn-upload:hover i {
            transform: translateY(-2px);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 1.5rem 0; }
            .page-header h1 { font-size: 1.5rem; }
            .upload-card { padding: 2rem 1.5rem; margin: 0 1rem; }
            .upload-icon { width: 70px; height: 70px; font-size: 2rem; }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }

        ::selection { background: var(--primary); color: white; }
    </style>
<jsp:include page="/views/commons/admin_shell_head.jsp" />
</head>
<body>

<jsp:include page="/views/commons/admin_shell_start.jsp">
  <jsp:param name="pageTitle" value="Assessment Questions"/>
  <jsp:param name="pageSubtitle" value="Add and manage assessment questions"/>
  <jsp:param name="activeNav" value="assessments"/>
</jsp:include>

<!-- decorative floating elements -->
<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <a href="${pageContext.request.contextPath}/dashboard" style="display: inline-flex; align-items: center; gap: 0.5rem; color: white; text-decoration: none; font-size: 0.85rem; font-weight: 600; background: rgba(255,255,255,0.15); backdrop-filter: blur(8px); padding: 0.4rem 1rem; border-radius: 40px; margin-bottom: 0.75rem; transition: all 0.3s ease; border: 1px solid rgba(255,255,255,0.2);" onmouseover="this.style.background='rgba(255,255,255,0.25)'" onmouseout="this.style.background='rgba(255,255,255,0.15)'">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
        <h1><i class="fas fa-file-upload me-2" style="color: var(--accent);"></i>Upload Assessment Questions</h1>
        <p>Upload Excel file containing assessment questions for skills</p>
    </div>
</div>

<div class="container">
    <div class="upload-card">
        <!-- Upload Icon -->
        <div class="upload-icon">
            <i class="fas fa-file-excel"></i>
        </div>

        <!-- Info Box -->
        <div class="info-box">
            <i class="fas fa-info-circle"></i>
            <strong>Note:</strong> Please upload an Excel file (.xlsx) with the required format. The file should contain columns for questions, options, and correct answers.
        </div>

        <!-- Upload Form -->
        <form action="${pageContext.request.contextPath}/admin/assessments/upload" 
              method="post" 
              enctype="multipart/form-data" 
              id="uploadForm">
            
            <!-- Hidden fields -->
            <input type="hidden" name="recruiterId" value="${recruiterId}" />
            <input type="hidden" name="jobId" value="${jobId}" />

            <!-- Skill Input -->
            <div class="mb-4">
                <label for="skill" class="form-label">
                    <i class="fas fa-code"></i>
                    Skill Name
                </label>
                <input 
                    type="text" 
                    class="form-control" 
                    id="skill" 
                    name="skill" 
                    placeholder="e.g. Java, Python, JavaScript" 
                    required>
                <div class="form-text" style="font-size: 0.7rem; color: var(--text-muted); margin-top: 0.5rem;">Enter the skill name for these assessment questions</div>
            </div>

            <!-- File Upload -->
            <div class="mb-4">
                <label class="form-label">
                    <i class="fas fa-file-excel"></i>
                    Excel File (.xlsx)
                </label>
                <div class="file-upload-wrapper">
                    <div class="file-upload-input">
                        <input 
                            type="file" 
                            id="fileInput" 
                            name="file" 
                            accept=".xlsx" 
                            required 
                            onchange="handleFileSelect(event)">
                        <label for="fileInput" class="file-upload-label" id="fileLabel">
                            <i class="fas fa-cloud-upload-alt file-upload-icon"></i>
                            <span>Click to select Excel file or drag and drop</span>
                            <small style="font-size: 0.7rem;">Only .xlsx files are accepted</small>
                        </label>
                    </div>
                </div>
            </div>

            <!-- Replace Option -->
            <div class="form-check">
                <input 
                    class="form-check-input" 
                    type="checkbox" 
                    id="replace" 
                    name="replace">
                <label class="form-check-label" for="replace">
                    <i class="fas fa-sync-alt me-1"></i>
                    Replace existing questions for this skill
                </label>
                <div class="form-text mt-1" style="font-size: 0.7rem; color: var(--text-muted); margin-left: 1.8rem;">
                    If checked, all existing questions for this skill will be deleted before uploading new ones
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn-upload">
                <i class="fas fa-upload"></i>
                Upload Questions
            </button>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
function handleFileSelect(event) {
    const fileInput = event.target;
    const fileLabel = document.getElementById('fileLabel');
    
    if (fileInput.files && fileInput.files.length > 0) {
        const file = fileInput.files[0];
        fileLabel.classList.add('has-file');
        fileLabel.innerHTML = `
            <i class="fas fa-check-circle file-upload-icon"></i>
            <span style="font-weight: 600;">${file.name}</span>
            <small style="font-size: 0.7rem;">Click to change file</small>
        `;
    } else {
        fileLabel.classList.remove('has-file');
        fileLabel.innerHTML = `
            <i class="fas fa-cloud-upload-alt file-upload-icon"></i>
            <span>Click to select Excel file or drag and drop</span>
            <small style="font-size: 0.7rem;">Only .xlsx files are accepted</small>
        `;
    }
}

// Form validation
document.getElementById('uploadForm').addEventListener('submit', function(e) {
    const skillInput = document.getElementById('skill');
    const fileInput = document.getElementById('fileInput');
    
    if (!skillInput.value.trim()) {
        e.preventDefault();
        alert('Please enter a skill name');
        skillInput.focus();
        return false;
    }
    
    if (!fileInput.files || fileInput.files.length === 0) {
        e.preventDefault();
        alert('Please select an Excel file to upload');
        return false;
    }
    
    const file = fileInput.files[0];
    if (!file.name.endsWith('.xlsx')) {
        e.preventDefault();
        alert('Please select a valid Excel file (.xlsx)');
        return false;
    }
});

// Preserved original mobile responsive script
document.addEventListener('DOMContentLoaded', function() {
    if (!document.getElementById('mobile-responsive-style')) {
        const style = document.createElement('style');
        style.id = 'mobile-responsive-style';
        style.innerHTML = `@media (max-width: 768px) { .sidebar, .nav-sidebar { transform: translateX(-100%); transition: transform 0.3s ease; position: fixed !important; z-index: 1001 !important; height: 100vh; } .sidebar.active, .nav-sidebar.active { transform: translateX(0); box-shadow: 2px 0 20px rgba(0,0,0,0.2) !important; } .main-content { margin-left: 0 !important; padding: 16px !important; width: 100% !important; max-width: 100% !important; } .stats-grid, .content-grid, .grid, .hr-stats-grid, .hr-content-grid, .profile-grid, .dashboard-grid { grid-template-columns: 1fr !important; display: grid !important; } .top-bar { flex-direction: column !important; align-items: flex-start !important; gap: 16px; } .chat-header { flex-wrap: wrap; gap: 12px; } .top-bar h1, .chat-header h3 { font-size: 22px !important; display: flex; align-items: center; } .mobile-menu-btn { display: inline-block !important; background: none; border: none; font-size: 24px; color: inherit; cursor: pointer; margin-right: 12px; } .mobile-overlay { display: none; position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); z-index: 1000; } .mobile-overlay.active { display: block; } .chat-sidebar { position: fixed !important; transform: translateX(-100%); transition: transform 0.3s; z-index: 1000; } .chat-sidebar.active { transform: translateX(0); } table:not(.table-responsive), table:not(.table-responsive) thead, table:not(.table-responsive) tbody, table:not(.table-responsive) th, table:not(.table-responsive) td, table:not(.table-responsive) tr { display: block; } table:not(.table-responsive) thead tr { position: absolute; top: -9999px; left: -9999px; } table:not(.table-responsive) tr { border: 1px solid #e2e8f0; margin-bottom: 12px; border-radius: 8px; overflow:hidden; } table:not(.table-responsive) td { border: none; border-bottom: 1px solid #f1f5f9; position: relative; padding-left: 50% !important; text-align: right; font-size: 14px; } table:not(.table-responsive) td:last-child { border-bottom: none; } table:not(.table-responsive) td:before { position: absolute; top: 50%; transform: translateY(-50%); left: 12px; width: 45%; padding-right: 10px; white-space: nowrap; content: attr(data-label); font-weight: 600; text-align: left; color: #64748b; } } .mobile-menu-btn { display: none; }`;
        document.head.appendChild(style);
    }
    
    const sidebar = document.querySelector('.sidebar') || document.querySelector('.nav-sidebar');
    if (sidebar) {
        const topBar = document.querySelector('.top-bar') || document.querySelector('.chat-header') || document.querySelector('.dashboard-header') || document.body;
        let heading = null;
        if (topBar && topBar !== document.body) heading = topBar.querySelector('h1') || topBar.querySelector('.chat-header-info') || topBar.querySelector('h2');
        if (!heading && !document.querySelector('.mobile-menu-btn')) { heading = document.createElement('div'); heading.style.padding = '10px'; document.body.insertBefore(heading, document.body.firstChild); }
        if (heading && !document.querySelector('.mobile-menu-btn')) {
            heading.style.display = 'flex'; heading.style.alignItems = 'center';
            const toggleBtn = document.createElement('button'); toggleBtn.className = 'mobile-menu-btn'; toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
            heading.insertBefore(toggleBtn, heading.firstChild);
            const overlay = document.createElement('div'); overlay.className = 'mobile-overlay'; document.body.appendChild(overlay);
            let touchstartX = 0, touchendX = 0;
            document.body.addEventListener('touchstart', e => { touchstartX = e.changedTouches[0].screenX; }, {passive: true});
            document.body.addEventListener('touchend', e => { touchendX = e.changedTouches[0].screenX; if (touchendX < touchstartX - 50) closeSidebar(); if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); }, {passive: true});
            function openSidebar() { sidebar.classList.add('active'); overlay.classList.add('active'); document.body.style.overflow = 'hidden'; }
            function closeSidebar() { sidebar.classList.remove('active'); overlay.classList.remove('active'); document.body.style.overflow = ''; }
            toggleBtn.addEventListener('click', openSidebar); overlay.addEventListener('click', closeSidebar);
        }
    }
    
    const tables = document.querySelectorAll('table:not(.table-responsive)');
    tables.forEach(table => {
        const headers = Array.from(table.querySelectorAll('th')).map(th => th.innerText);
        const rows = Array.from(table.querySelectorAll('tbody tr'));
        rows.forEach(row => { Array.from(row.querySelectorAll('td')).forEach((td, index) => { if(headers[index]) td.setAttribute('data-label', headers[index]); }); });
    });
});
</script>
<jsp:include page="/views/commons/admin_shell_end.jsp" />
</body>
</html>