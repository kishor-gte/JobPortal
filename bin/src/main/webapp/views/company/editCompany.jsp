<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Edit Company Profile | JobU - Manage Your Business</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
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
            --success: #10b981;
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
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
            color: var(--text-dark);
            min-height: 100vh;
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
        .page-header h1 {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 12px;
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

        /* Back Button */
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--white);
            color: var(--primary);
            border: 1px solid rgba(25,167,123,0.2);
            border-radius: 50px;
            padding: 10px 24px;
            font-weight: 600;
            font-size: 0.85rem;
            text-decoration: none;
            transition: var(--transition);
            margin-bottom: 24px;
        }
        .back-btn:hover {
            background: var(--primary);
            color: white;
            transform: translateX(-4px);
            border-color: transparent;
        }

        /* ========== FORM CONTAINER ========== */
        .form-container {
            background: var(--white);
            border-radius: var(--radius);
            padding: 40px;
            box-shadow: var(--shadow-sm);
            margin-bottom: 40px;
            border: 1px solid rgba(25,167,123,0.1);
            transition: var(--transition);
        }
        .form-container:hover {
            box-shadow: var(--shadow-md);
        }

        /* Form Section Title */
        .form-section-title {
            font-size: 1.3rem;
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 24px;
            padding-bottom: 12px;
            border-bottom: 2px solid var(--border);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .form-section-title i {
            color: var(--primary);
            font-size: 1.2rem;
        }

        /* Form Labels */
        .form-label {
            font-weight: 600;
            color: var(--text-dark);
            font-size: 0.85rem;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .form-label i {
            color: var(--primary);
            width: 18px;
        }

        /* Form Controls */
        .form-control, .form-select {
            border: 2px solid var(--border);
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 0.9rem;
            transition: var(--transition);
            color: var(--text-dark);
            background: var(--bg-light);
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.1);
            outline: none;
            background: var(--white);
        }
        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        /* Input Icon Wrapper */
        .input-icon-wrapper {
            position: relative;
        }
        .input-icon-wrapper i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 1rem;
            pointer-events: none;
        }
        .input-icon-wrapper .form-control {
            padding-left: 45px;
        }

        /* File Input */
        .form-control[type="file"] {
            padding: 10px;
            cursor: pointer;
        }
        .form-control[type="file"]::-webkit-file-upload-button {
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
        .form-control[type="file"]::-webkit-file-upload-button:hover {
            transform: translateY(-1px);
        }

        /* Current Logo Display */
        .current-logo-container {
            background: var(--bg-light);
            border: 2px dashed rgba(25,167,123,0.2);
            border-radius: var(--radius-sm);
            padding: 20px;
            text-align: center;
            margin-top: 15px;
        }
        .current-logo-label {
            font-weight: 600;
            color: var(--text-muted);
            font-size: 0.85rem;
            margin-bottom: 12px;
            display: block;
        }
        .current-logo {
            max-width: 120px;
            max-height: 120px;
            border-radius: 16px;
            box-shadow: var(--shadow-sm);
            object-fit: contain;
            transition: var(--transition);
        }
        .current-logo:hover {
            transform: scale(1.02);
        }

        /* Submit Button */
        .btn-submit {
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 60px;
            padding: 14px 32px;
            font-weight: 700;
            font-size: 1rem;
            width: 100%;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 30px;
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
        }

        /* Alert Messages */
        .alert-custom {
            border-radius: 16px;
            padding: 16px 20px;
            margin-bottom: 24px;
            border: none;
            font-weight: 500;
        }
        .alert-success-custom {
            background: linear-gradient(135deg, rgba(25,167,123,0.1), rgba(59,196,154,0.05));
            color: var(--primary-dark);
            border-left: 4px solid var(--primary);
        }
        .alert-danger-custom {
            background: linear-gradient(135deg, rgba(239,68,68,0.1), rgba(239,68,68,0.05));
            color: var(--danger);
            border-left: 4px solid var(--danger);
        }

        /* Form Row Spacing */
        .form-row-custom {
            margin-bottom: 20px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 40px 0 30px; }
            .page-header h1 { font-size: 1.6rem; }
            .form-container { padding: 24px; }
            .form-section-title { font-size: 1.1rem; }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header" data-aos="fade-down">
        <div class="container">
            <h1><i class="fas fa-building me-2"></i>Edit Company Profile</h1>
            <p>Update your company information and details</p>
        </div>
    </div>

    <div class="container">
        <!-- Back Button -->
        <a href="#" onclick="history.back(); return false;" class="back-btn" data-aos="fade-right">
            <i class="fas fa-arrow-left"></i> Back
        </a>
        
        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success-custom alert-custom" data-aos="fade-up">
                <i class="fas fa-check-circle me-2"></i>${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger-custom alert-custom" data-aos="fade-up">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
            </div>
        </c:if>

        <!-- Form Container -->
        <div class="form-container" data-aos="fade-up" data-aos-delay="100">
            <form action="${pageContext.request.contextPath}/company/update" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${company.id}" />

                <!-- Basic Information Section -->
                <h3 class="form-section-title">
                    <i class="fas fa-info-circle"></i> Basic Information
                </h3>

                <div class="row">
                    <div class="col-md-6 form-row-custom">
                        <label for="name" class="form-label"><i class="fas fa-building"></i> Company Name</label>
                        <div class="input-icon-wrapper">
                            <i class="fas fa-building"></i>
                            <input type="text" id="name" name="name" class="form-control" value="${company.name}" required />
                        </div>
                    </div>
                    <div class="col-md-6 form-row-custom">
                        <label for="email" class="form-label"><i class="fas fa-envelope"></i> Official Email</label>
                        <div class="input-icon-wrapper">
                            <i class="fas fa-envelope"></i>
                            <input type="email" id="email" name="email" class="form-control" value="${company.email}" required />
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 form-row-custom">
                        <label for="phone" class="form-label"><i class="fas fa-phone"></i> Phone Number</label>
                        <div class="input-icon-wrapper">
                            <i class="fas fa-phone"></i>
                            <input type="text" id="phone" name="phone" class="form-control" value="${company.phone}" />
                        </div>
                    </div>
                    <div class="col-md-6 form-row-custom">
                        <label for="password" class="form-label"><i class="fas fa-lock"></i> Account Password</label>
                        <div class="input-icon-wrapper">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="password" name="password" class="form-control" value="${company.password}" required />
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 form-row-custom">
                        <label for="industry" class="form-label"><i class="fas fa-industry"></i> Industry Type</label>
                        <div class="input-icon-wrapper">
                            <i class="fas fa-industry"></i>
                            <input type="text" id="industry" name="industry" class="form-control" value="${company.industry}" required />
                        </div>
                    </div>
                    <div class="col-md-6 form-row-custom">
                        <label for="companySize" class="form-label"><i class="fas fa-users"></i> Company Size</label>
                        <div class="input-icon-wrapper">
                            <i class="fas fa-users"></i>
                            <input type="text" id="companySize" name="companySize" class="form-control" value="${company.companySize}" />
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6 form-row-custom">
                        <label for="foundedYear" class="form-label"><i class="fas fa-calendar-alt"></i> Founded Year</label>
                        <div class="input-icon-wrapper">
                            <i class="fas fa-calendar-alt"></i>
                            <input type="text" id="foundedYear" name="foundedYear" class="form-control" value="${company.foundedYear}" />
                        </div>
                    </div>
                    <div class="col-md-6 form-row-custom">
                        <label for="location" class="form-label"><i class="fas fa-map-marker-alt"></i> Headquarters</label>
                        <div class="input-icon-wrapper">
                            <i class="fas fa-map-marker-alt"></i>
                            <input type="text" id="location" name="location" class="form-control" value="${company.location}" required />
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 form-row-custom">
                        <label for="website" class="form-label"><i class="fas fa-globe"></i> Company Website</label>
                        <div class="input-icon-wrapper">
                            <i class="fas fa-globe"></i>
                            <input type="url" id="website" name="website" class="form-control" value="${company.website}" placeholder="https://example.com" required />
                        </div>
                    </div>
                    <div class="col-md-6 form-row-custom">
                        <label for="linkedInUrl" class="form-label"><i class="fab fa-linkedin"></i> LinkedIn Profile</label>
                        <div class="input-icon-wrapper">
                            <i class="fab fa-linkedin"></i>
                            <input type="url" id="linkedInUrl" name="linkedInUrl" class="form-control" value="${company.linkedInUrl}" />
                        </div>
                    </div>
                </div>

                <!-- About Section -->
                <h3 class="form-section-title" style="margin-top: 32px;">
                    <i class="fas fa-file-alt"></i> Company Description
                </h3>
                <div class="form-row-custom">
                    <label for="about" class="form-label"><i class="fas fa-align-left"></i> About Company</label>
                    <textarea id="about" name="about" class="form-control" required>${company.about}</textarea>
                </div>

                <!-- Logo Section -->
                <h3 class="form-section-title" style="margin-top: 32px;">
                    <i class="fas fa-image"></i> Company Logo
                </h3>
                <div class="form-row-custom">
                    <label for="logofile" class="form-label"><i class="fas fa-upload"></i> Change Logo</label>
                    <input type="file" id="logofile" name="logofile" class="form-control" accept="image/*" />
                    <small class="text-muted d-block mt-2">
                        <i class="fas fa-info-circle"></i> Recommended: Square image, max 2MB (PNG, JPG, JPEG)
                    </small>
                </div>

                <c:if test="${not empty company.logo}">
                    <div class="current-logo-container">
                        <span class="current-logo-label">Current Logo:</span>
                        <img src="${pageContext.request.contextPath}${company.logo}" alt="Current Logo" class="current-logo" 
                             onerror="this.style.display='none'; this.nextElementSibling.style.display='block';" />
                        <p class="text-muted no-logo-msg" style="display:none;"><i class="fas fa-image"></i> No logo uploaded</p>
                    </div>
                </c:if>

                <!-- Submit Button -->
                <button type="submit" class="btn-submit">
                    <i class="fas fa-save"></i> Save Changes
                </button>
            </form>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true, offset: 50 });

        // Form validation enhancement
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            const inputs = form.querySelectorAll('input[required], textarea[required]');
            
            form.addEventListener('submit', function(e) {
                let isValid = true;
                inputs.forEach(input => {
                    if (!input.value.trim()) {
                        isValid = false;
                        input.classList.add('is-invalid');
                    } else {
                        input.classList.remove('is-invalid');
                    }
                });
                if (!isValid) {
                    e.preventDefault();
                    alert('Please fill in all required fields.');
                }
            });

            inputs.forEach(input => {
                input.addEventListener('input', function() {
                    this.classList.remove('is-invalid');
                });
            });

            // File input preview
            const fileInput = document.getElementById('logofile');
            if (fileInput) {
                fileInput.addEventListener('change', function(e) {
                    const file = e.target.files[0];
                    if (file) {
                        if (file.size > 2 * 1024 * 1024) {
                            alert('File size must be less than 2MB');
                            e.target.value = '';
                            return;
                        }
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            const currentLogoContainer = document.querySelector('.current-logo-container');
                            if (currentLogoContainer) {
                                const img = currentLogoContainer.querySelector('img');
                                if (img) {
                                    img.src = e.target.result;
                                } else {
                                    currentLogoContainer.innerHTML = `
                                        <span class="current-logo-label">Preview:</span>
                                        <img src="${e.target.result}" alt="Logo Preview" class="current-logo" />
                                    `;
                                }
                            }
                        };
                        reader.readAsDataURL(file);
                    }
                });
            }
        });
    </script>
</body>
</html>