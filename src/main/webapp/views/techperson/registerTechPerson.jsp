<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tech Person Registration | SmartInterview</title>
    
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
            color: var(--text-primary);
            min-height: 100vh;
            padding: 2rem 0;
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

        .container {
            position: relative;
            z-index: 1;
        }

        /* Page Header */
        .page-header {
            background: var(--gradient-primary);
            color: white;
            padding: 2.5rem 0;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none"><path d="M0,0 L1000,0 L1000,100 L0,100 Z" fill="rgba(255,255,255,0.05)"/></svg>');
            opacity: 0.1;
        }

        .page-header .container {
            position: relative;
            z-index: 2;
        }

        .page-header h1 {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .page-header p {
            font-size: 1rem;
            opacity: 0.95;
            text-align: center;
        }

        /* Form Container */
        .form-container {
            background: var(--white);
            border-radius: 24px;
            padding: 2.5rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            border: 1px solid rgba(25, 167, 123, 0.1);
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-section-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid rgba(25, 167, 123, 0.15);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-section-title i {
            color: var(--primary);
            font-size: 1.1rem;
        }

        /* Form Styling */
        .form-label {
            font-weight: 600;
            color: var(--text-primary);
            font-size: 0.95rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-label i {
            color: var(--primary);
            font-size: 0.9rem;
            width: 18px;
        }

        .form-control {
            border: 2px solid var(--border-color);
            border-radius: 14px;
            padding: 0.85rem 1rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            color: var(--text-primary);
            background: #fafdfc;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
            outline: none;
            background: var(--white);
        }

        .form-control::placeholder {
            color: var(--text-secondary);
            opacity: 0.7;
        }

        /* Icon Wrapper for Inputs */
        .input-icon-wrapper {
            position: relative;
        }

        .input-icon-wrapper > i:first-child {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary);
            font-size: 1rem;
            pointer-events: none;
            transition: color 0.3s ease;
        }

        .input-icon-wrapper .form-control {
            padding-left: 2.75rem;
        }

        .input-icon-wrapper:focus-within > i:first-child {
            color: var(--primary-dark);
        }

        /* Password Toggle */
        .password-toggle {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            cursor: pointer;
            font-size: 1rem;
            transition: color 0.3s ease;
            z-index: 10;
            background: none;
            border: none;
        }

        .password-toggle:hover {
            color: var(--primary);
        }

        /* Buttons */
        .btn-submit {
            background: var(--gradient-primary);
            color: white;
            border: none;
            border-radius: 14px;
            padding: 0.95rem 2rem;
            font-weight: 600;
            font-size: 1rem;
            width: 100%;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 1.5rem;
            box-shadow: 0 4px 16px rgba(25, 167, 123, 0.3);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
            color: white;
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
        }

        .btn-submit:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        /* Form Row Styling */
        .form-row-custom {
            margin-bottom: 1.5rem;
        }

        /* Company Info Card */
        .company-info-card {
            background: linear-gradient(135deg, rgba(25, 167, 123, 0.05), rgba(59, 196, 154, 0.05));
            border: 1px solid rgba(25, 167, 123, 0.15);
            border-radius: 18px;
            padding: 1.75rem;
            margin-bottom: 2rem;
            text-align: center;
            box-shadow: var(--shadow-sm);
        }

        .company-info-card i {
            font-size: 2.8rem;
            color: var(--primary);
            margin-bottom: 0.75rem;
        }

        .company-info-card h4 {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .company-info-card p {
            font-size: 0.9rem;
            color: var(--text-secondary);
            margin: 0;
        }

        /* Input Validation States */
        .form-control.is-invalid {
            border-color: var(--danger) !important;
            box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
        }

        .form-control.is-valid {
            border-color: var(--success) !important;
            box-shadow: 0 0 0 3px rgba(25, 167, 123, 0.1);
        }

        /* Success/Error Messages */
        .alert-custom {
            border-radius: 16px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-success-custom {
            background: rgba(25, 167, 123, 0.1);
            color: var(--success);
            border: 1px solid rgba(25, 167, 123, 0.3);
        }

        .alert-danger-custom {
            background: rgba(239, 68, 68, 0.08);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .text-muted {
            color: var(--text-secondary) !important;
        }

        .text-muted i {
            color: var(--primary);
            margin-right: 4px;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            color: var(--primary-dark);
            transform: translateX(-4px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 1rem 0;
            }

            .page-header {
                padding: 2rem 0;
            }

            .page-header h1 {
                font-size: 1.6rem;
            }

            .form-container {
                padding: 1.75rem;
                border-radius: 18px;
            }

            .form-section-title {
                font-size: 1.1rem;
            }
        }

        @media (max-width: 576px) {
            .page-header {
                padding: 1.5rem 0;
            }

            .page-header h1 {
                font-size: 1.4rem;
            }

            .form-container {
                padding: 1.5rem;
            }

            .form-label {
                font-size: 0.9rem;
            }

            .form-control {
                font-size: 0.9rem;
                padding: 0.75rem 0.9rem;
            }

            .company-info-card {
                padding: 1.25rem;
            }

            .company-info-card i {
                font-size: 2.2rem;
            }
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
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1>
                <i class="fas fa-user-tie"></i>
                Tech Person Registration
            </h1>
            <p>Register a new techperson for your company</p>
        </div>
    </div>

    <div class="container">
        <!-- Back Link -->
        <a href="javascript:history.back()" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back
        </a>

        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success-custom alert-custom">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger-custom alert-custom">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <!-- Company Info Card -->
        <c:if test="${not empty company}">
            <div class="company-info-card">
                <i class="fas fa-building"></i>
                <h4>${company.name}</h4>
                <p>Registering techperson for this company</p>
            </div>
        </c:if>

        <!-- Form Container -->
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/techperson/register1/${company.id}" method="POST" id="techpersonForm">
                <!-- Hidden input for companyId -->
                <input type="hidden" name="companyId" value="${company.id}" />

                <!-- Registration Form Section -->
                <h3 class="form-section-title">
                    <i class="fas fa-user-plus"></i>
                    Tech Person Details
                </h3>

                <div class="form-row-custom">
                    <label for="name" class="form-label">
                        <i class="fas fa-user"></i>
                        Tech Person Name
                    </label>
                    <div class="input-icon-wrapper">
                        <i class="fas fa-user"></i>
                        <input type="text" id="name" name="name" class="form-control" placeholder="Enter techperson full name" required />
                    </div>
                </div>

                <div class="form-row-custom">
                    <label for="email" class="form-label">
                        <i class="fas fa-envelope"></i>
                        Tech Person Email
                    </label>
                    <div class="input-icon-wrapper">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" class="form-control" placeholder="Enter techperson email address" required />
                    </div>
                </div>

                <div class="form-row-custom">
                    <label for="password" class="form-label">
                        <i class="fas fa-lock"></i>
                        Password
                    </label>
                    <div class="input-icon-wrapper">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="techPassword" name="password" class="form-control" placeholder="Enter secure password" required style="padding-right: 48px;" />
                        <button type="button" class="password-toggle" id="toggleTechPwdBtn" onclick="toggleTechPwd()" aria-label="Toggle password visibility">
                            <i class="fas fa-eye" id="techEyeIcon"></i>
                        </button>
                    </div>
                    <!-- Live Strength Indicator -->
                    <div id="techPwdStrengthBar" style="display:none;margin-top:8px;padding:0 4px;">
                        <div style="height:5px;border-radius:10px;background:#e2e8f0;overflow:hidden;">
                            <div id="techPwdStrengthFill" style="height:100%;width:0;border-radius:10px;transition:width 0.4s,background 0.4s;"></div>
                        </div>
                        <small id="techPwdStrengthText" style="font-size:0.75rem;margin-top:4px;display:block;"></small>
                    </div>
                    <!-- Requirements Checklist -->
                    <ul id="techPwdChecklist" style="display:none;list-style:none;padding:0 4px;margin:8px 0 0;font-size:0.78rem;text-align:left;">
                        <li id="tech-chk-len" style="color:#94a3b8;margin-bottom:3px;"><i class="fas fa-circle" style="font-size:0.5rem;margin-right:6px;"></i>Minimum 6 characters</li>
                        <li id="tech-chk-upper" style="color:#94a3b8;margin-bottom:3px;"><i class="fas fa-circle" style="font-size:0.5rem;margin-right:6px;"></i>At least 1 uppercase letter (A-Z)</li>
                        <li id="tech-chk-lower" style="color:#94a3b8;margin-bottom:3px;"><i class="fas fa-circle" style="font-size:0.5rem;margin-right:6px;"></i>At least 1 lowercase letter (a-z)</li>
                        <li id="tech-chk-special" style="color:#94a3b8;"><i class="fas fa-circle" style="font-size:0.5rem;margin-right:6px;"></i>At least 1 special character (!@#$...)</li>
                    </ul>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-submit" id="submitBtn">
                    <i class="fas fa-user-plus"></i>
                    Register Tech Person
                </button>
            </form>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Password Toggle Functionality
        function toggleTechPwd() {
            const passwordInput = document.getElementById('techPassword');
            const toggleIcon = document.getElementById('techEyeIcon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }

        const techPwdInput = document.getElementById('techPassword');
        if (techPwdInput) {
            techPwdInput.addEventListener('focus', () => {
                document.getElementById('techPwdChecklist').style.display = 'block';
                document.getElementById('techPwdStrengthBar').style.display = 'block';
            });
            techPwdInput.addEventListener('input', function () {
                const val = this.value;
                const checks = {
                    len: val.length >= 6,
                    upper: /[A-Z]/.test(val),
                    lower: /[a-z]/.test(val),
                    special: /[!@#$%^&*()_+\-=\[\]{}|;:',.<>?/]/.test(val)
                };
                techUpdateCheck('tech-chk-len', checks.len);
                techUpdateCheck('tech-chk-upper', checks.upper);
                techUpdateCheck('tech-chk-lower', checks.lower);
                techUpdateCheck('tech-chk-special', checks.special);
                const score = Object.values(checks).filter(Boolean).length;
                const fill = document.getElementById('techPwdStrengthFill');
                const text = document.getElementById('techPwdStrengthText');
                const levels = [
                    { w: '25%', color: '#ef4444', label: 'Weak' },
                    { w: '50%', color: '#f59e0b', label: 'Fair' },
                    { w: '75%', color: '#3b82f6', label: 'Good' },
                    { w: '100%', color: '#19A77B', label: 'Strong' }
                ];
                const lvl = levels[score - 1] || { w: '0', color: '#e2e8f0', label: '' };
                fill.style.width = lvl.w;
                fill.style.background = lvl.color;
                text.textContent = lvl.label ? 'Strength: ' + lvl.label : '';
                text.style.color = lvl.color;
            });
        }
        function techUpdateCheck(id, passed) {
            const el = document.getElementById(id);
            if (!el) return;
            el.style.color = passed ? '#19A77B' : '#94a3b8';
            el.querySelector('i').className = passed ? 'fas fa-check-circle' : 'fas fa-circle';
            el.querySelector('i').style.fontSize = passed ? '0.75rem' : '0.5rem';
        }

        // Form validation enhancement
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('techpersonForm');
            const submitBtn = document.getElementById('submitBtn');
            const inputs = form.querySelectorAll('input[required]');
            
            // Real-time validation
            inputs.forEach(input => {
                input.addEventListener('blur', function() {
                    validateField(this);
                });

                input.addEventListener('input', function() {
                    if (this.classList.contains('is-invalid')) {
                        validateField(this);
                    }
                });
            });

            function validateField(field) {
                const value = field.value.trim();
                
                if (field.type === 'email') {
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (value && emailRegex.test(value)) {
                        field.classList.remove('is-invalid');
                        field.classList.add('is-valid');
                    } else if (value) {
                        field.classList.remove('is-valid');
                        field.classList.add('is-invalid');
                    } else {
                        field.classList.remove('is-valid', 'is-invalid');
                    }
                } else if (field.id === 'techPassword') {
                    if (value.length >= 6 && /[A-Z]/.test(value) && /[a-z]/.test(value) && /[!@#$%^&*()_+\-=\[\]{}|;:',.<>?/]/.test(value)) {
                        field.classList.remove('is-invalid');
                        field.classList.add('is-valid');
                    } else if (value) {
                        field.classList.remove('is-valid');
                        field.classList.add('is-invalid');
                    } else {
                        field.classList.remove('is-valid', 'is-invalid');
                    }
                } else {
                    if (value) {
                        field.classList.remove('is-invalid');
                        field.classList.add('is-valid');
                    } else {
                        field.classList.remove('is-valid', 'is-invalid');
                    }
                }
            }

            // Form submission validation with loading state
            form.addEventListener('submit', function(e) {
                let isValid = true;
                
                inputs.forEach(input => {
                    if (!input.value.trim()) {
                        isValid = false;
                        input.classList.add('is-invalid');
                    } else {
                        validateField(input);
                        if (input.classList.contains('is-invalid')) {
                            isValid = false;
                        }
                    }
                });

                // Check password format
                const password = document.getElementById('techPassword');
                const pwdVal = password.value;
                const pwdErrors = [];
                if (pwdVal.length < 6) pwdErrors.push('at least 6 characters');
                if (!/[A-Z]/.test(pwdVal)) pwdErrors.push('1 uppercase letter');
                if (!/[a-z]/.test(pwdVal)) pwdErrors.push('1 lowercase letter');
                if (!/[!@#$%^&*()_+\-=\[\]{}|;:',.<>?/]/.test(pwdVal)) pwdErrors.push('1 special character');
                
                if (pwdErrors.length > 0) {
                    isValid = false;
                    password.classList.add('is-invalid');
                    if (pwdErrors.length > 0) {
                        alert('Password must contain: ' + pwdErrors.join(', ') + '.');
                    }
                }

                // Check email format
                const email = document.getElementById('email');
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (email.value.trim() && !emailRegex.test(email.value.trim())) {
                    isValid = false;
                    email.classList.add('is-invalid');
                }
                
                if (isValid) {
                    // Show loading state
                    submitBtn.innerHTML = '<span class="loading-spinner"></span> Registering...';
                    submitBtn.disabled = true;
                } else {
                    e.preventDefault();
                    // Scroll to first error
                    const firstError = form.querySelector('.is-invalid');
                    if (firstError) {
                        firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                        firstError.focus();
                    }
                }
            });

            // Keyboard shortcut for submit
            document.addEventListener('keydown', function(e) {
                if (e.ctrlKey && e.key === 'Enter') {
                    form.dispatchEvent(new Event('submit'));
                }
            });
        });
    </script>

</body>
</html>




