<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Upload Skill Assessment Questions | JobU Admin</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
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

        .floating-shape {
            position: fixed;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            opacity: 0.03;
            pointer-events: none;
            z-index: 0;
            filter: blur(45px);
        }

        /* Premium Card */
        .upload-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.1);
            padding: 2.5rem;
            max-width: 600px;
            width: 100%;
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

        /* Card Accent Border */
        .upload-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--accent), var(--primary));
            border-radius: var(--radius-lg) var(--radius-lg) 0 0;
        }

        /* Header */
        .card-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .icon-wrapper {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.06));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            animation: gentlePulse 2.5s ease-in-out infinite;
        }

        @keyframes gentlePulse {
            0%, 100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(25,167,123,0.2); }
            50% { transform: scale(1.05); box-shadow: 0 0 0 15px rgba(25,167,123,0); }
        }

        .icon-wrapper i {
            font-size: 2.5rem;
            color: var(--primary);
        }

        h2 {
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 0.5rem;
            letter-spacing: -0.5px;
        }

        .subtitle {
            color: var(--text-muted);
            font-size: 0.85rem;
        }

        /* Form Elements */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 700;
            color: var(--bg-dark);
            margin-bottom: 0.5rem;
            display: block;
            font-size: 0.85rem;
            letter-spacing: 0.3px;
        }

        .form-label i {
            color: var(--primary);
            margin-right: 0.5rem;
        }

        .form-select {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e2ede7;
            border-radius: var(--radius-sm);
            font-size: 0.9rem;
            transition: var(--transition);
            background: white;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
        }

        .form-select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.12);
        }

        /* File Upload */
        .file-upload-wrapper {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .file-upload-label {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            padding: 1.2rem;
            border: 2px dashed #e2ede7;
            border-radius: var(--radius-md);
            background: rgba(25,167,123,0.02);
            color: var(--text-muted);
            cursor: pointer;
            transition: var(--transition);
            text-align: center;
            flex-direction: column;
        }

        .file-upload-label:hover {
            border-color: var(--primary);
            background: rgba(25,167,123,0.05);
            color: var(--primary);
            transform: translateY(-2px);
        }

        .file-upload-label.has-file {
            border-color: var(--primary);
            background: rgba(25,167,123,0.05);
            color: var(--primary);
        }

        .file-upload-icon {
            font-size: 2rem;
        }

        input[type="file"] {
            position: absolute;
            left: -9999px;
        }

        /* Checkbox */
        .checkbox-wrapper {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
            padding: 0.75rem;
            background: rgba(245, 158, 11, 0.06);
            border-radius: var(--radius-sm);
            border-left: 4px solid var(--warning);
        }

        .checkbox-wrapper input {
            width: 18px;
            height: 18px;
            accent-color: var(--warning);
            cursor: pointer;
        }

        .checkbox-wrapper label {
            margin: 0;
            cursor: pointer;
            font-weight: 500;
        }

        /* Submit Button */
        .btn-submit {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: 0.9rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1rem;
            transition: var(--transition);
            cursor: pointer;
            width: 100%;
            box-shadow: 0 8px 20px -8px rgba(25,167,123,0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px -10px rgba(25,167,123,0.5);
        }

        /* Responsive */
        @media (max-width: 576px) {
            body { padding: 1rem; }
            .upload-card { padding: 1.5rem; }
            h2 { font-size: 1.4rem; }
            .icon-wrapper { width: 65px; height: 65px; }
            .icon-wrapper i { font-size: 2rem; }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }

        ::selection { background: var(--primary); color: white; }
    </style>
</head>
<body>

<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<div class="upload-card">
    <div class="card-header">
        <div class="icon-wrapper">
            <i class="fas fa-file-excel"></i>
        </div>
        <h2>Upload Skill Assessment</h2>
        <p class="subtitle">Upload Excel file with assessment questions</p>
    </div>

    <form action="${pageContext.request.contextPath}/assessments/upload" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label class="form-label" for="skillSelect">
                <i class="fas fa-code"></i> Select Skill
            </label>
            <select name="skill" id="skillSelect" class="form-select" required>
                <option value="Java">Java</option>
                <option value="Python">Python</option>
            </select>
        </div>

        <div class="file-upload-wrapper">
            <label for="fileInput" class="file-upload-label" id="fileLabel">
                <i class="fas fa-cloud-upload-alt file-upload-icon"></i>
                <span>Click to select Excel file</span>
                <small style="font-size: 0.7rem;">Only .xlsx files are accepted</small>
            </label>
            <input type="file" id="fileInput" name="file" accept=".xlsx" required onchange="handleFileSelect(this)" />
        </div>

        <div class="checkbox-wrapper">
            <input type="checkbox" name="replace" id="replaceCheckbox" />
            <label for="replaceCheckbox">
                <i class="fas fa-sync-alt"></i> Replace Existing Questions
            </label>
        </div>

        <button type="submit" class="btn-submit">
            <i class="fas fa-upload"></i> Upload Questions
        </button>
    </form>
</div>

<script>
function handleFileSelect(input) {
    const fileLabel = document.getElementById('fileLabel');
    if (input.files && input.files.length > 0) {
        const file = input.files[0];
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
            <span>Click to select Excel file</span>
            <small style="font-size: 0.7rem;">Only .xlsx files are accepted</small>
        `;
    }
}

// Form validation
document.querySelector('form').addEventListener('submit', function(e) {
    const fileInput = document.getElementById('fileInput');
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
        style.innerHTML = `@media (max-width: 768px) { .sidebar, .nav-sidebar { transform: translateX(-100%); transition: transform 0.3s ease; position: fixed !important; z-index: 1001 !important; height: 100vh; } .sidebar.active, .nav-sidebar.active { transform: translateX(0); box-shadow: 2px 0 20px rgba(0,0,0,0.2) !important; } .main-content { margin-left: 0 !important; padding: 16px !important; width: 100% !important; max-width: 100% !important; } } .mobile-menu-btn { display: none; }`;
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
</body>
</html>