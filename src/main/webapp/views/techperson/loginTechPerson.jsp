<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tech Person Login | SmartInterview</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
    :root {
        --primary: #19A77B;
        --primary-dark: #148F69;
        --accent: #3BC49A;
        --bg-dark: #2E3E41;
        --bg-darker: #1a2a2c;
        --bg-lighter: #3a4e51;
        --text-primary: #1e293b;
        --text-secondary: #64748b;
        --border-color: #e0e6ed;
        --white: #ffffff;
        --success: #19A77B;
        --danger: #ef4444;
        --warning: #f59e0b;
        --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
        --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
        --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
        --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
        --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
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
        background-color: var(--white);
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

    .techperson-icon-wrapper {
        width: 64px;
        height: 64px;
        background: rgba(25, 167, 123, 0.08);
        border-radius: 18px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 16px;
        border: 1px solid rgba(25, 167, 123, 0.15);
    }

    .techperson-icon {
        width: 40px;
        height: 40px;
        font-size: 20px;
        background: var(--gradient-primary);
        border-radius: 14px;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        box-shadow: var(--glow-primary);
    }

    h3 {
        color: var(--text-primary);
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 8px;
    }

    .login-subtitle {
        color: var(--text-secondary);
        font-size: 14px;
    }

    label {
        font-size: 14px;
        color: var(--text-primary);
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
    input[type="password"],
    input[type="text"] {
        width: 100%;
        padding: 14px 16px 14px 46px;
        border: 2px solid var(--border-color);
        border-radius: 14px;
        background-color: #f8f9fb;
        font-size: 14px;
        transition: all 0.3s ease;
    }

    input[type="email"]:focus,
    input[type="password"]:focus,
    input[type="text"]:focus {
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

    .forgot-password-link {
        margin-top: 24px;
        padding-top: 20px;
        border-top: 1px solid var(--border-color);
    }

    .forgot-password-link p {
        font-size: 14px;
        color: var(--text-secondary);
    }

    .forgot-password-link a {
        color: var(--primary);
        font-weight: 600;
        text-decoration: none;
        transition: color 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .forgot-password-link a:hover {
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
        
        .login-container {
            padding: 24px 16px;
        }
        
        h3 {
            font-size: 22px;
        }
        
        .techperson-icon-wrapper {
            width: 56px;
            height: 56px;
        }
        
        .techperson-icon {
            width: 36px;
            height: 36px;
            font-size: 18px;
        }
    }
    .back-home-btn {
        position: absolute;
        top: 24px;
        left: 24px;
        z-index: 1000;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 18px;
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(8px);
        border: 1px solid rgba(25, 167, 123, 0.2);
        border-radius: 30px;
        color: #19A77B;
        font-size: 14px;
        font-weight: 600;
        text-decoration: none;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
    }
    .back-home-btn:hover {
        background: #19A77B;
        color: white !important;
        transform: translateX(-4px);
        box-shadow: 0 6px 18px rgba(25, 167, 123, 0.25);
        border-color: #19A77B;
    }
    @media (max-width: 768px) {
        .back-home-btn {
            background: #19A77B;
            color: white !important;
            border-color: #19A77B;
            top: 16px;
            left: 16px;
        }
        .back-home-btn:hover {
            background: #148F69;
            color: white !important;
        }
    }
    </style>

</head>
<body>
    <a href="${pageContext.request.contextPath}/" class="back-home-btn">
        <i class="fas fa-arrow-left"></i> Back to Home
    </a>
    <div class="main-container">
        <!-- Left Side - Image Section -->
        <div class="image-section">
            <div class="image-content">
                <h1>Welcome to SmartInterview</h1>
                <p>Tech Person Portal</p>
                <div class="image-placeholder">
                </div>
            </div>
        </div>

        <!-- Right Side - Login Form Section -->
        <div class="login-section">
            <div class="login-container">
                <div class="login-header">
                    <div class="techperson-icon-wrapper">
                        <div class="techperson-icon">R</div>
                    </div>
                    <h3>Tech Person Login</h3>
                    <p class="login-subtitle">Sign in to manage job postings and candidates</p>
                </div>
     
                <!-- Display error message if login fails -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i>${error}
                    </div>
                </c:if>
     
                <form action="${pageContext.request.contextPath}/tech/login1" method="post" id="loginForm">
                    <div class="mb-3">
                        <label for="email"><i class="fas fa-envelope"></i> Email Address</label>
                        <div class="input-wrapper">
                            <span class="input-icon email-icon"></span>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="password"><i class="fas fa-lock"></i> Password</label>
                        <div class="input-wrapper">
                            <span class="input-icon password-icon"></span>
                            <input type="password" class="form-control" id="techLoginPwd" name="password" placeholder="Enter your password" required style="padding-right: 50px;">
                            <span onclick="toggleTechLoginPwd()" id="techLoginEye" style="position:absolute;right:20px;top:50%;transform:translateY(-50%);cursor:pointer;color:#19A77B;font-size:1.1rem;z-index:3;"><i class="fas fa-eye"></i></span>
                        </div>
                        <small style="display:block;margin-top:6px;font-size:0.75rem;color:#94a3b8;text-align:left;padding-left:4px;">
                            <i class="fas fa-info-circle" style="color:#19A77B;margin-right:4px;"></i>
                            Min 6 chars, 1 uppercase, 1 lowercase &amp; 1 special character
                        </small>
                    </div>
                    <button type="submit" class="btn-primary" id="submitBtn">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </button>
                </form>
     
                <div class="forgot-password-link">
                    <p><a href="${pageContext.request.contextPath}/techperson/forgot-password"><i class="fas fa-key"></i> Forgot Password?</a></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    function toggleTechLoginPwd() {
        const pwd = document.getElementById('techLoginPwd');
        const eye = document.getElementById('techLoginEye').querySelector('i');
        if (pwd.type === 'password') {
            pwd.type = 'text';
            eye.className = 'fas fa-eye-slash';
        } else {
            pwd.type = 'password';
            eye.className = 'fas fa-eye';
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('loginForm');
        const submitBtn = document.getElementById('submitBtn');
        
        if (form && submitBtn) {
            form.addEventListener('submit', function(e) {
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
    });
    </script>
</body>
</html>




