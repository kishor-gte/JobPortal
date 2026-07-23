<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Reset Password | JobU - Create New Password</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #0F172A;
            --primary-dark: #020617;
            --primary-light: #1E293B;
            --accent: #19A77B;
            --accent-dark: #148F69;
            --accent-light: #3BC49A;
            --accent-glow: rgba(25, 167, 123, 0.2);
            --bg-dark: #0F172A;
            --bg-dark-light: #1E293B;
            --bg-light: #F8FAFE;
            --card-bg: rgba(255, 255, 255, 0.98);
            --text-dark: #0F172A;
            --text-muted: #64748B;
            --success: #19A77B;
            --danger: #EF4444;
            --warning: #F59E0B;
            --shadow-xs: 0 1px 2px rgba(0, 0, 0, 0.03);
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 20px 35px -8px rgba(0, 0, 0, 0.1);
            --shadow-xl: 0 25px 50px -12px rgba(25, 167, 123, 0.25);
            --shadow-glow: 0 0 20px rgba(25, 167, 123, 0.15);
            --transition: all 0.4s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            --radius-sm: 12px;
            --radius-md: 20px;
            --radius-lg: 28px;
            --radius-xl: 36px;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', 'Plus Jakarta Sans', system-ui, sans-serif;
            background: linear-gradient(145deg, #F1F5F9 0%, #EFF6F1 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow-x: hidden;
            padding: 2rem;
        }

        body::before {
            content: '';
            position: fixed;
            top: -20%;
            left: -10%;
            width: 120%;
            height: 140%;
            background: radial-gradient(circle at 30% 20%, rgba(25, 167, 123,0.04) 0%, transparent 50%),
                        radial-gradient(circle at 85% 70%, rgba(59,130,246,0.03) 0%, transparent 60%);
            pointer-events: none;
            z-index: 0;
            animation: slowDrift 22s ease-in-out infinite alternate;
        }

        @keyframes slowDrift {
            0% { transform: translate(0, 0) scale(1); opacity: 0.6; }
            100% { transform: translate(-2%, -3%) scale(1.02); opacity: 1; }
        }

        body::after {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(circle at 20% 40%, rgba(25, 167, 123,0.04) 1px, transparent 1px);
            background-size: 40px 40px;
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
            background: radial-gradient(circle, var(--accent), transparent);
            opacity: 0.04;
            pointer-events: none;
            z-index: 0;
            filter: blur(55px);
            animation: floatOrb 25s infinite alternate ease-in-out;
        }

        @keyframes floatOrb {
            0% { transform: translate(0, 0) scale(1); }
            100% { transform: translate(30px, -30px) scale(1.3); }
        }

        .container {
            background: rgba(255, 255, 255, 0.97);
            backdrop-filter: blur(12px);
            padding: 2.8rem;
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25, 167, 123,0.1);
            width: 480px;
            max-width: 100%;
            text-align: center;
            position: relative;
            z-index: 2;
            animation: fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
            border: 1px solid rgba(255,255,255,0.5);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px) scale(0.96); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--accent), var(--accent-light), var(--accent));
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
        }

        .icon-wrapper {
            width: 88px;
            height: 88px;
            background: linear-gradient(145deg, rgba(25, 167, 123,0.1), rgba(25, 167, 123,0.04));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            position: relative;
            transition: var(--transition);
            animation: gentlePulse 2.5s ease-in-out infinite;
        }

        @keyframes gentlePulse {
            0%, 100% { box-shadow: 0 0 0 0 rgba(25, 167, 123,0.2); }
            50% { box-shadow: 0 0 0 18px rgba(25, 167, 123,0); }
        }

        .icon-wrapper::before {
            content: '';
            position: absolute;
            inset: -2px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent), var(--accent-light));
            opacity: 0.3;
            transition: opacity 0.3s;
        }

        .icon-wrapper:hover::before {
            opacity: 0.6;
        }

        .icon-wrapper i { 
            font-size: 2.5rem; 
            color: var(--accent);
            z-index: 1;
            transition: var(--transition);
        }

        .icon-wrapper:hover i {
            transform: scale(1.05);
        }

        h2 {
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--primary), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 0.5rem;
            letter-spacing: -0.5px;
        }

        .user-type-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(25, 167, 123,0.12);
            padding: 0.4rem 1.2rem;
            border-radius: 60px;
            font-size: 0.8rem;
            font-weight: 600;
            color: var(--accent);
            margin-bottom: 1.8rem;
            border: 1px solid rgba(25, 167, 123,0.2);
            backdrop-filter: blur(4px);
        }

        .input-group { margin-bottom: 1.75rem; text-align: left; }
        
        .input-label {
            font-size: 0.7rem;
            font-weight: 700;
            color: var(--accent-dark);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.6rem;
            display: block;
        }
        .input-label i { color: var(--accent); margin-right: 0.5rem; }

        .input-wrapper { position: relative; }
        
        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--accent);
            font-size: 1rem;
            transition: var(--transition);
            pointer-events: none;
        }

        input[type="password"] {
            width: 100%;
            padding: 0.95rem 1rem 0.95rem 2.8rem;
            border: 2px solid #E2E8F0;
            border-radius: 60px;
            background-color: white;
            font-size: 0.9rem;
            font-weight: 500;
            transition: var(--transition);
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
        }

        input[type="password"]:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 5px rgba(25, 167, 123, 0.12);
        }

        input::placeholder {
            color: #A0AEC0;
            font-weight: 400;
            font-size: 0.85rem;
        }

        .toggle-password {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            background: transparent;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            font-size: 1rem;
            transition: var(--transition);
            z-index: 3;
            padding: 0.5rem;
            border-radius: 50%;
        }
        .toggle-password:hover { color: var(--accent); background: rgba(25, 167, 123,0.05); }

        button[type="submit"] {
            background: linear-gradient(105deg, var(--accent), var(--accent-dark));
            color: white;
            border: none;
            padding: 0.95rem 1.5rem;
            width: 100%;
            border-radius: 60px;
            font-size: 0.95rem;
            font-weight: 700;
            transition: var(--transition);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            box-shadow: 0 12px 25px -8px rgba(25, 167, 123,0.45);
            margin-top: 0.5rem;
        }
        button[type="submit"]:hover {
            transform: translateY(-3px);
            background: linear-gradient(105deg, var(--accent-dark), #148F69);
            box-shadow: 0 18px 35px -12px rgba(25, 167, 123,0.55);
        }
        button[type="submit"]:active {
            transform: translateY(0);
        }

        .message {
            margin-top: 1.25rem;
            font-size: 0.85rem;
            font-weight: 600;
            padding: 0.9rem;
            border-radius: 60px;
            backdrop-filter: blur(4px);
        }
        .message.success { 
            background: rgba(25, 167, 123,0.1); 
            color: var(--success); 
            border-left: 4px solid var(--success);
        }
        .message.error { 
            background: rgba(239,68,68,0.1); 
            color: var(--danger); 
            border-left: 4px solid var(--danger);
        }

        /* Password strength indicator (enhanced) */
        .password-strength {
            margin-top: 0.5rem;
            height: 4px;
            background: #E2E8F0;
            border-radius: 4px;
            overflow: hidden;
            transition: var(--transition);
        }
        .strength-bar {
            width: 0%;
            height: 100%;
            transition: width 0.3s ease, background 0.3s ease;
        }

        /* Responsive */
        @media (max-width: 576px) {
            body { padding: 1rem; }
            .container { padding: 2rem 1.5rem; width: 100%; }
            h2 { font-size: 1.5rem; }
            .icon-wrapper { width: 70px; height: 70px; }
            .icon-wrapper i { font-size: 2rem; }
            .input-group { margin-bottom: 1.25rem; }
            input[type="password"] { padding: 0.85rem 1rem 0.85rem 2.6rem; }
        }

        @media (max-width: 380px) {
            .container { padding: 1.5rem 1rem; }
            h2 { font-size: 1.3rem; }
            .user-type-badge { font-size: 0.7rem; padding: 0.3rem 1rem; }
        }

        ::-webkit-scrollbar {
            width: 6px;
        }
        ::-webkit-scrollbar-track {
            background: #E2E8F0;
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb {
            background: var(--accent);
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: var(--accent-dark);
        }
        ::selection {
            background: var(--accent);
            color: white;
        }
    </style>
</head>
<body>

<!-- Decorative floating shapes -->
<div class="floating-shape" style="width: 400px; height: 400px; top: -150px; right: -100px;"></div>
<div class="floating-shape" style="width: 280px; height: 280px; bottom: 80px; left: -60px; opacity: 0.05;"></div>
<div class="floating-shape" style="width: 220px; height: 220px; bottom: 25%; right: 8%; opacity: 0.04;"></div>

<div class="container">
    <div class="icon-wrapper">
        <i class="fas fa-lock"></i>
    </div>
    
    <h2>Reset Password</h2>
    <div class="user-type-badge">
        <i class="fas fa-user-circle"></i> ${param.userType}
    </div>

    <form action="${pageContext.request.contextPath}/auth/reset-password1" method="POST" id="resetForm">
        <input type="hidden" name="token" value="${param.token}">
        
        <div class="input-group">
            <label class="input-label" for="newPassword">
                <i class="fas fa-key"></i> New Password
            </label>
            <div class="input-wrapper">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" id="newPassword" name="newPassword" placeholder="Enter your new password" required>
                <button type="button" class="toggle-password" onclick="togglePassword('newPassword', this)">
                    <i class="far fa-eye-slash"></i>
                </button>
            </div>
            <div class="password-strength" id="passwordStrength">
                <div class="strength-bar" id="strengthBar"></div>
            </div>
        </div>

        <button type="submit">
            <i class="fas fa-save"></i> Update Password
        </button>
    </form>
    
    <c:if test="${not empty message}">
        <div class="message ${message.contains('success') || message.contains('Success') ? 'success' : 'error'}">
            <i class="fas ${message.contains('success') || message.contains('Success') ? 'fa-check-circle' : 'fa-exclamation-circle'} me-2"></i>
            ${message}
        </div>
    </c:if>
</div>

<script>
function togglePassword(inputId, button) {
    const input = document.getElementById(inputId);
    const icon = button.querySelector('i');
    if (input.type === 'password') {
        input.type = 'text';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    } else {
        input.type = 'password';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    }
}

// Enhanced password strength checker
function checkPasswordStrength(password) {
    let strength = 0;
    const strengthBar = document.getElementById('strengthBar');
    
    if (password.length === 0) {
        strengthBar.style.width = '0%';
        strengthBar.style.background = '#E2E8F0';
        return;
    }
    
    // Length check
    if (password.length >= 8) strength += 25;
    else if (password.length >= 6) strength += 15;
    else strength += 5;
    
    // Uppercase check
    if (/[A-Z]/.test(password)) strength += 25;
    
    // Lowercase check
    if (/[a-z]/.test(password)) strength += 25;
    
    // Number check
    if (/[0-9]/.test(password)) strength += 15;
    
    // Special character check
    if (/[^A-Za-z0-9]/.test(password)) strength += 10;
    
    // Cap at 100
    strength = Math.min(strength, 100);
    
    strengthBar.style.width = strength + '%';
    
    if (strength < 30) {
        strengthBar.style.background = '#EF4444'; // Weak - Red
    } else if (strength < 60) {
        strengthBar.style.background = '#F59E0B'; // Medium - Orange
    } else if (strength < 80) {
        strengthBar.style.background = '#19A77B'; // Strong - Green
    } else {
        strengthBar.style.background = '#148F69'; // Very Strong - Dark Green
    }
}

// Real-time password strength monitoring
document.addEventListener('DOMContentLoaded', function() {
    const passwordInput = document.getElementById('newPassword');
    if (passwordInput) {
        passwordInput.addEventListener('input', function(e) {
            checkPasswordStrength(e.target.value);
        });
    }
    
    // Add smooth transition to strength bar
    const style = document.createElement('style');
    style.textContent = `
        .strength-bar { transition: width 0.3s ease, background 0.3s ease; }
        button[type="submit"] { transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease; }
    `;
    document.head.appendChild(style);
});

// Mobile responsive sidebar handling (preserved from original)
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