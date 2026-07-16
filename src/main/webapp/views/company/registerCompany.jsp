<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Register Company | JobU - Join Our Network of Employers</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --primary-light: #3BC49A;
            --primary-glow: rgba(25,167,123,0.15);
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-light: #f4fbf9;
            --text-dark: #1a2c2f;
            --text-muted: #5a6e66;
            --white: #ffffff;
            --border: #e2e8f0;
            --danger: #ef4444;
            --gradient: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
            --gradient-dark: linear-gradient(135deg, #1e2f32 0%, #2E3E41 100%);
            --shadow-sm: 0 10px 25px -5px rgba(0,0,0,0.05);
            --shadow-md: 0 20px 35px -12px rgba(25,167,123,0.15);
            --shadow-lg: 0 30px 50px -15px rgba(0,0,0,0.12);
            --radius: 24px;
            --radius-sm: 16px;
            --transition: all 0.4s cubic-bezier(0.2, 0.95, 0.4, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #e6f4ef; border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: var(--primary-dark); }

        /* ========== PAGE HEADER ========== */
        .page-header {
            background: var(--gradient-dark);
            color: white;
            padding: 60px 0 50px;
            position: relative;
            overflow: hidden;
            margin-bottom: 40px;
        }
        .page-header::before {
            content: '';
            position: absolute;
            top: -30%;
            right: -10%;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(59,196,154,0.15) 0%, transparent 70%);
            border-radius: 50%;
            animation: floatGlow 20s infinite alternate;
        }
        .page-header::after {
            content: '';
            position: absolute;
            bottom: -20%;
            left: -5%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(25,167,123,0.1) 0%, transparent 70%);
            border-radius: 50%;
            animation: floatGlow2 18s infinite alternate;
        }
        @keyframes floatGlow {
            0% { transform: translate(0,0) scale(1); opacity: 0.3; }
            100% { transform: translate(-60px, 50px) scale(1.3); opacity: 0.6; }
        }
        @keyframes floatGlow2 {
            0% { transform: translate(0,0) scale(1); opacity: 0.2; }
            100% { transform: translate(60px, -40px) scale(1.2); opacity: 0.5; }
        }
        .page-header h2 {
            font-size: 2rem;
            font-weight: 800;
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
        .page-header p {
            font-size: 1rem;
            opacity: 0.9;
        }

        /* ========== FORM CONTAINER ========== */
        .form-container {
            max-width: 850px;
            margin: 0 auto 60px;
            padding: 0 20px;
        }
        .register-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 45px;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(25,167,123,0.1);
            transition: var(--transition);
        }
        .register-card:hover {
            box-shadow: var(--shadow-md);
        }

        /* Reminder Box */
        .reminder {
            background: linear-gradient(135deg, rgba(25,167,123,0.08), rgba(59,196,154,0.05));
            border-left: 4px solid var(--primary);
            padding: 16px 20px;
            margin-bottom: 28px;
            border-radius: 12px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }
        .reminder i {
            color: var(--primary);
            font-size: 1.2rem;
            margin-top: 2px;
        }
        .reminder strong {
            color: var(--primary-dark);
        }
        .reminder p {
            margin: 0;
            font-size: 0.85rem;
            color: var(--text-muted);
            line-height: 1.5;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 22px;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 22px;
        }
        label {
            font-weight: 600;
            font-size: 0.85rem;
            color: var(--text-dark);
            display: block;
            margin-bottom: 8px;
        }
        label i {
            color: var(--primary);
            margin-right: 8px;
            width: 18px;
        }
        .required-star {
            color: var(--danger);
            margin-left: 3px;
        }
        input, textarea, select {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--border);
            border-radius: 12px;
            font-size: 0.9rem;
            transition: var(--transition);
            background: var(--bg-light);
            color: var(--text-dark);
            font-family: inherit;
        }
        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.1);
            background: var(--white);
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        input[type="file"] {
            padding: 10px;
            background: var(--bg-light);
        }
        input[type="file"]::-webkit-file-upload-button {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 50px;
            margin-right: 15px;
            cursor: pointer;
            font-weight: 600;
            transition: var(--transition);
        }
        input[type="file"]::-webkit-file-upload-button:hover {
            transform: translateY(-1px);
        }

        /* Alert Message */
        .alert-danger {
            background: linear-gradient(135deg, rgba(239,68,68,0.1), rgba(239,68,68,0.05));
            color: #ef4444;
            border-left: 4px solid #ef4444;
            padding: 14px 18px;
            border-radius: 12px;
            margin-bottom: 24px;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Submit Button */
        .btn-submit {
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 60px;
            padding: 14px 28px;
            font-size: 1rem;
            font-weight: 700;
            width: 100%;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
            margin-top: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 40px 0 30px; }
            .page-header h2 { font-size: 1.5rem; }
            .register-card { padding: 28px; }
            .form-row { grid-template-columns: 1fr; gap: 0; }
            .form-group { margin-bottom: 18px; }
        }
    </style>
</head>
<body>


    <div class="form-container">
        <div class="register-card" data-aos="fade-up" data-aos-delay="100">
            <!-- Reminder Box -->
            <div class="reminder">
                <i class="fas fa-lightbulb"></i>
                <p><strong>Note:</strong> Please make sure to remember the email and password you enter here. You will need them to log in and manage your company profile.</p>
            </div>

            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="alert-danger">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <!-- Registration Form -->
            <form action="${pageContext.request.contextPath}/company/register1" method="post" enctype="multipart/form-data">
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-building"></i> Company Name<span class="required-star">*</span></label>
                        <input type="text" id="name" name="name" required placeholder="e.g., Tech Solutions Inc.">
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-industry"></i> Industry<span class="required-star">*</span></label>
                        <input type="text" id="industry" name="industry" required placeholder="e.g., Information Technology">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-map-marker-alt"></i> Location<span class="required-star">*</span></label>
                        <input type="text" id="location" name="location" required placeholder="e.g., New York, NY">
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-envelope"></i> Company Email<span class="required-star">*</span></label>
                        <input type="email" id="email" name="email" required placeholder="contact@company.com">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-phone"></i> Phone Number<span class="required-star">*</span></label>
                        <input type="text" id="phone" name="phone" required placeholder="+1 234 567 8900" pattern="^\+?[0-9\s\-\(\)]+$" title="Please enter a valid phone number">
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-calendar-alt"></i> Founded Year<span class="required-star">*</span></label>
                        <input type="number" id="foundedYear" name="foundedYear" required placeholder="e.g., 2010" min="1800" max="2099">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-users"></i> Company Size<span class="required-star">*</span></label>
                        <select id="companySize" name="companySize" required>
                            <option value="" disabled selected>Select company size</option>
                            <option value="1-10 employees">1-10 employees</option>
                            <option value="11-50 employees">11-50 employees</option>
                            <option value="51-200 employees">51-200 employees</option>
                            <option value="201-500 employees">201-500 employees</option>
                            <option value="501-1000 employees">501-1000 employees</option>
                            <option value="1000+ employees">1000+ employees</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-lock"></i> Password<span class="required-star">*</span></label>
                        <div style="position: relative;">
                            <input type="password" id="password" name="password" required placeholder="Create a strong password" minlength="6" style="padding-right: 48px;">
                            <span onclick="togglePwd('password', this)" style="position:absolute;right:14px;top:50%;transform:translateY(-50%);cursor:pointer;color:#19A77B;font-size:1.1rem;z-index:3;"><i class="fas fa-eye"></i></span>
                        </div>
                        <!-- Live Strength Indicator -->
                        <div id="pwdStrengthBar" style="display:none;margin-top:8px;">
                            <div style="height:5px;border-radius:10px;background:#e2e8f0;overflow:hidden;">
                                <div id="pwdStrengthFill" style="height:100%;width:0;border-radius:10px;transition:width 0.4s,background 0.4s;"></div>
                            </div>
                            <small id="pwdStrengthText" style="font-size:0.75rem;margin-top:4px;display:block;"></small>
                        </div>
                        <!-- Requirements Checklist -->
                        <ul id="pwdChecklist" style="display:none;list-style:none;padding:0;margin:8px 0 0;font-size:0.78rem;">
                            <li id="chk-len" style="color:#94a3b8;"><i class="fas fa-circle" style="font-size:0.5rem;margin-right:6px;"></i>Minimum 6 characters</li>
                            <li id="chk-upper" style="color:#94a3b8;"><i class="fas fa-circle" style="font-size:0.5rem;margin-right:6px;"></i>At least 1 uppercase letter (A-Z)</li>
                            <li id="chk-lower" style="color:#94a3b8;"><i class="fas fa-circle" style="font-size:0.5rem;margin-right:6px;"></i>At least 1 lowercase letter (a-z)</li>
                            <li id="chk-special" style="color:#94a3b8;"><i class="fas fa-circle" style="font-size:0.5rem;margin-right:6px;"></i>At least 1 special character (!@#$...)</li>
                        </ul>
                    </div>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-align-left"></i> About Company<span class="required-star">*</span></label>
                    <textarea id="about" name="about" rows="4" required minlength="20" placeholder="Tell us about your company, mission, values, and culture..."></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-globe"></i> Website</label>
                        <input type="url" id="website" name="website" placeholder="https://www.yourcompany.com">
                    </div>
                    <div class="form-group">
                        <label><i class="fab fa-linkedin"></i> LinkedIn Profile</label>
                        <input type="url" id="linkedInUrl" name="linkedInUrl" placeholder="https://linkedin.com/company/...">
                    </div>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-image"></i> Company Logo<span class="required-star">*</span></label>
                    <input type="file" id="logofile" name="logofile" accept="image/*" required>
                    <small class="text-muted" style="display: block; margin-top: 8px; font-size: 0.7rem;">Recommended: Square image, PNG or JPG, max 2MB</small>
                </div>

                <button type="submit" class="btn-submit">
                    <i class="fas fa-check-circle"></i> Register Company
                </button>
            </form>
        </div>
    </div>

    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true, offset: 50 });

        function togglePwd(id, icon) {
            const input = document.getElementById(id);
            const isText = input.type === 'text';
            input.type = isText ? 'password' : 'text';
            icon.innerHTML = isText ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
        }

        const pwdInput = document.getElementById('password');
        pwdInput.addEventListener('focus', () => {
            document.getElementById('pwdChecklist').style.display = 'block';
            document.getElementById('pwdStrengthBar').style.display = 'block';
        });
        pwdInput.addEventListener('input', function () {
            const val = this.value;
            const checks = {
                len: val.length >= 6,
                upper: /[A-Z]/.test(val),
                lower: /[a-z]/.test(val),
                special: /[!@#$%^&*()_+\-=\[\]{}|;:',.<>?/]/.test(val)
            };
            updateCheck('chk-len', checks.len);
            updateCheck('chk-upper', checks.upper);
            updateCheck('chk-lower', checks.lower);
            updateCheck('chk-special', checks.special);
            const score = Object.values(checks).filter(Boolean).length;
            const fill = document.getElementById('pwdStrengthFill');
            const text = document.getElementById('pwdStrengthText');
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
        function updateCheck(id, passed) {
            const el = document.getElementById(id);
            el.style.color = passed ? '#19A77B' : '#94a3b8';
            el.querySelector('i').className = passed ? 'fas fa-check-circle' : 'fas fa-circle';
            el.querySelector('i').style.fontSize = passed ? '0.75rem' : '0.5rem';
        }

        // Validate on form submit
        document.querySelector('form').addEventListener('submit', function(e) {
            const pwd = document.getElementById('password').value;
            const errors = [];
            if (pwd.length < 6) errors.push('at least 6 characters');
            if (!/[A-Z]/.test(pwd)) errors.push('1 uppercase letter');
            if (!/[a-z]/.test(pwd)) errors.push('1 lowercase letter');
            if (!/[!@#$%^&*()_+\-=\[\]{}|;:',.<>?/]/.test(pwd)) errors.push('1 special character');
            if (errors.length > 0) {
                e.preventDefault();
                alert('Password must contain: ' + errors.join(', ') + '.');
            }
        });
    </script>
</body>
</html>