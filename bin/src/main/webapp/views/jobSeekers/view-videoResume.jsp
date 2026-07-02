<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="in.sp.main.Entities.JobSeeker" %>
<%
    JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
    pageContext.setAttribute("jobSeeker", jobSeeker);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Video Resume | SmartInterview</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
            --background-light: #f6f9fc;
            --font-main: 'Inter', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            font-family: var(--font-main);
            padding: 0;
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
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }

        /* Blue Sidebar with Curved Design - Updated Colors */
        .career-sidebar {
            background: var(--gradient-primary);
            width: 280px;
            min-height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            z-index: 1000;
            padding: 0;
            box-shadow: var(--shadow-md);
            transition: transform 0.3s ease;
            border-radius: 0 20px 20px 0;
            backdrop-filter: blur(10px);
        }

        .sidebar-header {
            padding: 24px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.15);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            min-height: 90px;
        }  

        .sidebar-logo {
            width: 48px;
            height: 48px;
            background-image: url('${pageContext.request.contextPath}/assets/images/logo/logo.png');
            background-repeat: no-repeat;
            background-position: center;
            background-size: contain;
            flex-shrink: 0;
        }

        .sidebar-company-name {
            color: white;
            font-weight: 700;
            font-size: 1.1rem;
            line-height: 1.2;
        }

        .sidebar-dashboard-btn {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px 24px;
            text-decoration: none;
            color: #ffffff;
            border: none;
            background: transparent;
            justify-content: flex-start;
            width: 100%;
            margin: 8px 0;
        }

        .sidebar-dashboard-btn i {
            font-size: 1.2rem;
            min-width: 20px;
        }

        .sidebar-dashboard-btn:hover {
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
        }

        .sidebar-nav {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar-nav li {
            margin: 0;
        }

        .sidebar-nav a {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px 24px;
            color: #ffffff;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
            margin: 2px 8px;
            border-radius: 0 12px 12px 0;
        }

        .sidebar-nav a i {
            width: 20px;
            text-align: center;
            font-size: 1.1rem;
            color: #ffffff;
        }

        .sidebar-nav a:hover {
            background: rgba(255, 255, 255, 0.15);
            border-left-color: #ffffff;
            transform: translateX(4px);
        }

        .sidebar-nav a.active {
            background: rgba(255, 255, 255, 0.2);
            color: #ffffff;
            border-left-color: #ffffff;
            font-weight: 600;
            border-radius: 0 12px 12px 0;
            box-shadow: inset 0 0 20px rgba(255, 255, 255, 0.1);
        }

        .sidebar-nav .submenu {
            list-style: none;
            padding: 0;
            margin: 0;
            background: rgba(0, 0, 0, 0.1);
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
        }

        .sidebar-nav .submenu.show {
            max-height: 500px;
        }

        .sidebar-nav .submenu li {
            margin: 0;
        }

        .sidebar-nav .submenu a {
            padding-left: 58px;
            font-size: 0.9rem;
        }

        .sidebar-nav .has-submenu > a::after {
            content: '\f107';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-left: auto;
            transition: transform 0.3s ease;
        }

        .sidebar-nav .has-submenu > a.open::after {
            transform: rotate(180deg);
        }

        /* Main Content Wrapper */
        .main-content-wrapper {
            margin-left: 280px;
            padding: 40px 24px;
            transition: margin-left 0.3s ease;
            position: relative;
            z-index: 5;
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

        /* Mobile Toggle Button */
        .sidebar-toggle-btn {
            display: none;
            position: fixed;
            top: 15px;
            left: 15px;
            z-index: 1001;
            background: var(--primary);
            color: white;
            border: none;
            padding: 12px 18px;
            border-radius: 12px;
            font-size: 1.2rem;
            cursor: pointer;
            box-shadow: var(--shadow-md);
        }

        .sidebar-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
            z-index: 999;
        }

        /* Responsive Design */
        @media (max-width: 991.98px) {
            .sidebar-toggle-btn {
                display: block;
            }

            .career-sidebar {
                transform: translateX(-100%);
                border-radius: 0;
            }

            .career-sidebar.show {
                transform: translateX(0);
                border-radius: 0 20px 20px 0;
            }

            .main-content-wrapper {
                margin-left: 0;
                padding: 70px 20px 20px;
            }

            .sidebar-overlay.show {
                display: block;
            }
        }

        @media (max-width: 576px) {
            .main-content-wrapper {
                padding: 70px 15px 15px;
            }
        }

        /* ===============================
           PREMIUM VIDEO RESUME STYLES
        =============================== */

        .video-container {
            background: var(--white);
            border-radius: 20px;
            border: 1px solid rgba(25, 167, 123, 0.1);
            padding: 32px 36px;
            box-shadow: var(--shadow-md);
            max-width: 900px;
            margin: 0 auto;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 8px;
        }

        .page-title i {
            font-size: 32px;
            color: var(--primary);
        }

        .video-container h2 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 6px;
            color: var(--text-primary);
        }

        .video-container h2::after {
            content: "Recruiters view this before shortlisting";
            display: block;
            font-size: 14px;
            font-weight: 400;
            color: var(--text-secondary);
            margin-top: 6px;
        }

        .tip-banner {
            background: linear-gradient(135deg, rgba(25, 167, 123, 0.05), rgba(59, 196, 154, 0.05));
            border: 1px solid rgba(25, 167, 123, 0.15);
            border-radius: 14px;
            padding: 16px 20px;
            margin: 24px 0;
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .tip-banner i {
            font-size: 28px;
            color: var(--primary);
        }

        .tip-banner p {
            margin: 0;
            font-size: 14px;
            color: var(--text-primary);
            line-height: 1.5;
        }

        .tip-banner strong {
            color: var(--primary);
        }

        /* Video emphasis */
        .video-box {
            margin: 24px 0 32px;
            position: relative;
        }

        .video-box video {
            width: 100%;
            max-height: 440px;
            border-radius: 16px;
            border: 2px solid rgba(25, 167, 123, 0.15);
            background: #000;
            box-shadow: var(--shadow-sm);
        }

        .video-box::before {
            content: "Your Video Resume";
            position: absolute;
            top: -14px;
            left: 20px;
            background: var(--white);
            padding: 4px 16px;
            font-size: 13px;
            font-weight: 600;
            color: var(--primary);
            border-radius: 30px;
            border: 1px solid rgba(25, 167, 123, 0.2);
        }

        /* Section cards */
        .form-section {
            border: 1px solid rgba(25, 167, 123, 0.1);
            border-radius: 16px;
            padding: 24px 28px;
            margin-bottom: 20px;
            background: var(--white);
            transition: all 0.3s ease;
        }

        .form-section:hover {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }

        .form-section h4 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-section h4 i {
            color: var(--primary);
        }

        .form-section h4::after {
            content: "Supported format: MP4 • Max 2 mins recommended";
            display: block;
            font-size: 12px;
            font-weight: 400;
            color: var(--text-secondary);
            margin-left: auto;
        }

        /* Inputs */
        .form-group {
            margin-bottom: 0;
        }

        .form-group label {
            font-size: 14px;
            font-weight: 500;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .form-control-file {
            border: 2px dashed var(--border-color);
            padding: 12px 16px;
            border-radius: 12px;
            font-size: 14px;
            background: #fafdfc;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .form-control-file:hover {
            border-color: var(--primary);
            background: rgba(25, 167, 123, 0.02);
        }

        .form-control-file:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }

        .form-section form {
            display: flex;
            align-items: flex-end;
            gap: 16px;
            flex-wrap: wrap;
        }

        .form-section .form-group {
            flex: 1;
        }

        .form-section .form-control-file {
            height: 46px;
            padding: 10px 14px;
        }

        /* Buttons */
        .btn-primary {
            background: var(--gradient-primary);
            border: none;
            border-radius: 12px;
            padding: 12px 28px;
            font-size: 14px;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
            height: 46px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .btn-danger {
            background: transparent;
            border: 1px solid var(--danger);
            color: var(--danger);
            border-radius: 12px;
            padding: 12px 28px;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            background: var(--danger);
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        /* Empty state tip */
        .video-container:has(form[action*="save"]) .tip-banner {
            margin-bottom: 32px;
        }

        /* Mobile polish */
        @media (max-width: 576px) {
            .video-container {
                padding: 20px;
            }

            .video-container h2 {
                font-size: 22px;
            }

            .form-section {
                padding: 20px;
            }

            .form-section h4::after {
                display: none;
            }

            .video-box video {
                max-height: 280px;
            }

            .tip-banner {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/views/commons/student_sidebar.jsp" />

<!-- Main Content -->
<div class="main-content-wrapper">
<div class="container video-container">
    <div class="page-title">
        <i class="fas fa-video"></i>
        <h2>Video Resume</h2>
    </div>

    <!-- Tip Banner -->
    <div class="tip-banner">
        <i class="fas fa-lightbulb"></i>
        <p><strong>Pro Tip:</strong> A short introduction plus skills overview increases profile views by <strong>40%</strong>. Keep it under 2 minutes for best results.</p>
    </div>

    <c:if test="${video != null}">
        <div class="video-box">
            <video controls>
                <source src="${pageContext.request.contextPath}${video.filePath}" type="video/mp4">
                Your browser does not support HTML5 video.
            </video>
        </div>

        <!-- Update Section -->
        <div class="form-section">
            <h4><i class="fas fa-sync-alt"></i> Update Your Video Resume</h4>
            <form action="${pageContext.request.contextPath}/jobseeker/videos/update" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${video.id}" />
                <div class="form-group">
                    <label for="updateFile">Choose New Video:</label>
                    <input type="file" class="form-control-file" name="filepath" id="updateFile" accept="video/mp4" required />
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-upload"></i> Update
                </button>
            </form>
        </div>

        <!-- Delete Section -->
        <div class="form-section">
            <form action="${pageContext.request.contextPath}/jobseeker/videos/delete" method="post" onsubmit="return confirm('Are you sure you want to delete this video resume?');">
                <input type="hidden" name="id" value="${video.id}" />
                <button type="submit" class="btn btn-danger">
                    <i class="fas fa-trash-alt"></i> Delete Video Resume
                </button>
            </form>
        </div>
    </c:if>

    <!-- Upload Section -->
    <c:if test="${video == null}">
        <div class="form-section">
            <h4><i class="fas fa-cloud-upload-alt"></i> Upload Your Video Resume</h4>
            <form action="${pageContext.request.contextPath}/jobseeker/videos/save" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="uploadFile">Select Video File:</label>
                    <input type="file" class="form-control-file" name="filepath" id="uploadFile" accept="video/mp4" required />
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-upload"></i> Upload
                </button>
            </form>
        </div>
    </c:if>
</div>
</div>

<script>


    // File input enhancement
    document.addEventListener('DOMContentLoaded', function() {
        const fileInputs = document.querySelectorAll('.form-control-file');
        fileInputs.forEach(input => {
            input.addEventListener('change', function(e) {
                const fileName = this.files[0]?.name || 'No file chosen';
                const label = this.closest('.form-group')?.querySelector('label');
                if (label) {
                    const originalText = label.getAttribute('data-original') || label.textContent;
                    if (!label.getAttribute('data-original')) {
                        label.setAttribute('data-original', originalText);
                    }
                    label.innerHTML = `<i class="fas fa-check-circle" style="color: var(--success);"></i> Selected: ${fileName}`;
                }
            });
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                const sidebar = document.getElementById('careerSidebar');
                const overlay = document.querySelector('.sidebar-overlay');
                sidebar.classList.remove('show');
                overlay.classList.remove('show');
            }
        });
    });
</script>
</body>
</html>