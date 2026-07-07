<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Job Seeker Registration | SmartInterview</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
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
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 20px;
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

        /* Trigger Button Styling */
        .text-center {
            position: relative;
            z-index: 1;
        }

        .btn-primary {
            background: var(--gradient-primary);
            border: none;
            padding: 14px 36px;
            font-size: 18px;
            font-weight: 600;
            border-radius: 50px;
            box-shadow: 0 4px 16px rgba(25, 167, 123, 0.3);
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 28px rgba(25, 167, 123, 0.4);
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
        }

        .btn-primary i {
            margin-right: 8px;
        }

        /* Modal Styling */
        .modal-content {
            border: none;
            border-radius: 24px;
            box-shadow: var(--shadow-lg);
            background: #ffffff;
            overflow: hidden;
            position: relative;
        }

        .modal-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
        }

        .btn-close {
            width: 32px;
            height: 32px;
            background: #f1f5f9;
            border-radius: 50%;
            opacity: 0.7;
            transition: all 0.3s ease;
        }

        .btn-close:hover {
            opacity: 1;
            background: #e2e8f0;
            transform: rotate(90deg);
        }

        .modal-header {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .modal-header h3 {
            font-size: 28px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 8px;
        }

        .modal-header p {
            font-size: 14px;
            color: #64748b;
            margin-bottom: 20px;
        }

        .register-icon {
            width: 64px;
            height: 64px;
            background: rgba(25, 167, 123, 0.1);
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            border: 1px solid rgba(25, 167, 123, 0.2);
        }

        .register-icon i {
            font-size: 32px;
            color: var(--primary);
        }

        .form-label {
            font-size: 14px;
            font-weight: 600;
            color: #475569;
            margin-bottom: 8px;
        }

        .form-control {
            border: 2px solid #e0e6ed;
            border-radius: 14px;
            padding: 14px 18px;
            font-size: 15px;
            transition: all 0.3s ease;
            background: #f8fafc;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25, 167, 123, 0.1);
            background: #ffffff;
        }

        .form-control::placeholder {
            color: #94a3b8;
            font-size: 14px;
        }

        .form-check {
            padding: 12px 0;
        }

        .form-check-input {
            width: 18px;
            height: 18px;
            margin-right: 8px;
            border: 2px solid #cbd5e1;
            border-radius: 5px;
            cursor: pointer;
        }

        .form-check-input:checked {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .form-check-input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(25, 167, 123, 0.15);
        }

        .form-check-label {
            font-size: 14px;
            color: #64748b;
        }

        .form-check-label a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .form-check-label a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        .modal-footer {
            border-top: 1px solid #e2e8f0;
            padding: 20px 0 0 0;
        }

        .btn-submit {
            background: var(--gradient-primary);
            border: none;
            padding: 14px 28px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 14px;
            width: 100%;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
        }

        .btn-submit i {
            margin-right: 8px;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #64748b;
        }

        .login-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .login-link a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        /* Modal Animation */
        .modal.fade .modal-dialog {
            transform: scale(0.9);
            transition: transform 0.3s ease-out;
        }

        .modal.show .modal-dialog {
            transform: scale(1);
        }

        /* Responsive */
        @media (max-width: 576px) {
            .modal-content {
                padding: 8px;
            }

            .modal-header h3 {
                font-size: 24px;
            }

            .btn-primary {
                padding: 12px 28px;
                font-size: 16px;
            }
        }
    </style>
</head>
<body>

<!-- Trigger button to open modal -->
<div class="text-center my-5">
    <button type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#signup">
        <i class="fas fa-user-plus"></i> Register as Job Seeker
    </button>
</div>

<!-- Modal -->
<div class="modal fade form-modal" id="signup" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered max-width-px-840 position-relative">
        <button type="button"
            class="btn-close position-absolute top-0 end-0 m-3"
            data-bs-dismiss="modal"
            style="z-index: 10;"></button>
        <div class="modal-content p-4">
            <div class="modal-header border-0 pb-0 text-center w-100 d-block">
                <div class="register-icon">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <h3>Create Your Account</h3>
                <p>Sign up to start your job search, apply for roles, and grow your career.</p>
            </div>
            <div class="modal-body">
                <!-- Display error message if registration fails -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" style="background: #fee2e2; color: #dc2626; border: 1px solid #fecaca; border-radius: 12px; padding: 12px 16px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>

                <c:if test="${not empty message}">
                    <div class="alert alert-success" style="background: #d1fae5; color: #10b981; border: 1px solid #a7f3d0; border-radius: 12px; padding: 12px 16px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                        <i class="fas fa-check-circle"></i> ${message}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/jobSeekers/register1" method="post" id="registrationForm" enctype="multipart/form-data">
                    
                    <!-- Full Name -->
                    <div class="mb-4">
                        <label for="name" class="form-label">
                            <i class="fas fa-user" style="color: var(--primary); margin-right: 6px;"></i>Full Name
                        </label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Enter your full name" required>
                    </div>

                    <!-- Email -->
                    <div class="mb-4">
                        <label for="email" class="form-label">
                            <i class="fas fa-envelope" style="color: var(--primary); margin-right: 6px;"></i>Email Address
                        </label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="your.email@example.com" required>
                    </div>

                    <!-- Password -->
                    <div class="mb-4">
                        <label for="password" class="form-label">
                            <i class="fas fa-lock" style="color: var(--primary); margin-right: 6px;"></i>Password
                        </label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Create a strong password" required>
                    </div>

                    <!-- Confirm Password -->
                    <div class="mb-4">
                        <label for="confirmPassword" class="form-label">
                            <i class="fas fa-lock" style="color: var(--primary); margin-right: 6px;"></i>Confirm Password
                        </label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                        <div id="passwordMatch" style="font-size: 12px; margin-top: 6px; display: none;"></div>
                    </div>

                    <!-- Terms checkbox -->
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="termsCheck" required>
                        <label class="form-check-label" for="termsCheck">
                            I agree to the <a href="${pageContext.request.contextPath}/terms-conditions.html">Terms & Conditions</a>
                        </label>
                    </div>

                    <!-- Submit Button -->
                    <div class="modal-footer">
                        <button type="submit" class="btn-submit" id="submitBtn">
                            <i class="fas fa-user-plus"></i> Sign Up
                        </button>
                    </div>

                    <div class="login-link">
                        Already have an account? <a href="${pageContext.request.contextPath}/jobSeekers/login">Login Here <i class="fas fa-arrow-right"></i></a>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Password match validation
    document.addEventListener('DOMContentLoaded', function() {
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        const passwordMatch = document.getElementById('passwordMatch');
        const form = document.getElementById('registrationForm');

        function checkPasswordMatch() {
            if (confirmPassword.value === '') {
                passwordMatch.style.display = 'none';
                return;
            }
            
            passwordMatch.style.display = 'block';
            if (password.value === confirmPassword.value) {
                passwordMatch.innerHTML = '<i class="fas fa-check-circle" style="color: #10b981;"></i> Passwords match';
                passwordMatch.style.color = '#10b981';
            } else {
                passwordMatch.innerHTML = '<i class="fas fa-times-circle" style="color: #ef4444;"></i> Passwords do not match';
                passwordMatch.style.color = '#ef4444';
            }
        }

        if (password && confirmPassword) {
            password.addEventListener('input', checkPasswordMatch);
            confirmPassword.addEventListener('input', checkPasswordMatch);
        }

        // Form validation before submit
        if (form) {
            form.addEventListener('submit', function(e) {
                if (password.value !== confirmPassword.value) {
                    e.preventDefault();
                    passwordMatch.style.display = 'block';
                    passwordMatch.innerHTML = '<i class="fas fa-times-circle" style="color: #ef4444;"></i> Passwords do not match';
                    passwordMatch.style.color = '#ef4444';
                    confirmPassword.focus();
                    return false;
                }

                // Show loading state
                const submitBtn = document.getElementById('submitBtn');
                submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Creating Account...';
                submitBtn.disabled = true;
            });
        }

        // Auto-open modal if there's an error
        <c:if test="${not empty error}">
            var myModal = new bootstrap.Modal(document.getElementById('signup'));
            myModal.show();
        </c:if>

        // Keyboard shortcut for submit
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey && e.key === 'Enter') {
                const modal = document.getElementById('signup');
                if (modal.classList.contains('show')) {
                    const submitBtn = document.getElementById('submitBtn');
                    if (submitBtn) {
                        form.dispatchEvent(new Event('submit'));
                    }
                }
            }
        });
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
</script>
</body>
</html>