<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Seeker Login | SmartInterview</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
    :root {
        --primary: #19A77B;
        --primary-dark: #148F69;
        --accent: #3BC49A;
        --bg-dark: #2E3E41;
        --bg-darker: #1a2a2c;
        --bg-lighter: #3a4e51;
        --text-primary: #1e293b;
        --text-secondary: #475569;
        --text-tertiary: #64748b;
        --border-color: #e0e6ed;
        --card-bg: #ffffff;
        --hover-bg: rgba(25, 167, 123, 0.08);
        --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
        --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
        --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
        --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
        --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
        --success: #10b981;
        --warning: #f59e0b;
        --danger: #ef4444;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Inter', sans-serif;
        background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        min-height: 100vh;
        overflow-x: hidden;
        position: relative;
    }

    /* Animated background pattern */
    body::before {
        content: '';
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: 
            radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.03) 0%, transparent 50%),
            radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.03) 0%, transparent 50%);
        pointer-events: none;
        z-index: 0;
        animation: backgroundPulse 15s ease-in-out infinite;
    }

    @keyframes backgroundPulse {
        0%, 100% { opacity: 0.5; }
        50% { opacity: 1; }
    }

    .main-container {
        display: flex;
        min-height: 100vh;
        width: 100%;
        position: relative;
        z-index: 1;
    }

    /* LEFT SECTION */
    .image-section {
        flex: 1;
        background: var(--gradient-primary);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 40px 30px;
        position: relative;
        overflow: hidden;
    }

    .image-section::before {
        content: '';
        position: absolute;
        inset: 0;
        background:
            radial-gradient(circle at 20% 30%, rgba(255,255,255,0.1) 0%, transparent 50%),
            radial-gradient(circle at 80% 70%, rgba(255,255,255,0.08) 0%, transparent 50%);
        opacity: 0.6;
    }

    .image-content {
        position: relative;
        z-index: 1;
        text-align: center;
        color: white;
        max-width: 420px;
        animation: fadeIn 0.8s ease-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .image-content h1 {
        font-size: 36px;
        font-weight: 800;
        margin-bottom: 16px;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .image-content p {
        font-size: 16px;
        margin-bottom: 24px;
        opacity: 0.95;
    }

    .image-placeholder {
        width: 100%;
        max-width: 320px;
        height: 240px;
        background: rgba(255,255,255,0.15);
        border-radius: 24px;
        display: flex;
        align-items: center;
        justify-content: center;
        backdrop-filter: blur(10px);
        border: 2px solid rgba(255,255,255,0.2);
        box-shadow: var(--shadow-lg);
        margin: 0 auto;
        background-image: url('${pageContext.request.contextPath}/assets/images/logo/logo.png');
        background-repeat: no-repeat;
        background-position: center;
        background-size: contain;
        animation: float 4s ease-in-out infinite;
    }

    @keyframes float {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-10px); }
    }

    .image-placeholder svg {
        width: 90px;
        height: 90px;
        opacity: 0.8;
    }

    /* LOGIN SECTION */
    .login-section {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 25px;
        background-color: transparent;
    }

    .login-container {
        background-color: var(--card-bg);
        padding: 36px 32px;
        border-radius: 24px;
        box-shadow: var(--shadow-lg);
        width: 100%;
        max-width: 440px;
        text-align: center;
        border: 1px solid rgba(25, 167, 123, 0.1);
        animation: slideUp 0.6s ease-out;
    }

    @keyframes slideUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .login-header {
        margin-bottom: 24px;
    }

    .jobseeker-icon-wrapper {
        width: 64px;
        height: 64px;
        background: var(--hover-bg);
        border-radius: 18px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 16px;
        border: 1px solid rgba(25, 167, 123, 0.15);
    }

    .jobseeker-icon {
        width: 44px;
        height: 40px;
        font-size: 18px;
        font-weight: 700;
        background: var(--gradient-primary);
        color: #ffffff;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: 'Inter', sans-serif;
        box-shadow: var(--glow-primary);
    }

    h3 {
        color: var(--text-primary);
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 8px;
    }

    .login-subtitle {
        color: var(--text-tertiary);
        font-size: 14px;
    }

    label {
        font-size: 14px;
        color: var(--text-secondary);
        margin-bottom: 8px;
        text-align: left;
        display: block;
        font-weight: 500;
    }

    label i {
        color: var(--primary);
        margin-right: 6px;
    }

    .input-wrapper {
        position: relative;
        margin-bottom: 18px;
    }

    .input-icon {
        position: absolute;
        left: 14px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--primary);
        width: 18px;
        height: 18px;
    }

    input[type="email"],
    input[type="password"] {
        width: 100%;
        padding: 14px 16px 14px 46px;
        border: 2px solid var(--border-color);
        border-radius: 14px;
        background-color: #f8f9fb;
        font-size: 14px;
        transition: all 0.3s ease;
    }

    input[type="email"]:focus,
    input[type="password"]:focus {
        outline: none;
        border-color: var(--primary);
        background-color: white;
        box-shadow: var(--glow-primary);
    }

    button[type="submit"] {
        background: var(--gradient-primary);
        color: white;
        border: none;
        padding: 14px 20px;
        width: 100%;
        border-radius: 14px;
        font-size: 16px;
        font-weight: 600;
        margin-top: 8px;
        transition: all 0.3s ease;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        box-shadow: 0 4px 16px rgba(25, 167, 123, 0.3);
    }

    button[type="submit"]:hover {
        background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
    }

    .register-link {
        margin-top: 24px;
        padding-top: 20px;
        border-top: 1px solid var(--border-color);
    }

    .register-link p {
        font-size: 14px;
        color: var(--text-tertiary);
    }

    .register-link a {
        color: var(--primary);
        font-weight: 600;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .register-link a:hover {
        color: var(--primary-dark);
        text-decoration: underline;
    }

    /* ICONS + INPUT FOCUS */
    .input-icon {
        position: absolute;
        left: 14px;
        top: 50%;
        transform: translateY(-50%) scale(1);
        width: 20px;
        height: 20px;
        pointer-events: none;
        transition: transform 0.22s ease, opacity 0.22s ease;
        color: var(--primary);
        opacity: 0.95;
        display: block;
    }

    /* EMAIL icon - envelope */
    .input-icon.email-icon::before {
        content: '';
        position: absolute;
        left: 0;
        top: 2px;
        width: 18px;
        height: 12px;
        border: 2px solid var(--primary);
        border-radius: 3px;
        box-sizing: border-box;
        background: transparent;
        transition: border-color 0.22s ease, transform 0.22s ease;
    }

    .input-icon.email-icon::after {
        content: '';
        position: absolute;
        left: 3px;
        top: 9px;
        width: 0;
        height: 0;
        border-left: 6px solid transparent;
        border-right: 6px solid transparent;
        border-top: 5px solid var(--primary);
        transition: border-top-color 0.22s ease;
    }

    /* PASSWORD icon - lock */
    .input-icon.password-icon::before {
        content: '';
        position: absolute;
        left: 3px;
        top: 7px;
        width: 14px;
        height: 10px;
        border: 2px solid var(--primary);
        border-radius: 3px;
        box-sizing: border-box;
        transition: border-color 0.22s ease;
    }

    .input-icon.password-icon::after {
        content: '';
        position: absolute;
        left: 6px;
        top: 0;
        width: 8px;
        height: 7px;
        border: 2px solid var(--primary);
        border-bottom: none;
        border-radius: 8px 8px 0 0;
        box-sizing: border-box;
        transition: border-color 0.22s ease;
    }

    .input-wrapper:focus-within .input-icon {
        transform: translateY(-50%) scale(1.1);
        opacity: 1;
    }

    .input-wrapper:focus-within .input-icon.email-icon::before,
    .input-wrapper:focus-within .input-icon.email-icon::after,
    .input-wrapper:focus-within .input-icon.password-icon::before,
    .input-wrapper:focus-within .input-icon.password-icon::after {
        border-color: var(--primary-dark);
    }

    .input-wrapper:focus-within .input-icon.email-icon::after {
        border-top-color: var(--primary-dark);
    }

    .alert-danger {
        background-color: var(--danger);
        color: white;
        padding: 14px 16px;
        border-radius: 12px;
        margin-bottom: 18px;
        font-size: 14px;
        text-align: left;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .alert-danger i {
        font-size: 16px;
    }

    .alert-success {
        background-color: var(--success);
        color: white;
        padding: 14px 16px;
        border-radius: 12px;
        margin-bottom: 18px;
        font-size: 14px;
        text-align: left;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .loading-spinner {
        display: inline-block;
        width: 18px;
        height: 18px;
        border: 2px solid rgba(255,255,255,0.3);
        border-top-color: #fff;
        border-radius: 50%;
        animation: spin 0.6s linear infinite;
    }

    @keyframes spin {
        to { transform: rotate(360deg); }
    }

    @media (max-width: 768px) {
        .main-container {
            flex-direction: column;
        }

        .image-section {
            min-height: 220px;
            padding: 30px 20px;
        }

        .image-content h1 {
            font-size: 26px;
        }

        .image-placeholder {
            max-width: 200px;
            height: 160px;
        }

        .login-container {
            padding: 28px 20px;
        }

        h3 {
            font-size: 24px;
        }
    }

    @media (max-width: 420px) {
        .input-icon { 
            left: 12px; 
            width: 18px; 
            height: 18px; 
        }
        input[type="email"], 
        input[type="password"] { 
            padding-left: 42px; 
        }
    }
    </style>

</head>
<body>
    <div class="main-container">
        <!-- Left Side - Image Section -->
        <div class="image-section">
            <div class="image-content">
                <h1>Welcome to SmartInterview</h1>
                <p>Job Seeker Portal</p>
                <div class="image-placeholder">
                </div>
            </div>
        </div>

        <!-- Right Side - Login Form Section -->
        <div class="login-section">
            <div class="login-container">

                <!-- Header -->
                <div class="login-header">
                    <div class="jobseeker-icon-wrapper">
                        <div class="jobseeker-icon">JS</div>
                    </div>
                    <h3>Job Seeker Login</h3>
                    <p class="login-subtitle">
                        Sign in to explore verified jobs and career opportunities
                    </p>
                </div>

                <!-- Error -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>

                <!-- Success Message -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> ${message}
                    </div>
                </c:if>

                <!-- Form -->
                <form action="${pageContext.request.contextPath}/jobSeekers/login1" method="post" id="loginForm">
                    <div class="mb-3">
                        <label><i class="fas fa-envelope"></i> Email</label>
                        <div class="input-wrapper">
                            <span class="input-icon email-icon"></span>
                            <input type="email" name="email" id="email" placeholder="Enter your email" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label><i class="fas fa-lock"></i> Password</label>
                        <div class="input-wrapper">
                            <span class="input-icon password-icon"></span>
                            <input type="password" name="password" id="password" placeholder="Enter your password" required>
                        </div>
                    </div>

                    <button type="submit" id="submitBtn">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </button>
                </form>

                <!-- Footer -->
                <div class="register-link">
                    <p>
                        New Job Seeker?
                        <a href="${pageContext.request.contextPath}/jobSeekers/register">Register Here <i class="fas fa-arrow-right"></i></a>
                        <span style="margin: 0 8px; color: var(--border-color);">|</span>
                        <a href="${pageContext.request.contextPath}/user/forgot-password">Forgot Password?</a>
                    </p>
                </div>

            </div>
        </div>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('loginForm');
        const submitBtn = document.getElementById('submitBtn');
        
        if (form && submitBtn) {
            form.addEventListener('submit', function(e) {
                // Show loading state
                submitBtn.innerHTML = '<span class="loading-spinner"></span> Signing in...';
                submitBtn.disabled = true;
            });
        }

        // Keyboard shortcut for submit
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey && e.key === 'Enter') {
                const email = document.getElementById('email');
                const password = document.getElementById('password');
                if (email.value && password.value) {
                    form.dispatchEvent(new Event('submit'));
                }
            }
        });

        if (!document.getElementById('mobile-responsive-style')) {
            const style = document.createElement('style');
            style.id = 'mobile-responsive-style';
            style.innerHTML = `
                @media (max-width: 768px) {
                    .sidebar, .nav-sidebar {
                        transform: translateX(-100%);
                        transition: transform 0.3s ease;
                        position: fixed !important;
                        z-index: 1001 !important;
                        height: 100vh;
                    }
                    .sidebar.active, .nav-sidebar.active {
                        transform: translateX(0);
                        box-shadow: 2px 0 20px rgba(0,0,0,0.2) !important;
                    }
                    .main-content {
                        margin-left: 0 !important;
                        padding: 16px !important;
                        width: 100% !important;
                        max-width: 100% !important;
                    }
                    .stats-grid, .content-grid, .grid, .hr-stats-grid, .hr-content-grid, .profile-grid, .dashboard-grid {
                        grid-template-columns: 1fr !important;
                        display: grid !important; 
                    }
                    .top-bar {
                        flex-direction: column !important;
                        align-items: flex-start !important;
                        gap: 16px;
                    }
                    .chat-header {
                        flex-wrap: wrap;
                        gap: 12px;
                    }
                    .top-bar h1, .chat-header h3 {
                        font-size: 22px !important;
                        display: flex;
                        align-items: center;
                    }
                    .mobile-menu-btn {
                        display: inline-block !important;
                        background: none;
                        border: none;
                        font-size: 24px;
                        color: inherit;
                        cursor: pointer;
                        margin-right: 12px;
                    }
                    .mobile-overlay {
                        display: none;
                        position: fixed;
                        top: 0; left: 0; right: 0; bottom: 0;
                        background: rgba(0,0,0,0.5);
                        z-index: 1000;
                    }
                    .mobile-overlay.active {
                        display: block;
                    }
                    .chat-sidebar {
                        position: fixed !important;
                        transform: translateX(-100%);
                        transition: transform 0.3s;
                        z-index: 1000;
                    }
                    .chat-sidebar.active {
                        transform: translateX(0);
                    }
                    table:not(.table-responsive), table:not(.table-responsive) thead, table:not(.table-responsive) tbody, table:not(.table-responsive) th, table:not(.table-responsive) td, table:not(.table-responsive) tr { 
                        display: block; 
                    }
                    table:not(.table-responsive) thead tr { 
                        position: absolute;
                        top: -9999px;
                        left: -9999px;
                    }
                    table:not(.table-responsive) tr { border: 1px solid #e2e8f0; margin-bottom: 12px; border-radius: 8px; overflow:hidden; }
                    table:not(.table-responsive) td { 
                        border: none;
                        border-bottom: 1px solid #f1f5f9; 
                        position: relative;
                        padding-left: 50% !important; 
                        text-align: right;
                        font-size: 14px;
                    }
                    table:not(.table-responsive) td:last-child {
                        border-bottom: none;
                    }
                    table:not(.table-responsive) td:before { 
                        position: absolute;
                        top: 50%;
                        transform: translateY(-50%);
                        left: 12px;
                        width: 45%; 
                        padding-right: 10px; 
                        white-space: nowrap;
                        content: attr(data-label);
                        font-weight: 600;
                        text-align: left;
                        color: #64748b;
                    }
                }
                .mobile-menu-btn { display: none; }
            `;
            document.head.appendChild(style);
        }
        
        const sidebar = document.querySelector('.sidebar') || document.querySelector('.nav-sidebar');
        if (sidebar) {
            const topBar = document.querySelector('.top-bar') || document.querySelector('.chat-header') || document.querySelector('.dashboard-header') || document.body;
            
            let heading = null;
            if (topBar && topBar !== document.body) {
                heading = topBar.querySelector('h1') || topBar.querySelector('.chat-header-info') || topBar.querySelector('h2');
                if (!heading) heading = topBar;
            } else if (!document.querySelector('.mobile-menu-btn')) {
                heading = document.createElement('div');
                heading.style.padding = '10px';
                document.body.insertBefore(heading, document.body.firstChild);
            }
            
            if (heading && !document.querySelector('.mobile-menu-btn')) {
                heading.style.display = 'flex';
                heading.style.alignItems = 'center';

                const toggleBtn = document.createElement('button');
                toggleBtn.className = 'mobile-menu-btn';
                toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
                heading.insertBefore(toggleBtn, heading.firstChild);
                
                const overlay = document.createElement('div');
                overlay.className = 'mobile-overlay';
                document.body.appendChild(overlay);

                let touchstartX = 0;
                let touchendX = 0;
                document.body.addEventListener('touchstart', e => { touchstartX = e.changedTouches[0].screenX; }, {passive: true});
                document.body.addEventListener('touchend', e => { 
                    touchendX = e.changedTouches[0].screenX; 
                    if (touchendX < touchstartX - 50) closeSidebar(); 
                    if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); 
                }, {passive: true});
                
                function openSidebar() {
                    sidebar.classList.add('active');
                    overlay.classList.add('active');
                    document.body.style.overflow = 'hidden';
                }
                
                function closeSidebar() {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                }
                
                toggleBtn.addEventListener('click', openSidebar);
                overlay.addEventListener('click', closeSidebar);
            }
        }
        
        const tables = document.querySelectorAll('table:not(.table-responsive)');
        tables.forEach(table => {
            const headers = Array.from(table.querySelectorAll('th')).map(th => th.innerText);
            const rows = Array.from(table.querySelectorAll('tbody tr'));
            rows.forEach(row => {
                Array.from(row.querySelectorAll('td')).forEach((td, index) => {
                    if(headers[index]) {
                        td.setAttribute('data-label', headers[index]);
                    }
                });
            });
        });
    });
    </script>
</body>
</html>
