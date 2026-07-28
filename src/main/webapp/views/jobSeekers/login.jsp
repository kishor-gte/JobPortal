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
    
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #0B8260;
            --primary-dark: #086147;
            --accent: #0eb082;
            --slate-900: #042e1c;
            --white: #ffffff;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: url('${pageContext.request.contextPath}/assets/images/job_portal_bg.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            overflow-x: hidden;
            position: relative;
        }

        /* Blur overlay on top of the background image */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.15); /* Slight dark tint to make green pop */
            backdrop-filter: blur(3px);
            -webkit-backdrop-filter: blur(3px);
            z-index: 0;
            pointer-events: none;
        }

        .back-home-btn {
            position: absolute;
            top: 24px;
            left: 24px;
            z-index: 1000;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: var(--primary);
            border: 1px solid var(--primary-dark);
            border-radius: 30px;
            color: white !important;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: var(--transition);
        }

        .back-home-btn:hover {
            background: var(--primary-dark);
            color: white !important;
            transform: translateX(-4px);
        }

        .login-card-wrapper {
            width: 100%;
            max-width: 440px;
            position: relative;
            z-index: 10;
        }

        /* Glassmorphism single box */
        .glass-login-box {
            background: linear-gradient(135deg, rgba(7, 82, 61, 0.95) 0%, rgba(11, 130, 96, 0.95) 100%);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.25);
            border-radius: 35px;
            padding: 50px 35px 40px 35px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
            text-align: center;
            position: relative;
            margin-top: 40px; /* Offset to accommodate the circular icon badge */
        }

        /* Top circular white badge */
        .top-circular-badge {
            width: 84px;
            height: 84px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.18);
            position: absolute;
            top: -42px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 11;
        }

        .top-circular-badge i {
            font-size: 2.2rem;
            color: var(--primary);
        }

        .login-title-head {
            color: white;
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 30px;
            letter-spacing: -0.5px;
        }

        /* Form Inputs */
        .input-group-custom {
            position: relative;
            margin-bottom: 22px;
        }

        .input-icon-custom {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.95);
            font-size: 1.15rem;
            pointer-events: none;
            z-index: 10;
        }

        .field-input-custom {
            width: 100%;
            height: 54px;
            padding: 10px 20px 10px 52px;
            background: rgba(0, 0, 0, 0.18);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 30px;
            font-size: 15px;
            color: white;
            outline: none;
            transition: var(--transition);
        }

        .field-input-custom::placeholder {
            color: rgba(255, 255, 255, 0.65);
        }

        .field-input-custom:focus {
            background: rgba(0, 0, 0, 0.25);
            border-color: rgba(255, 255, 255, 0.45);
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.15);
        }

        /* Checkbox and links block */
        .options-row-custom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.9);
        }

        .remember-checkbox-label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            user-select: none;
        }

        .remember-checkbox-label input {
            cursor: pointer;
            accent-color: var(--primary);
            width: 15px;
            height: 15px;
        }

        .forgot-link-custom {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            transition: var(--transition);
        }

        .forgot-link-custom:hover {
            color: white;
            text-decoration: underline;
        }

        /* Submit Button */
        .btn-submit-white {
            width: 100%;
            height: 54px;
            background: white;
            color: var(--primary);
            font-size: 1rem;
            font-weight: 700;
            border-radius: 30px;
            border: none;
            cursor: pointer;
            transition: var(--transition);
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .btn-submit-white:hover {
            background: #e6f6ee;
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        /* Bottom Links */
        .bottom-links-box {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.15);
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.8);
        }

        .bottom-links-box a {
            color: white;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
        }

        .bottom-links-box a:hover {
            text-decoration: underline;
        }

        /* Alerts design */
        .alert-custom {
            padding: 12px 18px;
            border-radius: 16px;
            margin-bottom: 20px;
            font-size: 0.9rem;
            text-align: left;
            display: flex;
            align-items: center;
            gap: 10px;
            border: 1px solid rgba(255,255,255,0.2);
            color: white;
        }

        .alert-custom-danger {
            background: rgba(239, 68, 68, 0.25);
        }

        .alert-custom-success {
            background: rgba(11, 130, 96, 0.3);
        }

        .spinner-loader {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid rgba(11, 130, 96, 0.2);
            border-top-color: var(--primary);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        @media (max-width: 576px) {
            .back-home-btn {
                position: relative;
                top: 0;
                left: 0;
                margin-bottom: 20px;
                display: inline-flex;
            }
            body {
                flex-direction: column;
                justify-content: flex-start;
                padding-top: 40px;
            }
            .glass-login-box {
                padding: 45px 20px 30px 20px;
            }
        }
    </style>
</head>
<body>

    <a href="${pageContext.request.contextPath}/" class="back-home-btn">
        <i class="fas fa-arrow-left"></i> Back to Home
    </a>

    <div class="login-card-wrapper">
        <div class="glass-login-box">
            <!-- Circular Top Badge -->
            <div class="top-circular-badge">
                <i class="fas fa-user-circle"></i>
            </div>

            <h3 class="login-title-head">Job Seeker Login</h3>

            <!-- Error message container -->
            <c:if test="${not empty error}">
                <div class="alert-custom alert-custom-danger">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <!-- Success message container -->
            <c:if test="${not empty message}">
                <div class="alert-custom alert-custom-success">
                    <i class="fas fa-check-circle"></i> ${message}
                </div>
            </c:if>

            <!-- Form -->
            <form action="${pageContext.request.contextPath}/jobSeekers/login1" method="post" id="loginForm">
                <!-- Username / Email field -->
                <div class="input-group-custom">
                    <i class="fas fa-user input-icon-custom"></i>
                    <input type="email" class="field-input-custom" name="email" id="email" placeholder="Username / Email" required autocomplete="off">
                </div>

                <!-- Password field -->
                <div class="input-group-custom">
                    <i class="fas fa-lock input-icon-custom"></i>
                    <input type="password" class="field-input-custom" name="password" id="password" placeholder="Password" required style="padding-right: 50px;">
                    <i class="far fa-eye" id="togglePassword" style="position: absolute; right: 20px; top: 50%; transform: translateY(-50%); cursor: pointer; color: rgba(255, 255, 255, 0.7); z-index: 10;"></i>
                </div>

                <!-- Remember Me and Forgot Password -->
                <div class="options-row-custom">
                    <label class="remember-checkbox-label">
                        <input type="checkbox" name="remember" id="remember">
                        Remember Me
                    </label>
                    <a href="${pageContext.request.contextPath}/user/forgot-password" class="forgot-link-custom">Forgot Password?</a>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-submit-white" id="submitBtn">
                    LOGIN
                </button>
            </form>

            <!-- Registration links -->
            <div class="bottom-links-box">
                <p>
                    Don't have an account? 
                    <a href="${pageContext.request.contextPath}/jobSeekers/register">Sign Up</a>
                </p>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Password toggle
            const togglePassword = document.querySelector('#togglePassword');
            const passwordInput = document.querySelector('#password');
            if (togglePassword && passwordInput) {
                togglePassword.addEventListener('click', function (e) {
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
                    this.classList.toggle('fa-eye-slash');
                    this.classList.toggle('fa-eye');
                });
            }

            // Spinner submit trigger
            const form = document.getElementById('loginForm');
            const submitBtn = document.getElementById('submitBtn');
            if (form && submitBtn) {
                form.addEventListener('submit', function(e) {
                    submitBtn.innerHTML = '<span class="spinner-loader"></span> SIGNING IN...';
                    submitBtn.disabled = true;
                });
            }
        });
    </script>
</body>
</html>
