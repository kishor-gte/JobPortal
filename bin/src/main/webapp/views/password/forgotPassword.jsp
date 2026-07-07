<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Forgot Password | JobU - Secure Password Recovery</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        /* ============================================
           ENHANCED PREMIUM COLOR SCHEME
           Primary: #0F172A + #10B981 (Vibrant Mint)
        ============================================ */
        :root {
            --primary: #0F172A;
            --primary-dark: #020617;
            --primary-light: #1E293B;
            --accent: #10B981;
            --accent-dark: #059669;
            --accent-light: #34D399;
            --accent-glow: rgba(16, 185, 129, 0.2);
            --bg-dark: #0F172A;
            --bg-dark-light: #1E293B;
            --bg-light: #F8FAFE;
            --card-bg: rgba(255, 255, 255, 0.98);
            --text-dark: #0F172A;
            --text-muted: #64748B;
            --success: #10B981;
            --danger: #EF4444;
            --warning: #F59E0B;
            --shadow-xs: 0 1px 2px rgba(0, 0, 0, 0.03);
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 20px 35px -8px rgba(0, 0, 0, 0.1);
            --shadow-xl: 0 25px 50px -12px rgba(16, 185, 129, 0.25);
            --shadow-glow: 0 0 20px rgba(16, 185, 129, 0.15);
            --transition: all 0.4s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            --radius-sm: 12px;
            --radius-md: 20px;
            --radius-lg: 28px;
            --radius-xl: 36px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Plus Jakarta Sans', system-ui, sans-serif;
            background: linear-gradient(145deg, #F1F5F9 0%, #EFF6F1 100%);
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        /* animated background mesh */
        body::before {
            content: '';
            position: fixed;
            top: -20%;
            left: -10%;
            width: 120%;
            height: 140%;
            background: radial-gradient(circle at 30% 20%, rgba(16,185,129,0.04) 0%, transparent 50%),
                        radial-gradient(circle at 85% 70%, rgba(59,130,246,0.03) 0%, transparent 60%);
            pointer-events: none;
            z-index: 0;
            animation: slowDrift 22s ease-in-out infinite alternate;
        }

        @keyframes slowDrift {
            0% { transform: translate(0, 0) scale(1); opacity: 0.6; }
            100% { transform: translate(-2%, -3%) scale(1.02); opacity: 1; }
        }

        /* floating particles */
        body::after {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(circle at 20% 40%, rgba(16,185,129,0.04) 1px, transparent 1px);
            background-size: 40px 40px;
            pointer-events: none;
            animation: particleDrift 25s linear infinite;
            z-index: 0;
        }

        @keyframes particleDrift {
            0% { background-position: 0 0; }
            100% { background-position: 65px 65px; }
        }

        .main-container {
            display: flex;
            min-height: 100vh;
            width: 100%;
            position: relative;
            z-index: 1;
        }

        /* LEFT SECTION - Premium Glass Morphism */
        .image-section {
            flex: 1;
            background: linear-gradient(145deg, #0F172A 0%, #1E293B 50%, #0F172A 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 50px 30px;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(2px);
        }

        /* animated gradient orbs */
        .image-section::before {
            content: '';
            position: absolute;
            width: 150%;
            height: 150%;
            top: -25%;
            left: -25%;
            background: radial-gradient(circle at 30% 40%, rgba(16,185,129,0.12), transparent 60%);
            animation: slowOrbit 20s ease-in-out infinite;
        }

        @keyframes slowOrbit {
            0%, 100% { transform: translate(0, 0) scale(1); opacity: 0.5; }
            50% { transform: translate(3%, 2%) scale(1.08); opacity: 0.8; }
        }

        .image-section::after {
            content: '';
            position: absolute;
            inset: 0;
            background: repeating-linear-gradient(45deg, rgba(255,255,255,0.02) 0px, rgba(255,255,255,0.02) 2px, transparent 2px, transparent 10px);
            pointer-events: none;
        }

        .image-content {
            position: relative;
            z-index: 2;
            text-align: center;
            color: white;
            max-width: 420px;
            animation: fadeSlideUp 0.7s cubic-bezier(0.2, 0.9, 0.4, 1.1);
        }

        @keyframes fadeSlideUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .image-content h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 16px;
            letter-spacing: -0.8px;
            background: linear-gradient(120deg, #ffffff, var(--accent-light), #ffffff);
            background-size: 200% auto;
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            animation: shimmer 4s linear infinite;
        }

        @keyframes shimmer {
            0% { background-position: 0% center; }
            100% { background-position: 200% center; }
        }

        .image-content p {
            font-size: 1rem;
            margin-bottom: 32px;
            opacity: 0.85;
            line-height: 1.6;
        }

        .image-placeholder {
            width: 280px;
            height: 280px;
            background: linear-gradient(135deg, rgba(255,255,255,0.08), rgba(255,255,255,0.02));
            border-radius: 48px;
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255,255,255,0.15);
            margin: 0 auto;
            box-shadow: 0 25px 45px -12px rgba(0,0,0,0.4);
            transition: var(--transition);
            background-image: url('${pageContext.request.contextPath}/assets/images/logo/logo.png');
            background-repeat: no-repeat;
            background-position: center;
            background-size: 65%;
            position: relative;
            overflow: hidden;
        }

        .image-placeholder::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at 50% 50%, rgba(16,185,129,0.15), transparent);
            animation: softPulse 3s ease-in-out infinite;
        }

        @keyframes softPulse {
            0%, 100% { opacity: 0.4; }
            50% { opacity: 0.8; }
        }

        .image-placeholder:hover {
            transform: scale(1.02);
            border-color: rgba(16,185,129,0.4);
            box-shadow: 0 30px 55px -15px rgba(0,0,0,0.5);
        }

        /* RIGHT SECTION - Premium Card */
        .login-section {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 30px;
            background: transparent;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.97);
            backdrop-filter: blur(12px);
            padding: 42px 38px;
            border-radius: 52px;
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(16,185,129,0.1);
            width: 100%;
            max-width: 480px;
            text-align: center;
            transition: var(--transition);
            animation: fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
            border: 1px solid rgba(255,255,255,0.5);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px) scale(0.96); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .login-container:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(16,185,129,0.2);
        }

        .login-header {
            margin-bottom: 32px;
        }

        /* premium animated icon wrapper */
        .forgot-icon-wrapper {
            width: 88px;
            height: 88px;
            background: linear-gradient(145deg, rgba(16,185,129,0.1), rgba(16,185,129,0.04));
            border-radius: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 24px;
            position: relative;
            transition: var(--transition);
            animation: gentlePulse 2.5s ease-in-out infinite;
        }

        @keyframes gentlePulse {
            0%, 100% { box-shadow: 0 0 0 0 rgba(16,185,129,0.2); }
            50% { box-shadow: 0 0 0 18px rgba(16,185,129,0); }
        }

        .forgot-icon-wrapper::before {
            content: '';
            position: absolute;
            inset: -2px;
            border-radius: 34px;
            background: linear-gradient(135deg, var(--accent), var(--accent-light));
            opacity: 0.3;
            transition: opacity 0.3s;
        }

        .forgot-icon-wrapper:hover::before {
            opacity: 0.6;
        }

        .forgot-icon {
            width: 58px;
            height: 58px;
            background: linear-gradient(145deg, var(--accent), var(--accent-dark));
            border-radius: 26px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: 700;
            box-shadow: 0 10px 22px rgba(16,185,129,0.3);
            transition: var(--transition);
        }

        .forgot-icon-wrapper:hover .forgot-icon {
            transform: scale(1.05);
        }

        h3 {
            color: var(--primary);
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 10px;
            letter-spacing: -0.6px;
        }

        .login-subtitle {
            color: var(--text-muted);
            font-size: 0.85rem;
            font-weight: 500;
            max-width: 320px;
            margin: 0 auto;
            line-height: 1.5;
        }

        label {
            font-size: 0.7rem;
            font-weight: 700;
            color: var(--accent-dark);
            margin-bottom: 8px;
            text-align: left;
            display: block;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .input-wrapper {
            position: relative;
            margin-bottom: 24px;
        }

        .input-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--accent);
            font-size: 1rem;
            transition: all 0.25s;
            z-index: 2;
            pointer-events: none;
        }

        input[type="email"] {
            width: 100%;
            padding: 15px 18px 15px 52px;
            border: 2px solid #E2E8F0;
            border-radius: 60px;
            background-color: #ffffff;
            font-size: 0.9rem;
            font-weight: 500;
            transition: var(--transition);
            font-family: 'Inter', sans-serif;
            color: var(--text-dark);
        }

        input[type="email"]:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 5px rgba(16, 185, 129, 0.12);
            background-color: #fff;
        }

        .input-wrapper:focus-within .input-icon {
            color: var(--accent-dark);
            transform: translateY(-50%) scale(1.08);
        }

        button[type="submit"] {
            background: linear-gradient(105deg, var(--accent), var(--accent-dark));
            color: white;
            border: none;
            padding: 15px 24px;
            width: 100%;
            border-radius: 60px;
            font-size: 0.95rem;
            font-weight: 700;
            margin-top: 16px;
            transition: var(--transition);
            letter-spacing: 0.3px;
            cursor: pointer;
            box-shadow: 0 12px 25px -8px rgba(16, 185, 129, 0.45);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        button[type="submit"]:hover {
            background: linear-gradient(105deg, var(--accent-dark), #047857);
            transform: translateY(-3px);
            box-shadow: 0 20px 35px -12px rgba(16, 185, 129, 0.55);
        }

        button[type="submit"]:active {
            transform: translateY(0);
        }

        .alert {
            border-radius: 24px;
            padding: 14px 20px;
            margin-bottom: 24px;
            font-size: 0.8rem;
            font-weight: 600;
            border: none;
            backdrop-filter: blur(4px);
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.12);
            color: #10b981;
            border-left: 4px solid #10b981;
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.12);
            color: #ef4444;
            border-left: 4px solid #ef4444;
        }

        .register-link {
            margin-top: 32px;
            padding-top: 28px;
            border-top: 2px solid #E2E8F0;
        }

        .register-link p {
            font-size: 0.85rem;
            color: var(--text-muted);
            font-weight: 500;
        }

        .register-link a {
            color: var(--accent);
            font-weight: 700;
            text-decoration: none;
            transition: 0.25s;
            position: relative;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .register-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent), var(--accent-light));
            transition: width 0.3s ease;
        }

        .register-link a:hover::after {
            width: 100%;
        }

        .register-link a:hover {
            color: var(--accent-dark);
            transform: translateX(3px);
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

        /* Custom Input Placeholder */
        input::placeholder {
            color: #A0AEC0;
            font-weight: 400;
            font-size: 0.85rem;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .main-container {
                flex-direction: column;
            }
            .image-section {
                padding: 50px 20px;
                min-height: 340px;
            }
            .image-placeholder {
                width: 200px;
                height: 200px;
            }
            .image-content h1 {
                font-size: 2rem;
            }
            .login-section {
                padding: 50px 20px;
            }
            .login-container {
                padding: 36px 32px;
                max-width: 500px;
                margin: 0 auto;
            }
            h3 {
                font-size: 26px;
            }
        }

        @media (max-width: 576px) {
            .login-container {
                padding: 28px 22px;
                border-radius: 40px;
            }
            h3 {
                font-size: 22px;
            }
            .forgot-icon-wrapper {
                width: 72px;
                height: 72px;
            }
            .forgot-icon {
                width: 48px;
                height: 48px;
                font-size: 20px;
            }
            button[type="submit"] {
                padding: 13px 20px;
                font-size: 0.85rem;
            }
            .image-content p {
                font-size: 0.85rem;
            }
            .login-subtitle {
                font-size: 0.75rem;
            }
        }

        @media (max-width: 380px) {
            .login-container {
                padding: 24px 18px;
            }
            .image-placeholder {
                width: 160px;
                height: 160px;
            }
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

<div class="main-container">
    <!-- Left Side - Premium Image/Info Section -->
    <div class="image-section">
        <div class="image-content">
            <h1>Secure Account Recovery</h1>
            <p>We'll help you get back into your account safely and quickly</p>
            <div class="image-placeholder"></div>
        </div>
    </div>

    <!-- Right Side - Forgot Password Form Section -->
    <div class="login-section">
        <div class="login-container">
            <div class="login-header">
                <div class="forgot-icon-wrapper">
                    <div class="forgot-icon"><i class="fas fa-lock"></i></div>
                </div>
                <h3>Forgot Password?</h3>
                <p class="login-subtitle">Don't worry! Enter your email and we'll send you a secure link to reset your password.</p>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i> ${message}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/jobSeekers/forgot-password" method="POST">
                <input type="hidden" name="role" value="${role}">
                <div class="mb-3">
                    <label for="email" class="form-label"><i class="far fa-envelope me-1"></i> Email Address</label>
                    <div class="input-wrapper">
                        <i class="fas fa-envelope input-icon"></i>
                        <input type="email" class="form-control" id="email" name="email" placeholder="your@email.com" required>
                    </div>
                </div>
                <button type="submit">
                    <i class="fas fa-paper-plane"></i> Send Reset Link
                </button>
            </form>

            <div class="register-link">
                <p>
                    <i class="fas fa-arrow-left me-1"></i> Remember your password? 
                    <c:choose>
                        <c:when test="${role == 'company'}">
                            <a href="${pageContext.request.contextPath}/company/login">
                                Back to Login <i class="fas fa-arrow-right fa-xs"></i>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/jobSeekers/login">
                                Back to Login <i class="fas fa-arrow-right fa-xs"></i>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
    </div>
</div>

</body>
</html>