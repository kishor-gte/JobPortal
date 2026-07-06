<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobU Admin Registration | Premium Access</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            --glass-white: rgba(255, 255, 255, 0.98);
            --shadow-sm: 0 10px 30px -12px rgba(0, 0, 0, 0.12);
            --shadow-md: 0 20px 40px -16px rgba(0, 0, 0, 0.15);
            --shadow-lg: 0 35px 60px -20px rgba(25, 167, 123, 0.3);
            --shadow-xl: 0 45px 70px -24px rgba(25, 167, 123, 0.35);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: radial-gradient(ellipse at 20% 30%, #eef7f2 0%, #ddebe5 100%);
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        /* animated background gradient mesh */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 40%, rgba(25,167,123,0.05) 0%, transparent 35%),
                radial-gradient(circle at 80% 70%, rgba(59,196,154,0.05) 0%, transparent 40%),
                radial-gradient(circle at 40% 90%, rgba(25,167,123,0.04) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: meshShift 15s ease-in-out infinite alternate;
        }
        
        @keyframes meshShift {
            0% { opacity: 0.6; transform: scale(1); }
            100% { opacity: 1; transform: scale(1.05); }
        }

        /* animated floating particles */
        body::after {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(circle at 15% 25%, rgba(25,167,123,0.08) 1px, transparent 1px);
            background-size: 35px 35px;
            pointer-events: none;
            animation: floatParticles 20s linear infinite;
        }
        
        @keyframes floatParticles {
            0% { background-position: 0 0; }
            100% { background-position: 70px 70px; }
        }

        .main-container {
            display: flex;
            min-height: 100vh;
            width: 100%;
            position: relative;
            z-index: 1;
        }

        /* ========== LEFT SECTION - LUXURY DESIGN ========== */
        .image-section {
            flex: 1;
            background: linear-gradient(145deg, var(--bg-dark) 0%, #1a2a2d 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            padding: 40px 30px;
        }

        /* animated gradient orbs */
        .image-section::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            top: -50%;
            left: -50%;
            background: radial-gradient(circle at 30% 40%, rgba(25,167,123,0.2), rgba(59,196,154,0.08), transparent 70%);
            animation: slowOrbit 25s ease-in-out infinite;
        }

        @keyframes slowOrbit {
            0%, 100% { transform: translate(0, 0) scale(1) rotate(0deg); opacity: 0.7; }
            33% { transform: translate(2%, 1%) scale(1.08) rotate(5deg); opacity: 0.9; }
            66% { transform: translate(-1%, 2%) scale(0.98) rotate(-3deg); opacity: 0.6; }
        }

        .image-section::after {
            content: '';
            position: absolute;
            inset: 0;
            background: repeating-linear-gradient(45deg, rgba(255,255,255,0.015) 0px, rgba(255,255,255,0.015) 1px, transparent 1px, transparent 12px);
            pointer-events: none;
        }

        .image-content {
            position: relative;
            z-index: 2;
            text-align: center;
            color: white;
            max-width: 500px;
            animation: fadeSlideUp 0.8s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeSlideUp {
            from {
                opacity: 0;
                transform: translateY(50px) scale(0.96);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .image-content h1 {
            font-size: 42px;
            font-weight: 800;
            margin-bottom: 12px;
            letter-spacing: -1px;
            background: linear-gradient(135deg, #ffffff, var(--accent), var(--primary), #ffffff);
            background-size: 300% auto;
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            animation: shimmer 5s linear infinite;
        }

        @keyframes shimmer {
            0% { background-position: 0% center; }
            100% { background-position: 200% center; }
        }

        .image-content h2 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 8px;
            color: white;
            text-shadow: 0 2px 20px rgba(0,0,0,0.2);
            position: relative;
            display: inline-block;
        }
        
        .image-content h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: linear-gradient(90deg, transparent, var(--accent), transparent);
            border-radius: 3px;
        }

        .image-content h3 {
            font-size: 16px;
            font-weight: 400;
            opacity: 0.85;
            margin-top: 20px;
            letter-spacing: 0.3px;
        }

        /* premium glassmorphism logo placeholder */
        .image-placeholder {
            width: 270px;
            height: 270px;
            background: linear-gradient(135deg, rgba(255,255,255,0.1), rgba(255,255,255,0.02));
            border-radius: 50px;
            backdrop-filter: blur(16px);
            border: 1px solid rgba(255,255,255,0.25);
            margin: 30px auto 0;
            box-shadow: 0 35px 55px -20px rgba(0,0,0,0.5), inset 0 1px 0 rgba(255,255,255,0.15);
            transition: all 0.5s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            background-image: url('${pageContext.request.contextPath}/assets/images/logo/logo.png');
            background-repeat: no-repeat;
            background-position: center;
            background-size: 65%;
            position: relative;
            cursor: pointer;
        }

        .image-placeholder::before {
            content: '';
            position: absolute;
            inset: -2px;
            border-radius: 52px;
            background: linear-gradient(135deg, var(--accent), var(--primary), transparent);
            opacity: 0;
            transition: opacity 0.4s;
            z-index: -1;
        }

        .image-placeholder:hover::before {
            opacity: 0.4;
        }

        .image-placeholder::after {
            content: '';
            position: absolute;
            inset: 0;
            border-radius: 50px;
            padding: 2px;
            background: linear-gradient(135deg, rgba(59,196,154,0.7), transparent 70%);
            mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
            -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
            -webkit-mask-composite: xor;
            mask-composite: exclude;
            pointer-events: none;
        }

        .image-placeholder:hover {
            transform: scale(1.03) rotate(1deg);
            border-color: rgba(59,196,154,0.6);
            box-shadow: 0 40px 60px -20px rgba(25,167,123,0.5);
        }

        /* ========== RIGHT SECTION - ULTRA PREMIUM CARD ========== */
        .register-section {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 20px;
            background: transparent;
            overflow-y: auto;
        }

        .register-container {
            background: var(--glass-white);
            padding: 48px 42px;
            border-radius: 56px;
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.12);
            width: 100%;
            max-width: 520px;
            text-align: center;
            transition: all 0.4s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            backdrop-filter: blur(4px);
            position: relative;
            overflow: hidden;
        }
        
        /* animated border glow */
        .register-container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(135deg, var(--primary), var(--accent), var(--primary));
            border-radius: 58px;
            opacity: 0;
            z-index: -1;
            transition: opacity 0.5s;
        }
        
        .register-container:hover::before {
            opacity: 0.15;
        }

        .register-container:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.25);
        }

        .register-header {
            margin-bottom: 32px;
        }

        /* premium animated icon wrapper with pulse */
        .admin-icon-wrapper {
            width: 85px;
            height: 85px;
            background: linear-gradient(145deg, rgba(25,167,123,0.12), rgba(59,196,154,0.06));
            border-radius: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 22px;
            position: relative;
            transition: 0.3s;
            animation: gentlePulse 2.5s ease-in-out infinite;
        }
        
        @keyframes gentlePulse {
            0%, 100% { box-shadow: 0 0 0 0 rgba(25,167,123,0.2); }
            50% { box-shadow: 0 0 0 12px rgba(25,167,123,0); }
        }

        .admin-icon-wrapper::before {
            content: '';
            position: absolute;
            inset: -3px;
            border-radius: 33px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            opacity: 0.25;
            transition: opacity 0.4s;
        }

        .admin-icon-wrapper:hover::before {
            opacity: 0.5;
        }

        .admin-icon {
            width: 55px;
            height: 55px;
            background: linear-gradient(145deg, var(--primary), var(--primary-dark));
            border-radius: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 26px;
            font-weight: 800;
            box-shadow: 0 12px 24px -8px rgba(25,167,123,0.4);
            transition: 0.25s;
        }

        .admin-icon-wrapper:hover .admin-icon {
            transform: scale(1.03);
            box-shadow: 0 15px 30px -10px rgba(25,167,123,0.5);
        }

        h3 {
            color: var(--bg-dark);
            font-size: 32px;
            font-weight: 800;
            margin-bottom: 8px;
            letter-spacing: -0.8px;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .register-subtitle {
            color: #7a9b8f;
            font-size: 14px;
            font-weight: 500;
            letter-spacing: 0.2px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        .input-wrapper {
            position: relative;
            margin-bottom: 0;
        }

        /* elegant input icons with animation */
        .input-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary);
            font-size: 1.1rem;
            transition: all 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            z-index: 2;
            pointer-events: none;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-control {
            width: 100%;
            padding: 15px 20px 15px 54px;
            border: 2px solid #e8f0ec;
            border-radius: 28px;
            background-color: #ffffff;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            color: var(--bg-dark);
        }

        .form-control::placeholder {
            color: #b8cfc4;
            font-weight: 400;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 6px rgba(25, 167, 123, 0.12);
            background-color: #fff;
            transform: scale(1.01);
        }

        .form-control:focus ~ .input-icon {
            color: var(--primary-dark);
            transform: translateY(-50%) scale(1.12);
        }
        
        .input-wrapper:focus-within {
            transform: translateY(-1px);
        }

        /* modern button with ripple and shine effect */
        .btn-primary {
            background: linear-gradient(105deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            border: none;
            padding: 16px 28px;
            font-size: 16px;
            font-weight: 700;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            width: 100%;
            margin-top: 12px;
            box-shadow: 0 12px 28px -10px rgba(25, 167, 123, 0.5);
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            position: relative;
            overflow: hidden;
        }

        /* shine effect */
        .btn-primary::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -60%;
            width: 200%;
            height: 200%;
            background: linear-gradient(115deg, transparent, rgba(255,255,255,0.25), transparent);
            transform: rotate(25deg);
            transition: left 0.6s;
        }

        .btn-primary:hover::after {
            left: 100%;
        }

        .btn-primary:hover {
            background: linear-gradient(105deg, var(--primary-dark) 0%, #0d5e44 100%);
            transform: translateY(-3px);
            box-shadow: 0 18px 35px -12px rgba(25, 167, 123, 0.65);
        }

        .btn-primary:active {
            transform: translateY(1px);
        }

        /* alert styling premium */
        .alert {
            padding: 14px 22px;
            border-radius: 24px;
            margin-bottom: 24px;
            font-size: 13px;
            text-align: left;
            font-weight: 600;
            backdrop-filter: blur(4px);
            border: none;
        }

        .alert-danger {
            background: linear-gradient(135deg, #fff8f5, #fff0ea);
            color: #c44522;
            border-left: 4px solid #e85d3a;
            box-shadow: var(--shadow-sm);
        }

        .alert-success {
            background: linear-gradient(135deg, #edfaf5, #e0f5ec);
            color: #1a7a5a;
            border-left: 4px solid var(--primary);
            box-shadow: var(--shadow-sm);
        }

        .login-link {
            margin-top: 32px;
            padding-top: 28px;
            border-top: 2px solid #eaf3ef;
            position: relative;
        }
        
        .login-link::before {
            content: '';
            position: absolute;
            top: -1px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 2px;
            background: linear-gradient(90deg, transparent, var(--primary), transparent);
        }

        .login-link p {
            color: #7a9b8f;
            font-size: 14px;
            font-weight: 500;
            margin: 0;
        }

        .login-link a {
            text-decoration: none;
            color: var(--primary);
            font-weight: 700;
            transition: 0.25s;
            position: relative;
            display: inline-block;
        }

        .login-link a::after {
            content: '';
            position: absolute;
            bottom: -3px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            transition: width 0.3s ease;
        }

        .login-link a:hover::after {
            width: 100%;
        }

        .login-link a:hover {
            color: var(--primary-dark);
            transform: translateX(3px);
        }

        /* custom scrollbar */
        ::-webkit-scrollbar {
            width: 6px;
        }
        ::-webkit-scrollbar-track {
            background: #e8f0ec;
        }
        ::-webkit-scrollbar-thumb {
            background: var(--primary);
            border-radius: 10px;
        }

        /* floating decorative shapes */
        .floating-shape {
            position: fixed;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            opacity: 0.03;
            pointer-events: none;
            z-index: 0;
            filter: blur(40px);
        }

        /* Responsive Design */
        @media (max-width: 968px) {
            .main-container {
                flex-direction: column;
            }
            .image-section {
                flex: 0 0 38vh;
                padding: 30px 25px;
            }
            .image-content h1 {
                font-size: 32px;
            }
            .image-content h2 {
                font-size: 24px;
            }
            .image-placeholder {
                width: 200px;
                height: 200px;
                margin-top: 20px;
            }
            .register-section {
                padding: 40px 20px;
            }
            .register-container {
                padding: 40px 32px;
                max-width: 520px;
                margin: 0 auto;
            }
            h3 {
                font-size: 28px;
            }
        }

        @media (max-width: 576px) {
            .image-section {
                flex: 0 0 32vh;
                padding: 20px 15px;
            }
            .image-content h1 {
                font-size: 24px;
            }
            .image-content h2 {
                font-size: 20px;
            }
            .image-placeholder {
                width: 160px;
                height: 160px;
                margin-top: 15px;
            }
            .register-container {
                padding: 32px 24px;
            }
            h3 {
                font-size: 24px;
            }
            .admin-icon-wrapper {
                width: 70px;
                height: 70px;
            }
            .admin-icon {
                width: 45px;
                height: 45px;
                font-size: 22px;
            }
            .btn-primary {
                padding: 14px 20px;
                font-size: 14px;
            }
            .form-control {
                padding: 13px 16px 13px 48px;
                font-size: 13px;
            }
            .input-icon {
                font-size: 1rem;
                left: 18px;
            }
        }

        /* loading state animation */
        .btn-primary.loading {
            pointer-events: none;
            opacity: 0.8;
        }
        
        .btn-primary.loading i {
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>

<!-- decorative floating elements -->
<div class="floating-shape" style="width: 400px; height: 400px; top: -150px; right: -100px;"></div>
<div class="floating-shape" style="width: 280px; height: 280px; bottom: 80px; left: -80px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 200px; height: 200px; bottom: 15%; right: 8%; opacity: 0.05;"></div>
<div class="floating-shape" style="width: 150px; height: 150px; top: 20%; left: 5%; opacity: 0.03;"></div>

<div class="main-container">
    <!-- Left Side - Premium Image Section -->
    <div class="image-section">
        <div class="image-content">
            <h1>Welcome to JobU</h1>
            <h2>Register as Admin</h2>
            <h3>Join the leadership team</h3>
            <div class="image-placeholder">
                <!-- Logo background via CSS -->
            </div>
        </div>
    </div>

    <!-- Right Side - Premium Registration Form -->
    <div class="register-section">
        <div class="register-container">
            <div class="register-header">
                <div class="admin-icon-wrapper">
                    <div class="admin-icon"><i class="fas fa-user-shield"></i></div>
                </div>
                <h3>Admin Registration</h3>
                <p class="register-subtitle">Create your admin account to get started</p>
            </div>

            <!-- Display error/success messages with premium styling -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-circle-exclamation" style="margin-right: 8px;"></i> ${error}
                </div>
            </c:if>

            <c:if test="${not empty msg}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle" style="margin-right: 8px;"></i> ${msg}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/registerAdmin" method="post" id="registerForm">
                <div class="form-group">
                    <div class="input-wrapper">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" name="name" placeholder="Full Name" class="form-control" required autocomplete="name">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-wrapper">
                        <i class="fas fa-envelope input-icon"></i>
                        <input type="email" name="email" placeholder="Email Address" class="form-control" required autocomplete="email">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-wrapper">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" name="password" placeholder="Create Password" class="form-control"
                               pattern=".{6,}"
                               title="At least 6 characters" required autocomplete="new-password">
                    </div>
                </div>

                <button type="submit" class="btn-primary" id="registerBtn">
                    <i class="fas fa-arrow-right-to-bracket"></i> Register Account
                </button>
            </form>

            <div class="login-link">
                <p><i class="fas fa-sign-in-alt" style="margin-right: 8px; color: var(--primary);"></i> Already have an account? <a href="${pageContext.request.contextPath}/loginAdmin">Sign In ?</a></p>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Form submission loading state
    const registerForm = document.getElementById('registerForm');
    const registerBtn = document.getElementById('registerBtn');
    
    if (registerForm) {
        registerForm.addEventListener('submit', function(e) {
            if (registerBtn) {
                registerBtn.classList.add('loading');
                const originalHtml = registerBtn.innerHTML;
                registerBtn.innerHTML = '<i class="fas fa-spinner"></i> Creating Account...';
                // Reset after 3 seconds if needed (fallback, actual redirect will happen)
                setTimeout(() => {
                    if (registerBtn.classList.contains('loading')) {
                        registerBtn.innerHTML = originalHtml;
                        registerBtn.classList.remove('loading');
                    }
                }, 3000);
            }
        });
    }
    
    // Add focus animation effect on inputs
    const inputs = document.querySelectorAll('.form-control');
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.classList.add('input-focused');
        });
        input.addEventListener('blur', function() {
            this.parentElement.classList.remove('input-focused');
        });
    });
    
    // ---- preserve original mobile responsive script (unchanged structure) ----
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
                /* Table responsiveness */
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
    
    // Sidebar logic for potential admin pages (preserved)
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
    
    // Add data-labels to tables for responsive layout
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

<style>
    .input-focused .input-icon i,
    .input-focused .input-icon {
        color: var(--primary-dark);
    }
    input:-webkit-autofill,
    input:-webkit-autofill:focus {
        transition: background-color 0s 600000s, color 0s 600000s;
        -webkit-text-fill-color: var(--bg-dark);
    }
    .input-wrapper {
        transition: transform 0.2s ease;
    }
    
    /* smooth focus ring */
    .form-control:focus {
        outline: none;
    }
</style>
</body>
</html>
