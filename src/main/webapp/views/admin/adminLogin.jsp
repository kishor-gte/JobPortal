<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobU Admin Login | Premium Access</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-dark-light: #3d5256;
            --glass-white: rgba(255, 255, 255, 0.98);
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

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 40%, rgba(25,167,123,0.05) 0%, transparent 35%),
                radial-gradient(circle at 80% 70%, rgba(59,196,154,0.05) 0%, transparent 40%);
            pointer-events: none;
            z-index: 0;
            animation: meshShift 15s ease-in-out infinite alternate;
        }
        
        @keyframes meshShift {
            0% { opacity: 0.6; transform: scale(1); }
            100% { opacity: 1; transform: scale(1.05); }
        }

        .main-container {
            display: flex;
            min-height: 100vh;
            width: 100%;
            position: relative;
            z-index: 1;
        }

        .image-section {
            flex: 1;
            background: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-dark-light) 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 60px 50px;
            position: relative;
            overflow: hidden;
        }

        .image-content {
            text-align: center;
            color: white;
            z-index: 2;
        }

        .image-content h1 {
            font-size: 48px;
            font-weight: 800;
            margin-bottom: 12px;
            letter-spacing: -1px;
            background: linear-gradient(135deg, #ffffff, rgba(255,255,255,0.85));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .image-content h2 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--accent);
        }

        .image-content h3 {
            font-size: 18px;
            font-weight: 400;
            opacity: 0.85;
            margin-top: 20px;
        }

        .image-placeholder {
            width: 270px;
            height: 270px;
            background: linear-gradient(135deg, rgba(255,255,255,0.1), rgba(255,255,255,0.02));
            border-radius: 50px;
            backdrop-filter: blur(16px);
            border: 1px solid rgba(255,255,255,0.25);
            margin: 30px auto 0;
            box-shadow: 0 35px 55px -20px rgba(0,0,0,0.5);
            background-image: url('${pageContext.request.contextPath}/assets/images/logo/logo.png');
            background-repeat: no-repeat;
            background-position: center;
            background-size: 65%;
        }

        .login-section {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 20px;
            background: transparent;
        }

        .login-container {
            background: var(--glass-white);
            padding: 48px 42px;
            border-radius: 56px;
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.12);
            width: 100%;
            max-width: 520px;
            text-align: center;
        }

        .login-header {
            margin-bottom: 32px;
        }

        .admin-icon-wrapper {
            width: 85px;
            height: 85px;
            background: linear-gradient(145deg, rgba(25,167,123,0.12), rgba(59,196,154,0.06));
            border-radius: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 22px;
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
        }

        h3 {
            color: var(--bg-dark);
            font-size: 32px;
            font-weight: 800;
            margin-bottom: 8px;
            letter-spacing: -0.8px;
        }

        .login-subtitle {
            color: #7a9b8f;
            font-size: 14px;
            font-weight: 500;
        }

        .form-group {
            margin-bottom: 22px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary);
            font-size: 1.1rem;
            z-index: 2;
            pointer-events: none;
        }

        .form-control {
            width: 100%;
            padding: 15px 20px 15px 54px;
            border: 2px solid #e8f0ec;
            border-radius: 28px;
            background-color: #ffffff;
            font-size: 14px;
            font-weight: 500;
            font-family: 'Inter', sans-serif;
            color: var(--bg-dark);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 6px rgba(25, 167, 123, 0.12);
        }

        .btn-primary {
            background: linear-gradient(105deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            border: none;
            padding: 16px 28px;
            font-size: 16px;
            font-weight: 700;
            border-radius: 50px;
            cursor: pointer;
            width: 100%;
            margin-top: 12px;
            box-shadow: 0 12px 28px -10px rgba(25, 167, 123, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .btn-primary:hover {
            background: linear-gradient(105deg, var(--primary-dark) 0%, #0d5e44 100%);
            transform: translateY(-3px);
        }

        .alert {
            padding: 14px 22px;
            border-radius: 24px;
            margin-bottom: 24px;
            font-size: 13px;
            text-align: left;
            font-weight: 600;
            border: none;
        }

        .alert-danger {
            background: linear-gradient(135deg, #fff8f5, #fff0ea);
            color: #c44522;
            border-left: 4px solid #e85d3a;
        }

        .alert-success {
            background: linear-gradient(135deg, #edfaf5, #e0f5ec);
            color: #1a7a5a;
            border-left: 4px solid var(--primary);
        }

        .register-link {
            margin-top: 32px;
            padding-top: 28px;
            border-top: 2px solid #eaf3ef;
        }

        .register-link p {
            color: #7a9b8f;
            font-size: 14px;
            font-weight: 500;
            margin: 0;
        }

        .register-link a {
            text-decoration: none;
            color: var(--primary);
            font-weight: 700;
        }

        .register-link a:hover {
            color: var(--primary-dark);
        }

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
            .image-placeholder {
                width: 200px;
                height: 200px;
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
        @media (max-width: 968px) {
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
    <div class="image-section">
        <div class="image-content">
            <h1>Welcome to JobU</h1>
            <h2>Admin Portal</h2>
            <h3>Secure access for administrators</h3>
            <div class="image-placeholder"></div>
        </div>
    </div>

    <div class="login-section">
        <div class="login-container">
            <div class="login-header">
                <div class="admin-icon-wrapper">
                    <div class="admin-icon"><i class="fas fa-user-shield"></i></div>
                </div>
                <h3>Admin Login</h3>
                <p class="login-subtitle">Sign in to access the admin dashboard</p>
            </div>

            <form action="${pageContext.request.contextPath}/PostloginAdmin" method="post" id="loginForm">
                <div class="form-group">
                    <div class="input-wrapper">
                        <i class="fas fa-envelope input-icon"></i>
                        <input type="email" name="email" placeholder="Email Address" class="form-control" required autocomplete="email">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-wrapper">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="adminLoginPwd" name="password" placeholder="Password" class="form-control" required autocomplete="current-password" style="padding-right: 50px;">
                        <span onclick="toggleAdminLoginPwd()" id="adminLoginEye" style="position:absolute;right:20px;top:50%;transform:translateY(-50%);cursor:pointer;color:#19A77B;font-size:1.1rem;z-index:3;"><i class="fas fa-eye"></i></span>
                    </div>
                    <small style="display:block;margin-top:6px;font-size:0.75rem;color:#94a3b8;text-align:left;padding-left:4px;">
                        <i class="fas fa-info-circle" style="color:#19A77B;margin-right:4px;"></i>
                        Min 6 chars, 1 uppercase, 1 lowercase &amp; 1 special character
                    </small>
                </div>

                <button type="submit" class="btn-primary" id="loginBtn">
                    <i class="fas fa-arrow-right-to-bracket"></i> Sign In
                </button>
            </form>

            <div class="register-link" style="margin-bottom: 15px;">
                <p><a href="${pageContext.request.contextPath}/admin/forgot-password"><i class="fas fa-key" style="margin-right: 8px; color: var(--primary);"></i> Forgot Password?</a></p>
            </div>

        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('loginForm');
    const loginBtn = document.getElementById('loginBtn');
    
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            if (loginBtn) {
                loginBtn.innerHTML = '<i class="fas fa-spinner"></i> Signing In...';
            }
        });
    }
});

function toggleAdminLoginPwd() {
    const input = document.getElementById('adminLoginPwd');
    const icon = document.getElementById('adminLoginEye');
    const isText = input.type === 'text';
    input.type = isText ? 'password' : 'text';
    icon.innerHTML = isText ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
}
</script>
</body>
</html>
