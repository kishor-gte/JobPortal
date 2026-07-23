<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Upload Interview Questions | JobU - Assessment Management</title>
    
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
            --warning: #f59e0b;
            --success: #19A77B;
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

        /* ========== UPLOAD CARD ========== */
        .upload-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 40px;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(25,167,123,0.1);
            transition: var(--transition);
        }
        .upload-card:hover {
            box-shadow: var(--shadow-md);
        }

        .upload-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.08));
            border-radius: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 24px;
        }
        .upload-icon i {
            font-size: 36px;
            color: var(--primary);
        }

        /* Info Boxes */
        .info-box {
            background: linear-gradient(135deg, rgba(25,167,123,0.08), rgba(59,196,154,0.04));
            border-left: 4px solid var(--primary);
            border-radius: 12px;
            padding: 16px 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }
        .info-box i {
            color: var(--primary);
            font-size: 1.1rem;
            margin-top: 2px;
        }
        .info-box p {
            margin: 0;
            font-size: 0.85rem;
            color: var(--text-muted);
            line-height: 1.5;
        }
        .info-box strong {
            color: var(--text-dark);
        }

        .success-box {
            background: linear-gradient(135deg, rgba(25, 167, 123,0.08), rgba(25, 167, 123,0.04));
            border-left-color: var(--success);
        }
        .success-box i {
            color: var(--success);
        }

        /* Form Styles */
        .form-label {
            font-weight: 600;
            font-size: 0.85rem;
            color: var(--text-dark);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .form-label i {
            color: var(--primary);
        }
        .form-control, .form-select {
            border: 2px solid var(--border);
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 0.9rem;
            transition: var(--transition);
            background: var(--bg-light);
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.1);
            outline: none;
            background: var(--white);
        }
        .form-text {
            font-size: 0.7rem;
            color: var(--text-muted);
            margin-top: 6px;
        }

        /* File Upload Area */
        .file-upload-wrapper {
            margin-bottom: 20px;
        }
        .file-upload-label {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 12px;
            padding: 40px 20px;
            border: 2px dashed var(--border);
            border-radius: 20px;
            background: var(--bg-light);
            cursor: pointer;
            transition: var(--transition);
            text-align: center;
        }
        .file-upload-label:hover {
            border-color: var(--primary);
            background: rgba(25,167,123,0.05);
        }
        .file-upload-label.has-file {
            border-color: var(--primary);
            background: rgba(25,167,123,0.05);
        }
        .file-upload-icon {
            font-size: 48px;
            color: var(--primary);
        }
        .file-upload-label span {
            color: var(--text-muted);
            font-size: 0.85rem;
        }
        .file-name {
            font-weight: 600;
            color: var(--primary-dark);
            margin-top: 8px;
        }

        /* Checkboxes */
        .form-check {
            padding: 16px 20px;
            background: var(--bg-light);
            border-radius: 12px;
            margin-bottom: 12px;
            border: 1px solid var(--border);
        }
        .form-check-input {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }
        .form-check-input:checked {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        .form-check-label {
            font-weight: 600;
            margin-left: 10px;
            color: var(--text-dark);
        }

        /* Submit Button */
        .btn-upload {
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 60px;
            padding: 14px 28px;
            font-size: 1rem;
            font-weight: 700;
            width: 100%;
            transition: var(--transition);
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
            margin-top: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .btn-upload:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 40px 0 30px; }
            .page-header h1 { font-size: 1.5rem; }
            .upload-card { padding: 28px; }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header" data-aos="fade-down">
        <div class="container text-center">
            <h1><i class="fas fa-file-upload me-2"></i>Upload Interview Questions</h1>
            <p>Upload Excel file containing interview questions for this job position</p>
        </div>
    </div>

    <div class="container">
        <!-- Back Button -->
        <a href="${pageContext.request.contextPath}/jobs/by-company/${companyId}" class="back-btn" data-aos="fade-right">
            <i class="fas fa-arrow-left"></i> Back to Job Listings
        </a>

        <!-- Upload Card -->
        <div class="upload-card" data-aos="fade-up" data-aos-delay="100">
            <div class="upload-icon">
                <i class="fas fa-file-excel"></i>
            </div>

            <!-- Job Info Box -->
            <div class="info-box">
                <i class="fas fa-briefcase"></i>
                <p><strong>Job ID:</strong> ${jobId} <c:if test="${not empty jobTitle}"> | <strong>Title:</strong> ${jobTitle}</c:if></p>
            </div>

            <!-- Note Box -->
            <div class="info-box">
                <i class="fas fa-info-circle"></i>
                <p><strong>Note:</strong> Please upload an Excel file (.xlsx) with the required format. The file should contain columns for questions, options, and correct answers.</p>
            </div>

            <!-- How It Works Box -->
            <div class="info-box success-box">
                <i class="fas fa-question-circle"></i>
                <p><strong>Want to know how your questions are used?</strong><br>After uploading, these questions will be sent to job seekers as an assessment test. <a href="${pageContext.request.contextPath}/company/assessments/info" style="color: var(--primary); font-weight: 600;">Learn more about the assessment process →</a></p>
            </div>

            <!-- Upload Form -->
            <form action="${pageContext.request.contextPath}/company/assessments/upload" method="post" enctype="multipart/form-data" id="uploadForm">
                <input type="hidden" name="jobId" value="${jobId}" />
                <input type="hidden" name="companyId" value="${companyId}" />

                <!-- Skill Input -->
                <div class="mb-4">
                    <label for="skill" class="form-label"><i class="fas fa-code"></i> Skill Name</label>
                    <input type="text" class="form-control" id="skill" name="skill" placeholder="e.g. Java, Python, JavaScript" required>
                    <div class="form-text">Enter the skill name for these interview questions</div>
                </div>

                <!-- File Upload -->
                <div class="mb-4">
                    <label class="form-label"><i class="fas fa-file-excel"></i> Excel File (.xlsx)</label>
                    <div class="file-upload-wrapper">
                        <input type="file" id="fileInput" name="file" accept=".xlsx" required style="display: none;" onchange="handleFileSelect(event)">
                        <label for="fileInput" class="file-upload-label" id="fileLabel">
                            <i class="fas fa-cloud-upload-alt file-upload-icon"></i>
                            <span>Click to select Excel file or drag and drop</span>
                            <small>Only .xlsx files are accepted</small>
                            <span class="file-name" id="fileName" style="display: none;"></span>
                        </label>
                    </div>
                </div>

                <!-- Replace Option -->
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="replace" name="replace">
                    <label class="form-check-label" for="replace">
                        <i class="fas fa-sync-alt me-1"></i> Replace existing questions for this skill
                    </label>
                    <div class="form-text ms-4 mt-1">If checked, all existing questions for this skill will be deleted before uploading new ones</div>
                </div>

                <!-- Replace Invitations Option -->
                <div class="form-check" style="background: linear-gradient(135deg, rgba(25,167,123,0.05), rgba(59,196,154,0.02));">
                    <input class="form-check-input" type="checkbox" id="replaceInvitations" name="replaceInvitations">
                    <label class="form-check-label" for="replaceInvitations">
                        <i class="fas fa-paper-plane me-1"></i> Reset and send invitations to ALL job seekers
                    </label>
                    <div class="form-text ms-4 mt-1">If checked, all existing invitations will be deleted and new ones will be created for ALL job seekers</div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-upload">
                    <i class="fas fa-upload"></i> Upload Questions
                </button>
            </form>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true, offset: 50 });

        function handleFileSelect(event) {
            const fileInput = event.target;
            const fileLabel = document.getElementById('fileLabel');
            const fileName = document.getElementById('fileName');
            
            if (fileInput.files && fileInput.files.length > 0) {
                const file = fileInput.files[0];
                fileName.textContent = file.name;
                fileName.style.display = 'block';
                fileLabel.classList.add('has-file');
                fileLabel.innerHTML = `
                    <i class="fas fa-check-circle file-upload-icon"></i>
                    <span class="file-name">${file.name}</span>
                    <small>Click to change file</small>
                `;
            } else {
                fileName.style.display = 'none';
                fileLabel.classList.remove('has-file');
                fileLabel.innerHTML = `
                    <i class="fas fa-cloud-upload-alt file-upload-icon"></i>
                    <span>Click to select Excel file or drag and drop</span>
                    <small>Only .xlsx files are accepted</small>
                `;
            }
        }

        // Form validation
        document.getElementById('uploadForm').addEventListener('submit', function(e) {
            const skillInput = document.getElementById('skill');
            const fileInput = document.getElementById('fileInput');
            
            if (!skillInput.value.trim()) {
                e.preventDefault();
                alert('Please enter a skill name');
                skillInput.focus();
                return false;
            }
            
            if (!fileInput.files || fileInput.files.length === 0) {
                e.preventDefault();
                alert('Please select an Excel file to upload');
                return false;
            }
            
            const file = fileInput.files[0];
            if (!file.name.endsWith('.xlsx')) {
                e.preventDefault();
                alert('Please select a valid Excel file (.xlsx)');
                return false;
            }
        });
    </script>
</body>
</html>