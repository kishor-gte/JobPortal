<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Update Job Seeker Profile | SmartInterview</title>
                <!-- Bootstrap & Select2 -->
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
                <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
                    rel="stylesheet" />
                <!-- Font Awesome for icons -->
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
                <!-- Google Fonts -->
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
                <!-- Custom CSS -->
                <style>
                    /* CSS Variables */
                    :root {
                        /* Brand Colors - Updated */
                        --primary: #19A77B;
                        --primary-dark: #148F69;
                        --accent: #3BC49A;
                        --bg-dark: #2E3E41;
                        --bg-darker: #1a2a2c;
                        --bg-lighter: #3a4e51;

                        /* Backgrounds */
                        --bg-light: #f6f9fc;
                        --bg-white: #ffffff;

                        /* Text Colors */
                        --heading-text: #000000;
                        --body-text: #000000;

                        /* Shadows & Borders */
                        --box-shadow-color: rgba(25, 167, 123, 0.15);
                        --border-dashed: #cbd5e1;
                        --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
                        --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);

                        /* Buttons */
                        --btn-primary-bg: var(--primary);
                        --btn-primary-text: #ffffff;
                        --btn-primary-hover-bg: var(--primary-dark);
                        --btn-primary-hover-text: #ffffff;

                        /* Icons */
                        --icon-color: var(--primary);
                        --icon-bg-light: rgba(25, 167, 123, 0.1);

                        /* Typography */
                        --font-family-base: 'Inter', sans-serif;
                        --font-heading-weight: 600;
                        --font-body-size: 14px;

                        /* Gradients */
                        --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
                        --gradient-dark: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-darker) 100%);
                    }

                    /* Reset and Base Styles */
                    * {
                        box-sizing: border-box;
                    }

                    body {
                        background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
                        font-family: var(--font-family-base);
                        padding: 20px;
                        color: var(--body-text);
                        font-size: var(--font-body-size);
                        margin: 0;
                        min-height: 100vh;
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

                        0%,
                        100% {
                            opacity: 0.5;
                        }

                        50% {
                            opacity: 1;
                        }
                    }

                    .profile-container {
                        background-color: var(--bg-white);
                        border-radius: 20px;
                        max-width: 1200px;
                        margin: 0 auto;
                        overflow: visible;
                        box-shadow: var(--shadow-md);
                        position: relative;
                        z-index: 1;
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

                    .header-section {
                        background: var(--gradient-primary);
                        color: white;
                        padding: 30px 36px;
                        display: flex;
                        align-items: center;
                        gap: 20px;
                        position: relative;
                        overflow: hidden;
                    }

                    .header-section::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none"><path d="M0,0 L1000,0 L1000,100 L0,100 Z" fill="rgba(255,255,255,0.05)"/></svg>');
                        opacity: 0.1;
                    }

                    .header-icon {
                        font-size: 56px;
                        color: rgba(255, 255, 255, 0.95);
                        position: relative;
                        z-index: 1;
                    }

                    .header-title {
                        font-weight: var(--font-heading-weight);
                        margin: 0;
                        color: white;
                        font-size: 28px;
                        position: relative;
                        z-index: 1;
                    }

                    .header-sub {
                        margin: 5px 0 0 0;
                        opacity: 0.9;
                        font-size: 15px;
                        position: relative;
                        z-index: 1;
                    }

                    .section {
                        border: 1px solid #e2e8f0;
                        border-radius: 16px;
                        padding: 28px;
                        margin-bottom: 25px;
                        background: var(--bg-white);
                        transition: all 0.3s ease;
                        position: relative;
                        overflow: visible;
                    }

                    .section::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 4px;
                        height: 100%;
                        background: var(--gradient-primary);
                        opacity: 0;
                        transition: opacity 0.3s ease;
                    }

                    .section:hover {
                        box-shadow: var(--shadow-md);
                        border-color: var(--primary);
                    }

                    .section:hover::before {
                        opacity: 1;
                    }

                    .section-title {
                        color: var(--heading-text);
                        font-weight: var(--font-heading-weight);
                        margin-bottom: 24px;
                        padding-bottom: 12px;
                        border-bottom: 2px solid var(--primary);
                        font-size: 18px;
                        display: flex;
                        align-items: center;
                    }

                    .section-title i {
                        color: var(--icon-color);
                        background-color: var(--icon-bg-light);
                        padding: 8px;
                        border-radius: 10px;
                        margin-right: 12px;
                        font-size: 16px;
                    }

                    .subsection-title {
                        color: var(--primary);
                        font-weight: 600;
                        margin: 20px 0 15px 0;
                        font-size: 15px;
                        display: flex;
                        align-items: center;
                        gap: 8px;
                    }

                    .subsection-title i {
                        color: var(--primary);
                        font-size: 14px;
                    }

                    /* FORM STYLES */
                    form.p-4 {
                        padding: 2rem !important;
                    }

                    .form-row {
                        display: flex;
                        flex-wrap: wrap;
                        margin-right: -10px;
                        margin-left: -10px;
                    }

                    .form-group {
                        padding-right: 10px;
                        padding-left: 10px;
                        margin-bottom: 1.5rem;
                        width: 100%;
                    }

                    .col-md-6 {
                        flex: 0 0 50%;
                        max-width: 50%;
                    }

                    .col-md-4 {
                        flex: 0 0 33.333333%;
                        max-width: 33.333333%;
                    }

                    .col-md-3 {
                        flex: 0 0 25%;
                        max-width: 25%;
                    }

                    label {
                        display: block;
                        font-weight: 500;
                        color: var(--heading-text);
                        margin-bottom: 8px;
                        font-size: 14px;
                        text-align: left;
                    }

                    label i {
                        color: var(--primary);
                        margin-right: 6px;
                    }

                    .form-control {
                        display: block;
                        width: 100%;
                        height: 44px;
                        padding: 10px 14px;
                        font-size: 14px;
                        line-height: 1.5;
                        color: #1e293b;
                        background-color: #fff;
                        background-clip: padding-box;
                        border: 2px solid #e0e6ed;
                        border-radius: 10px;
                        transition: all 0.3s ease;
                    }

                    select.form-control:not([size]):not([multiple]) {
                        height: 44px;
                    }

                    textarea.form-control {
                        height: auto;
                        min-height: 80px;
                        resize: vertical;
                    }

                    .form-control:focus {
                        border-color: var(--primary);
                        outline: 0;
                        box-shadow: 0 0 0 4px rgba(25, 167, 123, 0.1);
                    }

                    .form-control-file {
                        display: block;
                        width: 100%;
                        padding: 14px 16px;
                        border: 2px dashed var(--border-dashed);
                        border-radius: 10px;
                        background-color: #f8fafc;
                        cursor: pointer;
                        transition: all 0.3s ease;
                    }

                    .form-control-file:hover {
                        border-color: var(--primary);
                        background-color: rgba(25, 167, 123, 0.02);
                    }

                    .submit-btn {
                        background: var(--gradient-primary);
                        color: var(--btn-primary-text);
                        border: none;
                        padding: 14px 44px;
                        font-size: 16px;
                        font-weight: 600;
                        border-radius: 30px;
                        transition: all 0.3s ease;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                        cursor: pointer;
                        box-shadow: 0 4px 16px rgba(25, 167, 123, 0.3);
                    }

                    .submit-btn:hover {
                        background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
                        color: var(--btn-primary-hover-text);
                        transform: translateY(-3px);
                        box-shadow: 0 8px 24px rgba(25, 167, 123, 0.4);
                    }

                    .status-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 6px;
                        padding: 6px 16px;
                        border-radius: 30px;
                        font-size: 12px;
                        font-weight: 600;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .status-active {
                        background: rgba(16, 185, 129, 0.12);
                        color: #10b981;
                        border: 1px solid rgba(16, 185, 129, 0.3);
                    }

                    .status-inactive {
                        background: rgba(239, 68, 68, 0.12);
                        color: #ef4444;
                        border: 1px solid rgba(239, 68, 68, 0.3);
                    }

                    /* Select2 customization */
                    .select2-container--default .select2-selection--single {
                        height: 44px;
                        border: 2px solid #e0e6ed;
                        border-radius: 10px;
                    }

                    .select2-container--default .select2-selection--single .select2-selection__rendered {
                        line-height: 42px;
                        padding-left: 14px;
                        color: #1e293b;
                    }

                    .select2-container--default .select2-selection--single .select2-selection__arrow {
                        height: 42px;
                    }

                    .select2-container--default .select2-results__option--highlighted[aria-selected] {
                        background-color: var(--primary) !important;
                    }

                    .select2-dropdown {
                        border: 2px solid #e0e6ed;
                        border-radius: 10px;
                        box-shadow: var(--shadow-md);
                    }

                    /* Responsive adjustments */
                    @media (max-width: 768px) {
                        .header-section {
                            flex-direction: column;
                            text-align: center;
                            padding: 24px 20px;
                        }

                        .header-icon {
                            font-size: 48px;
                        }

                        .header-title {
                            font-size: 24px;
                        }

                        .section {
                            padding: 18px;
                        }

                        .col-md-6,
                        .col-md-4,
                        .col-md-3 {
                            flex: 0 0 100%;
                            max-width: 100%;
                        }

                        .form-row {
                            margin-right: 0;
                            margin-left: 0;
                        }

                        .form-group {
                            padding-right: 0;
                            padding-left: 0;
                        }
                    }

                    /* Loading Spinner */
                    .loading-spinner {
                        display: inline-block;
                        width: 18px;
                        height: 18px;
                        border: 2px solid rgba(255, 255, 255, 0.3);
                        border-top-color: #fff;
                        border-radius: 50%;
                        animation: spin 0.6s linear infinite;
                    }

                    @keyframes spin {
                        to {
                            transform: rotate(360deg);
                        }
                    }
                </style>
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
            </head>

            <body>
                <div class="profile-container">
                    <!-- HEADER -->
                    <div class="header-section">
                        <i class="fas fa-user-circle header-icon"></i>
                        <div>
                            <h2 class="header-title">Update Your Profile</h2>
                            <p class="header-sub">Provide accurate details to match you with the right opportunities</p>
                        </div>
                    </div>

                    <!-- FORM -->
                    <form action="${pageContext.request.contextPath}/jobSeekers/update/${jobSeeker.id}" method="post"
                        enctype="multipart/form-data" class="p-4" id="updateProfileForm">

                        <!-- Error Message -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger"
                                style="background: #ef4444; color: white; padding: 14px 16px; border-radius: 12px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                                <i class="fas fa-exclamation-circle"></i> ${error}
                            </div>
                        </c:if>

                        <!-- SECTION: PERSONAL INFORMATION -->
                        <div class="section">
                            <h4 class="section-title"><i class="fas fa-user mr-2"></i>Personal Information</h4>

                            <!-- Row 1: Name and Phone -->
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="name"><i class="fas fa-user"></i> Full Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="name" name="name"
                                        value="${jobSeeker.name}" required>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="phone"><i class="fas fa-phone"></i> Phone Number <span class="text-danger">*</span></label>
                                    <input type="tel" class="form-control" id="phone" name="phone"
                                        value="${jobSeeker.phone}" pattern="[0-9]{10}" minlength="10" maxlength="10"
                                        title="Please enter exactly a 10-digit phone number" required
                                        oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 10)">
                                </div>
                            </div>

                            <!-- Row 2: Email and Location -->
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="email"><i class="fas fa-envelope"></i> Email <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" id="email" name="email"
                                        value="${jobSeeker.email}" required>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="location"><i class="fas fa-map-pin"></i> Location <span class="text-danger">*</span></label>
                                    <select name="location" id="location" class="form-control searchable-dropdown"
                                        data-placeholder="-- Select Location --" required>
                                        <option value="">-- Select Location --</option>
                                        <c:forEach var="loc" items="${locations}">
                                            <option value="${loc}" <c:if test="${loc == jobSeeker.location}">selected
                                                </c:if>>${loc}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <!-- Row 3: Pin Code, DOB, Age -->
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label for="pinCode"><i class="fas fa-map-marker-alt"></i> Pin Code <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="pinCode" name="pinCode"
                                        value="${jobSeeker.pinCode}" pattern="[0-9]{6}" maxlength="6"
                                        title="Please enter a 6-digit pin code" required
                                        oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 6)">
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="dateOfBirth"><i class="fas fa-calendar"></i> Date of Birth <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth"
                                        value="${jobSeeker.dateOfBirth}" max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="age"><i class="fas fa-birthday-cake"></i> Age <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="age" name="age"
                                        value="${jobSeeker.age}" min="18" max="100"
                                        title="Age must be between 18 and 100" required readonly style="background-color: #f8fafc; cursor: not-allowed;">
                                </div>
                            </div>

                            <!-- Row 4: Gender, Languages, Marital Status -->
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label for="gender"><i class="fas fa-venus-mars"></i> Gender <span class="text-danger">*</span></label>
                                    <select class="form-control" id="gender" name="gender" required>
                                        <option value="" disabled>Select gender</option>
                                        <option value="MALE" ${jobSeeker.gender=='MALE' ?'selected':''}>Male</option>
                                        <option value="FEMALE" ${jobSeeker.gender=='FEMALE' ?'selected':''}>Female
                                        </option>
                                        <option value="OTHER" ${jobSeeker.gender=='OTHER' ?'selected':''}>Other</option>
                                    </select>
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="languagesKnown"><i class="fas fa-language"></i> Languages Known</label>
                                    <select class="form-control searchable-dropdown" id="languagesKnown"
                                        name="languagesKnown" data-placeholder="-- Select Languages --"
                                        multiple="multiple">
                                        <option value="English"
                                            ${jobSeeker.languagesKnown.contains('English')?'selected':''}>English
                                        </option>
                                        <option value="Hindi"
                                            ${jobSeeker.languagesKnown.contains('Hindi')?'selected':''}>Hindi</option>
                                        <option value="Marathi"
                                            ${jobSeeker.languagesKnown.contains('Marathi')?'selected':''}>Marathi
                                        </option>
                                        <option value="Spanish"
                                            ${jobSeeker.languagesKnown.contains('Spanish')?'selected':''}>Spanish
                                        </option>
                                    </select>
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="maritalStatus"><i class="fas fa-ring"></i> Marital Status <span class="text-danger">*</span></label>
                                    <select class="form-control" id="maritalStatus" name="maritalStatus" required>
                                        <option value="Single" ${jobSeeker.maritalStatus=='Single' ?'selected':''}>
                                            Single</option>
                                        <option value="Married" ${jobSeeker.maritalStatus=='Married' ?'selected':''}>
                                            Married</option>
                                        <option value="Divorced" ${jobSeeker.maritalStatus=='Divorced' ?'selected':''}>
                                            Divorced</option>
                                        <option value="Widowed" ${jobSeeker.maritalStatus=='Widowed' ?'selected':''}>
                                            Widowed</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Row 5: Permanent Address -->
                            <div class="form-group">
                                <label for="permanentAddress"><i class="fas fa-home"></i> Permanent Address <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="permanentAddress" name="permanentAddress"
                                    rows="2" required>${jobSeeker.permanentAddress}</textarea>
                            </div>
                        </div>

                        <!-- SECTION: EDUCATION -->
                        <div class="section">
                            <h4 class="section-title"><i class="fas fa-graduation-cap mr-2"></i>Education</h4>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="education"><i class="fas fa-certificate"></i> Highest Education <span class="text-danger">*</span></label>
                                    <select name="education" id="education" class="form-control" required>
                                        <option value="" disabled>Select Education</option>
                                        <c:forEach var="edu" items="${education}">
                                            <option value="${edu}" <c:if test="${edu == jobSeeker.education}">selected
                                                </c:if>>${edu}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <!-- UG -->
                            <h6 class="subsection-title"><i class="fas fa-university"></i> Undergraduate (UG)</h6>
                            <div class="form-row">
                                <div class="form-group col-md-3">
                                    <label for="ugDegree">UG Degree</label>
                                    <input type="text" class="form-control" id="ugDegree" name="ugDegree"
                                        value="${jobSeeker.ugDegree}">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="ugSpecialization">Specialization</label>
                                    <input type="text" class="form-control" id="ugSpecialization"
                                        name="ugSpecialization" value="${jobSeeker.ugSpecialization}">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="ugUniversity">University</label>
                                    <input type="text" class="form-control" id="ugUniversity" name="ugUniversity"
                                        value="${jobSeeker.ugUniversity}">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="ugGraduationYear">Graduation Year</label>
                                    <input type="number" class="form-control" id="ugGraduationYear"
                                        name="ugGraduationYear" value="${jobSeeker.ugGraduationYear}">
                                </div>
                            </div>

                            <!-- PG -->
                            <h6 class="subsection-title"><i class="fas fa-user-graduate"></i> Postgraduate (PG)</h6>
                            <div class="form-row">
                                <div class="form-group col-md-3">
                                    <label for="pgDegree">PG Degree</label>
                                    <input type="text" class="form-control" id="pgDegree" name="pgDegree"
                                        value="${jobSeeker.pgDegree}">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="pgSpecialization">Specialization</label>
                                    <input type="text" class="form-control" id="pgSpecialization"
                                        name="pgSpecialization" value="${jobSeeker.pgSpecialization}">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="pgUniversity">University</label>
                                    <input type="text" class="form-control" id="pgUniversity" name="pgUniversity"
                                        value="${jobSeeker.pgUniversity}">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="pgGraduationYear">Graduation Year</label>
                                    <input type="number" class="form-control" id="pgGraduationYear"
                                        name="pgGraduationYear" value="${jobSeeker.pgGraduationYear}">
                                </div>
                            </div>

                            <!-- Doctorate -->
                            <h6 class="subsection-title"><i class="fas fa-flask"></i> Doctorate</h6>
                            <div class="form-row">
                                <div class="form-group col-md-3">
                                    <label for="doctorateDegree">Doctorate Degree</label>
                                    <input type="text" class="form-control" id="doctorateDegree" name="doctorateDegree"
                                        value="${jobSeeker.doctorateDegree}">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="doctorateSpecialization">Specialization</label>
                                    <input type="text" class="form-control" id="doctorateSpecialization"
                                        name="doctorateSpecialization" value="${jobSeeker.doctorateSpecialization}">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="doctorateUniversity">University</label>
                                    <input type="text" class="form-control" id="doctorateUniversity"
                                        name="doctorateUniversity" value="${jobSeeker.doctorateUniversity}">
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="doctorateGraduationYear">Graduation Year</label>
                                    <input type="number" class="form-control" id="doctorateGraduationYear"
                                        name="doctorateGraduationYear" value="${jobSeeker.doctorateGraduationYear}">
                                </div>
                            </div>
                        </div>

                        <!-- SECTION: EXPERIENCE -->
                        <div class="section">
                            <h4 class="section-title"><i class="fas fa-briefcase mr-2"></i>Experience</h4>
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label for="experience"><i class="fas fa-chart-line"></i> Experience (Years) <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="experience" name="experience"
                                        value="${jobSeeker.experience}" min="0" max="99"
                                        title="Experience must be between 0 and 99 years" required>
                                </div>

                                <!-- SKILLS FIX APPLIED HERE -->
                                <div class="form-group col-md-4">
                                    <label for="skills"><i class="fas fa-code"></i> Skills</label>
                                    <c:set var="skillsList" value="" />
                                    <c:forEach var="skill" items="${jobSeeker.skills}" varStatus="loop">
                                        <c:set var="skillsList" value="${skillsList}${skill}${!loop.last ? ',' : ''}" />
                                    </c:forEach>
                                    <input type="text" class="form-control" id="skills" name="skills"
                                        value="${skillsList}">
                                </div>

                                <div class="form-group col-md-4">
                                    <label for="workAvailability"><i class="fas fa-clock"></i> Work Availability</label>
                                    <select class="form-control" id="workAvailability" name="workAvailability">
                                        <option value="" disabled>Select availability</option>
                                        <option value="FULL_TIME" ${jobSeeker.workAvailability=='FULL_TIME'
                                            ?'selected':''}>Full Time</option>
                                        <option value="PART_TIME" ${jobSeeker.workAvailability=='PART_TIME'
                                            ?'selected':''}>Part Time</option>
                                        <option value="FREELANCE" ${jobSeeker.workAvailability=='FREELANCE'
                                            ?'selected':''}>Freelance</option>
                                        <option value="INTERNSHIP" ${jobSeeker.workAvailability=='INTERNSHIP'
                                            ?'selected':''}>Internship</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label for="annualSalary"><i class="fas fa-money-bill-wave"></i> Annual
                                        Salary</label>
                                    <input type="number" step="0.01" class="form-control" id="annualSalary"
                                        name="annualSalary" value="${jobSeeker.annualSalary}">
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="noticePeriod"><i class="fas fa-calendar-alt"></i> Notice Period</label>
                                    <input type="text" class="form-control" id="noticePeriod" name="noticePeriod"
                                        value="${jobSeeker.noticePeriod}">
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="resumeHeadline"><i class="fas fa-heading"></i> Resume Headline</label>
                                    <input type="text" class="form-control" id="resumeHeadline" name="resumeHeadline"
                                        value="${jobSeeker.resumeHeadline}">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="accountStatus"><i class="fas fa-toggle-on"></i> Account Status</label>
                                    <select class="form-control" id="accountStatus" name="accountStatus">
                                        <option value="">-- Select Status --</option>
                                        <option value="ACTIVE" ${jobSeeker.accountStatus=='ACTIVE' ?'selected':''}>
                                            Active</option>
                                        <option value="DEACTIVATED" ${jobSeeker.accountStatus=='DEACTIVATED'
                                            ?'selected':''}>Deactivated</option>
                                        <option value="OPEN_TO_WORK" ${jobSeeker.accountStatus=='OPEN_TO_WORK'
                                            ?'selected':''}>Open to Work</option>
                                        <option value="EMPLOYED_OPEN_TO_OPPORTUNITY"
                                            ${jobSeeker.accountStatus=='EMPLOYED_OPEN_TO_OPPORTUNITY' ?'selected':''}>
                                            Employed but Open</option>
                                        <option value="ACTIVELY_APPLYING" ${jobSeeker.accountStatus=='ACTIVELY_APPLYING'
                                            ?'selected':''}>Actively Applying</option>
                                        <option value="NOT_OPEN_TO_WORK" ${jobSeeker.accountStatus=='NOT_OPEN_TO_WORK'
                                            ?'selected':''}>Not Looking</option>
                                    </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label><i class="fas fa-info-circle"></i> Current Status</label>
                                    <div>
                                        <c:choose>
                                            <c:when
                                                test="${not empty jobSeeker.accountStatus && jobSeeker.accountStatus == 'ACTIVE'}">
                                                <span class="status-badge status-active">
                                                    <i class="fas fa-check-circle"></i> Active
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-inactive">
                                                    <i class="fas fa-times-circle"></i> Inactive
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- SECTION: DOCUMENTS -->
                        <div class="section">
                            <h4 class="section-title"><i class="fas fa-file-upload mr-2"></i>Documents</h4>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="image"><i class="fas fa-camera"></i> Profile Photo</label>
                                    <input type="file" class="form-control-file" id="image" name="image"
                                        accept="image/*">
                                    <small class="form-text text-muted mt-2">Supported: JPG, PNG, GIF</small>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="identityDoc"><i class="fas fa-id-card"></i> Identity Document</label>
                                    <input type="file" class="form-control-file" id="identityDoc" name="identityDoc"
                                        accept=".pdf,.jpg,.jpeg,.png">
                                    <small class="form-text text-muted mt-2">Supported: PDF, JPG, PNG</small>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="resume"><i class="fas fa-file-pdf"></i> Resume</label>
                                    <input type="file" class="form-control-file" id="resume" name="resume"
                                        accept=".pdf,.doc,.docx">
                                    <small class="form-text text-muted mt-2">Supported: PDF, DOC, DOCX</small>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="videoResume"><i class="fas fa-video"></i> Video Resume</label>
                                    <input type="file" class="form-control-file" id="videoResume" name="videoResume"
                                        accept="video/mp4,video/webm">
                                    <small class="form-text text-muted mt-2">Supported: MP4, WEBM</small>
                                </div>
                            </div>
                        </div>

                        <!-- SUBMIT -->
                        <div class="text-center mt-4 mb-3">
                            <button type="submit" class="submit-btn" id="submitBtn">
                                <i class="fas fa-save mr-2"></i> Save & Update Profile
                            </button>
                        </div>
                    </form>
                </div>

                <script>
                    $(document).ready(function () {
                        // Initialize Select2
                        $('.searchable-dropdown').select2({
                            placeholder: function () {
                                return $(this).data('placeholder');
                            },
                            allowClear: true,
                            width: '100%'
                        });

                        const $form = $('#updateProfileForm');
                        const $submitBtn = $('#submitBtn');

                        // Form submission with loading state
                        $form.on('submit', function (e) {
                            // Basic validation check before disabling
                            if (this.checkValidity()) {
                                $submitBtn.html('<span class="loading-spinner"></span> Updating Profile...').prop('disabled', true);
                                return true;
                            }
                            return false;
                        });

                        // Keyboard shortcuts (Ctrl+S or Cmd+S to save)
                        $(document).on('keydown', function (e) {
                            if ((e.ctrlKey || e.metaKey) && e.key === 's') {
                                e.preventDefault();
                                $form.submit();
                            }
                        });

                        // Auto-calculate age from Date of Birth
                        $('#dateOfBirth').on('change', function() {
                            if(this.value) {
                                const dob = new Date(this.value);
                                const today = new Date();
                                let age = today.getFullYear() - dob.getFullYear();
                                const m = today.getMonth() - dob.getMonth();
                                if (m < 0 || (m === 0 && today.getDate() < dob.getDate())) {
                                    age--;
                                }
                                $('#age').val(age);
                            } else {
                                $('#age').val('');
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