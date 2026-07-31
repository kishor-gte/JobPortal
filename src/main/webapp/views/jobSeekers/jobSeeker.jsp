<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Seeker Registration | SmartInterview</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #0B8260;
            --primary-dark: #086147;
            --accent: #0eb082;
            --white: #ffffff;
            --danger: #ff4d4d;
            --success: #0eb082;
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
            padding: 40px 24px;
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

        .register-card-wrapper {
            width: 100%;
            max-width: 460px;
            position: relative;
            z-index: 10;
        }

        /* Glassmorphism single box */
        .glass-register-box {
            background: linear-gradient(135deg, rgba(7, 82, 61, 0.95) 0%, rgba(11, 130, 96, 0.95) 100%);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.25);
            border-radius: 35px;
            padding: 40px 30px 30px 30px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
            text-align: center;
            position: relative;
            margin-top: 30px; /* Offset to accommodate the circular icon badge */
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

        .register-title-head {
            color: white;
            font-size: 1.6rem;
            font-weight: 700;
            margin-bottom: 5px;
            letter-spacing: -0.5px;
        }

        .register-subtitle-head {
            color: rgba(255, 255, 255, 0.75);
            font-size: 0.85rem;
            margin-bottom: 20px;
        }

        /* Form Inputs */
        .input-group-custom {
            position: relative;
            margin-bottom: 2px;
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
            height: 46px;
            padding: 8px 20px 8px 50px;
            background: rgba(0, 0, 0, 0.18);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 30px;
            font-size: 14px;
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

        /* Checkbox */
        .options-row-custom {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            margin-top: 15px;
            margin-bottom: 25px;
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.9);
            text-align: left;
        }

        .terms-checkbox-label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            user-select: none;
        }

        .terms-checkbox-label input {
            cursor: pointer;
            accent-color: var(--primary);
            width: 15px;
            height: 15px;
        }

        .terms-checkbox-label a {
            color: white;
            text-decoration: underline;
        }

        /* Submit Button */
        .btn-submit-white {
            width: 100%;
            height: 48px;
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
            margin-top: 25px;
            padding-top: 15px;
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

        /* Validation Alerts */
        .password-match {
            font-size: 0.8rem;
            margin-top: 2px;
            margin-bottom: 8px;
            display: none;
            align-items: center;
            gap: 6px;
            text-align: left;
            padding-left: 15px;
        }

        .password-match.mismatch {
            color: #ffcccc;
        }

        .password-match.match {
            color: #ccffdd;
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
            .glass-register-box {
                padding: 45px 20px 30px 20px;
            }
        }
    </style>
</head>
<body>

    <a href="${pageContext.request.contextPath}/" class="back-home-btn">
        <i class="fas fa-arrow-left"></i> Back to Home
    </a>

    <div class="register-card-wrapper">
        <div class="glass-register-box">
            <!-- Circular Top Badge -->
            <div class="top-circular-badge">
                <i class="fas fa-user-plus"></i>
            </div>

            <h3 class="register-title-head">Sign Up</h3>
            <p class="register-subtitle-head">Create your Job Seeker account</p>

            <!-- Display error message if registration fails -->
            <c:if test="${not empty error}">
                <div class="alert-custom alert-custom-danger">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="alert-custom alert-custom-success">
                    <i class="fas fa-check-circle"></i> ${message}
                </div>
            </c:if>

            <!-- Form -->
            <form action="${pageContext.request.contextPath}/jobSeekers/signup" method="post" id="registrationForm">
                
                <!-- Full Name -->
                <div class="mb-3">
                    <div class="input-group-custom">
                        <i class="fas fa-user input-icon-custom"></i>
                        <input type="text" class="field-input-custom" id="name" name="name" placeholder="Full Name" required autocomplete="off">
                    </div>
                    <div id="nameError" class="password-match mismatch"></div>
                </div>

                <!-- Mobile Number -->
                <div class="mb-3">
                    <div class="input-group-custom">
                        <i class="fas fa-phone input-icon-custom"></i>
                        <input type="tel" class="field-input-custom" id="phone" name="phone" placeholder="Mobile Number" required autocomplete="off">
                    </div>
                    <div id="phoneError" class="password-match mismatch"></div>
                </div>

                <!-- Email Address -->
                <div class="mb-3">
                    <div class="input-group-custom">
                        <i class="fas fa-envelope input-icon-custom"></i>
                        <input type="email" class="field-input-custom" id="email" name="email" placeholder="Email Address" required autocomplete="off">
                    </div>
                    <div id="emailError" class="password-match mismatch"></div>
                </div>

                <!-- Password -->
                <div class="mb-3">
                    <div class="input-group-custom">
                        <i class="fas fa-lock input-icon-custom"></i>
                        <input type="password" class="field-input-custom" id="password" name="password" placeholder="Password" required style="padding-right: 50px;">
                        <i class="far fa-eye" id="togglePassword" style="position: absolute; right: 20px; top: 50%; transform: translateY(-50%); cursor: pointer; color: rgba(255, 255, 255, 0.7); z-index: 10;"></i>
                    </div>
                    <div id="passwordError" class="password-match mismatch"></div>
                </div>

                <!-- Confirm Password -->
                <div class="mb-3">
                    <div class="input-group-custom">
                        <i class="fas fa-lock input-icon-custom"></i>
                        <input type="password" class="field-input-custom" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required style="padding-right: 50px;">
                        <i class="far fa-eye" id="toggleConfirmPassword" style="position: absolute; right: 20px; top: 50%; transform: translateY(-50%); cursor: pointer; color: rgba(255, 255, 255, 0.7); z-index: 10;"></i>
                    </div>
                    <div id="passwordMatch" class="password-match"></div>
                </div>

                <!-- Terms and Conditions Checkbox -->
                <div class="options-row-custom">
                    <label class="terms-checkbox-label">
                        <input type="checkbox" id="flexCheckDefault" required>
                        I agree to the <a href="${pageContext.request.contextPath}/terms-conditions.html" target="_blank">Terms & Conditions</a>
                    </label>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-submit-white" id="submitBtn">
                    SIGN UP
                </button>
            </form>

            <!-- Bottom Links -->
            <div class="bottom-links-box">
                <p>
                    Already have an account? 
                    <a href="${pageContext.request.contextPath}/jobSeekers/login">Login Here</a>
                </p>
            </div>
        </div>
    </div>

    <!-- Script validation logic matching original rules -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const togglePassword = document.querySelector('#togglePassword');
            const toggleConfirmPassword = document.querySelector('#toggleConfirmPassword');
            const passwordInput = document.getElementById('password');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            
            if (togglePassword && passwordInput) {
                togglePassword.addEventListener('click', function (e) {
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
                    this.classList.toggle('fa-eye-slash');
                    this.classList.toggle('fa-eye');
                });
            }

            if (toggleConfirmPassword && confirmPasswordInput) {
                toggleConfirmPassword.addEventListener('click', function (e) {
                    const type = confirmPasswordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    confirmPasswordInput.setAttribute('type', type);
                    this.classList.toggle('fa-eye-slash');
                    this.classList.toggle('fa-eye');
                });
            }

            const name = document.getElementById('name');
            const phone = document.getElementById('phone');
            const email = document.getElementById('email');
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            const nameError = document.getElementById('nameError');
            const phoneError = document.getElementById('phoneError');
            const emailError = document.getElementById('emailError');
            const passwordError = document.getElementById('passwordError');
            const passwordMatch = document.getElementById('passwordMatch');
            const form = document.getElementById('registrationForm');

            function validateName() {
                let val = name.value.trim();
                if (!val) {
                    nameError.style.display = 'none';
                    name.style.borderColor = '';
                    return false;
                }
                if (val.length < 3) {
                    nameError.style.display = 'flex';
                    nameError.innerHTML = '<i class="fas fa-times-circle"></i> Name must be at least 3 characters';
                    return false;
                }
                nameError.style.display = 'none';
                return true;
            }

            function validatePhone() {
                let val = phone.value.trim();
                if (!val) {
                    phoneError.style.display = 'none';
                    phone.style.borderColor = '';
                    return false;
                }
                const regex = /^[0-9]{10}$/;
                if (!regex.test(val)) {
                    phoneError.style.display = 'flex';
                    phoneError.innerHTML = '<i class="fas fa-times-circle"></i> Please enter a valid 10-digit number';
                    return false;
                }
                phoneError.style.display = 'none';
                return true;
            }

            function validateEmail() {
                let val = email.value;
                if (!val) {
                    emailError.style.display = 'none';
                    email.style.borderColor = '';
                    return false;
                }
                const regex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}$/;
                if (!regex.test(val)) {
                    emailError.style.display = 'flex';
                    emailError.innerHTML = '<i class="fas fa-times-circle"></i> Please enter a valid email address';
                    return false;
                } else {
                    emailError.style.display = 'none';
                    return true;
                }
            }

            function validatePassword() {
                let val = password.value;
                if (!val) {
                    passwordError.style.display = 'none';
                    password.style.borderColor = '';
                    return false;
                }
                let errorMsg = '';
                if (val.length < 6 || val.length > 32) errorMsg = 'Password must be between 6 and 32 characters.';
                else if (!/[A-Z]/.test(val)) errorMsg = 'Password must contain at least one uppercase letter.';
                else if (!/[a-z]/.test(val)) errorMsg = 'Password must contain at least one lowercase letter.';
                else if (!/[0-9]/.test(val)) errorMsg = 'Password must contain at least one number.';
                else if (!/[!@#$%^&*()_+\-=\[\]{}|;:',.<>?/]/.test(val)) errorMsg = 'Password must contain at least one special character.';
                else if (/\s/.test(val)) errorMsg = 'Password must not contain spaces.';

                if (errorMsg) {
                    passwordError.style.display = 'flex';
                    passwordError.innerHTML = '<i class="fas fa-times-circle"></i> ' + errorMsg;
                    return false;
                } else {
                    passwordError.style.display = 'none';
                    return true;
                }
            }

            function checkPasswordMatch() {
                if (confirmPassword.value === '') {
                    passwordMatch.style.display = 'none';
                    return false;
                }
                
                passwordMatch.style.display = 'flex';
                if (password.value === confirmPassword.value) {
                    passwordMatch.innerHTML = '<i class="fas fa-check-circle"></i> Passwords match';
                    passwordMatch.className = 'password-match match';
                    return true;
                } else {
                    passwordMatch.innerHTML = '<i class="fas fa-times-circle"></i> Passwords do not match';
                    passwordMatch.className = 'password-match mismatch';
                    return false;
                }
            }

            name.addEventListener('input', validateName);
            name.addEventListener('blur', function() { name.value = name.value.trim(); validateName(); });

            phone.addEventListener('input', validatePhone);
            phone.addEventListener('blur', function() { phone.value = phone.value.trim(); validatePhone(); });

            email.addEventListener('input', validateEmail);
            email.addEventListener('blur', function() { email.value = email.value.trim().toLowerCase(); validateEmail(); });
            
            password.addEventListener('input', function() { validatePassword(); checkPasswordMatch(); });
            password.addEventListener('blur', function() { password.value = password.value.trim(); validatePassword(); checkPasswordMatch(); });

            confirmPassword.addEventListener('input', checkPasswordMatch);
            confirmPassword.addEventListener('blur', function() { confirmPassword.value = confirmPassword.value.trim(); checkPasswordMatch(); });

            form.addEventListener('submit', function(e) {
                let isNameValid = validateName();
                let isPhoneValid = validatePhone();
                let isEmailValid = validateEmail();
                let isPasswordValid = validatePassword();
                let isMatch = checkPasswordMatch();
                
                if (!isNameValid || !isPhoneValid || !isEmailValid || !isPasswordValid || !isMatch) {
                    e.preventDefault();
                    if (!isMatch) confirmPassword.focus();
                    else if (!isPasswordValid) password.focus();
                    else if (!isEmailValid) email.focus();
                    else if (!isPhoneValid) phone.focus();
                    else if (!isNameValid) name.focus();
                    return false;
                }
            });
        });
    </script>
</body>
</html>
