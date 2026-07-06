<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobU - Company Login | Access Your Dashboard</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --primary-light: #3BC49A;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-light: #f4fbf9;
            --text-dark: #1a2c2f;
            --text-muted: #5a6e66;
            --white: #ffffff;
            --gradient: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
            --gradient-dark: linear-gradient(135deg, #1e2f32 0%, #2E3E41 100%);
            --gradient-reverse: linear-gradient(135deg, #3BC49A 0%, #19A77B 100%);
            --shadow-sm: 0 10px 30px -8px rgba(0,0,0,0.05);
            --shadow-md: 0 20px 35px -12px rgba(25,167,123,0.15);
            --shadow-lg: 0 30px 50px -15px rgba(0,0,0,0.12);
            --shadow-xl: 0 40px 60px -20px rgba(25,167,123,0.25);
            --transition: all 0.5s cubic-bezier(0.2, 0.95, 0.4, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #e6f4ef; border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: var(--primary-dark); }

        /* Main Container */
        .main-container {
            display: flex;
            min-height: 100vh;
            width: 100%;
        }

        /* ========== LEFT SIDE - PREMIUM IMAGE SECTION ========== */
        .image-section {
            flex: 1;
            background: var(--gradient-dark);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            padding: 60px 40px;
        }

        /* Animated Background Orbs */
        .image-section::before {
            content: '';
            position: absolute;
            top: -30%;
            right: -20%;
            width: 600px;
            height: 600px;
            background: radial-gradient(circle, rgba(59,196,154,0.15) 0%, transparent 70%);
            border-radius: 50%;
            animation: floatGlow 22s infinite alternate;
        }
        .image-section::after {
            content: '';
            position: absolute;
            bottom: -20%;
            left: -15%;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(25,167,123,0.1) 0%, transparent 70%);
            border-radius: 50%;
            animation: floatGlow2 18s infinite alternate;
        }
        @keyframes floatGlow {
            0% { transform: translate(0,0) scale(1); opacity: 0.3; }
            100% { transform: translate(-80px, 60px) scale(1.4); opacity: 0.6; }
        }
        @keyframes floatGlow2 {
            0% { transform: translate(0,0) scale(1); opacity: 0.2; }
            100% { transform: translate(70px, -50px) scale(1.3); opacity: 0.5; }
        }

        /* Floating Particles */
        .particle {
            position: absolute;
            background: rgba(59,196,154,0.2);
            border-radius: 50%;
            pointer-events: none;
            animation: floatParticle 15s infinite alternate;
        }
        .particle-1 { width: 8px; height: 8px; top: 20%; left: 15%; animation-duration: 12s; }
        .particle-2 { width: 12px; height: 12px; top: 60%; left: 25%; animation-duration: 18s; }
        .particle-3 { width: 6px; height: 6px; top: 40%; right: 20%; animation-duration: 14s; }
        .particle-4 { width: 10px; height: 10px; bottom: 30%; right: 30%; animation-duration: 16s; }
        @keyframes floatParticle {
            0% { transform: translate(0,0) scale(1); opacity: 0.3; }
            100% { transform: translate(30px, -40px) scale(1.5); opacity: 0.8; }
        }

        .image-content {
            position: relative;
            z-index: 2;
            text-align: center;
            color: white;
            max-width: 500px;
        }

        .image-content h1 {
            font-size: 3.2rem;
            font-weight: 800;
            margin-bottom: 15px;
            background: linear-gradient(135deg, #ffffff, #3BC49A);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            animation: textShine 3s infinite;
        }
        @keyframes textShine {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        .image-content h2 {
            font-size: 1.2rem;
            font-weight: 400;
            color: rgba(255,255,255,0.9);
            margin-top: 10px;
            margin-bottom: 35px;
            letter-spacing: 0.5px;
        }

        .image-placeholder {
            width: 280px;
            height: 280px;
            background: rgba(255,255,255,0.1);
            border-radius: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(8px);
            border: 2px solid rgba(255,255,255,0.25);
            margin: 0 auto;
            box-shadow: var(--shadow-xl);
            transition: var(--transition);
            animation: floatLogo 6s infinite ease-in-out;
        }
        @keyframes floatLogo {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }
        .image-placeholder img {
            width: 80%;
            height: auto;
            filter: brightness(0) invert(1);
        }

        /* Stats Badges */
        .stats-badge {
            display: flex;
            justify-content: center;
            gap: 25px;
            margin-top: 40px;
        }
        .stat-item {
            text-align: center;
            animation: fadeInUp 0.8s ease;
        }
        .stat-number {
            font-size: 1.8rem;
            font-weight: 800;
            color: #3BC49A;
        }
        .stat-label {
            font-size: 0.75rem;
            opacity: 0.8;
        }

        /* ========== RIGHT SIDE - LOGIN FORM ========== */
        .login-section {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 30px;
            background: linear-gradient(135deg, #ffffff, #f8fafc);
            position: relative;
        }

        .login-box {
            width: 100%;
            max-width: 480px;
            background: var(--white);
            padding: 45px 40px;
            border-radius: 32px;
            box-shadow: var(--shadow-lg);
            transition: var(--transition);
            border: 1px solid rgba(25,167,123,0.1);
            position: relative;
            z-index: 2;
        }
        .login-box:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
            border-color: rgba(25,167,123,0.2);
        }

        .login-header {
            margin-bottom: 32px;
            text-align: center;
        }

        .company-icon-wrapper {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.08));
            border-radius: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            transition: var(--transition);
            animation: iconPulse 3s infinite;
        }
        @keyframes iconPulse {
            0%, 100% { box-shadow: 0 0 0 0 rgba(25,167,123,0.2); }
            50% { box-shadow: 0 0 0 12px rgba(25,167,123,0.08); }
        }
        .company-icon {
            width: 42px;
            height: 42px;
            background: var(--gradient);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 22px;
            font-weight: 800;
            box-shadow: var(--shadow-md);
        }

        h2 {
            color: var(--text-dark);
            margin-bottom: 8px;
            font-size: 2rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            background: linear-gradient(135deg, var(--text-dark), var(--primary));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .login-subtitle {
            color: var(--text-muted);
            font-size: 0.85rem;
            margin-top: 5px;
        }

        /* Form Inputs */
        .input-wrapper {
            margin-bottom: 24px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: var(--text-dark);
            font-size: 0.85rem;
        }

        .input-field {
            position: relative;
        }

        .input-field .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            color: var(--primary);
            pointer-events: none;
        }

        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 14px 14px 14px 48px;
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            font-size: 0.95rem;
            outline: none;
            transition: var(--transition);
            background-color: #f9fdfb;
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
        }

        input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.1);
            background-color: var(--white);
        }

        /* Submit Button */
        button {
            width: 100%;
            background: var(--gradient);
            color: #fff;
            padding: 16px 24px;
            font-size: 1rem;
            border: none;
            border-radius: 60px;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 8px 20px rgba(25,167,123,0.35);
            letter-spacing: 0.3px;
            margin-top: 8px;
            position: relative;
            overflow: hidden;
        }
        button::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255,255,255,0.3);
            transform: translate(-50%, -50%);
            transition: width 0.5s, height 0.5s;
        }
        button:hover::before {
            width: 300px;
            height: 300px;
        }
        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 28px rgba(25,167,123,0.5);
        }

        .forgot {
            text-align: center;
            margin-top: 25px;
        }
        .forgot a {
            color: var(--primary);
            font-size: 0.85rem;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
        }
        .forgot a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        /* Alert Cards */
        .alert-container {
            margin-bottom: 28px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .alert-card {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 18px;
            border-radius: 16px;
            font-size: 0.85rem;
            font-weight: 500;
            animation: fadeInUp 0.5s ease;
        }
        .alert-card i { font-size: 1rem; }
        .alert-card.success { background: linear-gradient(135deg, #e6f7ed, #d4f0e3); color: var(--primary-dark); border-left: 3px solid var(--primary); }
        .alert-card.warning { background: linear-gradient(135deg, #fff4e5, #ffefd6); color: #e67e22; border-left: 3px solid #e67e22; }
        .alert-card.error { background: linear-gradient(135deg, #ffe6e6, #ffdbdb); color: #e74c3c; border-left: 3px solid #e74c3c; }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive */
        @media (max-width: 992px) {
            .main-container { flex-direction: column; }
            .image-section { flex: 0 0 auto; padding: 50px 30px; min-height: 50vh; }
            .image-content h1 { font-size: 2.5rem; }
            .image-placeholder { width: 220px; height: 220px; }
            .stats-badge { margin-top: 25px; }
            .login-section { padding: 50px 20px; }
            .login-box { padding: 35px 30px; }
        }

        @media (max-width: 576px) {
            .login-box { padding: 30px 25px; }
            h2 { font-size: 1.6rem; }
            .image-content h1 { font-size: 2rem; }
            .stats-badge { gap: 15px; }
            .stat-number { font-size: 1.3rem; }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- Left Side - Premium Image Section with Animations -->
        <div class="image-section">
            <div class="particle particle-1"></div>
            <div class="particle particle-2"></div>
            <div class="particle particle-3"></div>
            <div class="particle particle-4"></div>
            <div class="image-content" data-aos="fade-right" data-aos-duration="800">
                <h1>Welcome to JobU</h1>
                <h2>Connecting Companies With the Right Talent</h2>
                <div class="image-placeholder">
                    <i class="fas fa-building" style="font-size: 80px; color: rgba(255,255,255,0.8);"></i>
                </div>
                <div class="stats-badge">
                    <div class="stat-item">
                        <div class="stat-number">10K+</div>
                        <div class="stat-label">Active Jobs</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">5K+</div>
                        <div class="stat-label">Companies</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">50K+</div>
                        <div class="stat-label">Job Seekers</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Side - Login Form Section -->
        <div class="login-section">
            <div class="login-box" data-aos="fade-left" data-aos-duration="800" data-aos-delay="200">
                <div class="login-header">
                    <div class="company-icon-wrapper">
                        <div class="company-icon">
                            <i class="fas fa-building"></i>
                        </div>
                    </div>
                    <h2>Company Login</h2>
                    <p class="login-subtitle">Sign in to access your company dashboard</p>
                </div>

                <!-- Alert Messages (Backend Compatible) -->
                <div class="alert-container">
                    <c:if test="${not empty success}">
                        <div class="alert-card success">
                            <i class="fas fa-check-circle"></i>
                            <span>${success}</span>
                        </div>
                        <script>
                            setTimeout(() => {
                                window.location.href = '${pageContext.request.contextPath}/company/dashboard';
                            }, 1200);
                        </script>
                    </c:if>
                    <c:if test="${not empty warning}">
                        <div class="alert-card warning">
                            <i class="fas fa-exclamation-triangle"></i>
                            <span>${warning}</span>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert-card error">
                            <i class="fas fa-times-circle"></i>
                            <span>${error}</span>
                        </div>
                    </c:if>
                </div>

                <!-- Login Form - BACKEND STRUCTURE UNCHANGED -->
                <form method="post" action="${pageContext.request.contextPath}/company/login1">
                    <div class="input-wrapper">
                        <label for="email">Email Address</label>
                        <div class="input-field">
                            <i class="fas fa-envelope input-icon"></i>
                            <input type="email" id="email" name="email" placeholder="Enter your email" required>
                        </div>
                    </div>

                    <div class="input-wrapper">
                        <label for="password">Password</label>
                        <div class="input-field">
                            <i class="fas fa-lock input-icon"></i>
                            <input type="password" id="password" name="password" placeholder="Enter your password" required>
                        </div>
                    </div>

                    <button type="submit">
                        <i class="fas fa-sign-in-alt me-2"></i> Login
                    </button>

                    <div class="forgot">
                        <a href="${pageContext.request.contextPath}/auth/forgot-password?role=company">
                            <i class="fas fa-question-circle me-1"></i> Forgot password?
                        </a>
                    </div>

                    <a href="${pageContext.request.contextPath}/company/register" style="display: block; text-align: center; width: 100%; background: transparent; color: var(--primary); padding: 14px 24px; font-size: 1rem; border: 2px solid var(--primary); border-radius: 60px; font-weight: 700; text-decoration: none; margin-top: 15px; transition: all 0.3s ease;" onmouseover="this.style.background='rgba(25,167,123,0.1)'" onmouseout="this.style.background='transparent'">
                        <i class="fas fa-user-plus me-2"></i> Register
                    </a>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        // Initialize AOS for scroll animations
        AOS.init({
            duration: 800,
            once: true,
            offset: 50
        });
    </script>
</body>
</html>
