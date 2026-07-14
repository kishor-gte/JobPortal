<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Resume | SmartInterview</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
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

        .container {
            background-color: var(--white);
            padding: 48px 40px;
            border-radius: 24px;
            box-shadow: var(--shadow-lg);
            text-align: center;
            max-width: 750px;
            width: 100%;
            position: relative;
            z-index: 1;
            border: 1px solid rgba(25, 167, 123, 0.1);
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header-icon {
            width: 72px;
            height: 72px;
            background: rgba(25, 167, 123, 0.1);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            border: 1px solid rgba(25, 167, 123, 0.2);
        }

        .header-icon i {
            font-size: 36px;
            color: var(--primary);
        }

        h2 {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 8px;
            font-size: 28px;
            font-weight: 700;
        }

        .subtitle {
            color: var(--text-secondary);
            font-size: 14px;
            margin-bottom: 28px;
        }

        .video-wrapper {
            position: relative;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: var(--shadow-md);
            border: 2px solid rgba(25, 167, 123, 0.15);
            margin-bottom: 24px;
            background: #000;
        }

        video {
            width: 100%;
            max-height: 400px;
            border-radius: 14px;
            display: block;
        }

        .uploader-info {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 14px 20px;
            background: rgba(25, 167, 123, 0.05);
            border-radius: 14px;
            border: 1px solid rgba(25, 167, 123, 0.1);
            margin-top: 20px;
        }

        .uploader-info i {
            color: var(--primary);
            font-size: 18px;
        }

        .uploader-info p {
            color: var(--text-secondary);
            font-size: 15px;
            margin: 0;
        }

        .uploader-info strong {
            color: var(--text-primary);
        }

        .empty-state {
            padding: 40px 20px;
        }

        .empty-state i {
            font-size: 56px;
            color: var(--primary);
            opacity: 0.3;
            margin-bottom: 20px;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .empty-state p {
            color: var(--text-secondary);
            font-size: 16px;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            margin-top: 24px;
            padding: 10px 20px;
            border-radius: 30px;
            border: 2px solid rgba(25, 167, 123, 0.2);
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: var(--glow-primary);
        }

        @media (max-width: 768px) {
            .container {
                padding: 32px 24px;
            }

            h2 {
                font-size: 24px;
            }

            .header-icon {
                width: 60px;
                height: 60px;
            }

            .header-icon i {
                font-size: 30px;
            }

            video {
                max-height: 300px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 24px 16px;
            }

            h2 {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-icon">
        <i class="fas fa-video"></i>
    </div>
    <h2>Video Resume</h2>
    <p class="subtitle">View the candidate's video introduction</p>

    <c:if test="${not empty video}">
        <div class="video-wrapper">
            <video controls controlsList="nodownload" preload="auto" playsinline>
                <c:set var="videoType" value="video/mp4" />
                <c:if test="${fn:endsWith(fn:toLowerCase(video.filePath), '.webm')}">
                    <c:set var="videoType" value="video/webm" />
                </c:if>
                <c:if test="${fn:endsWith(fn:toLowerCase(video.filePath), '.ogg')}">
                    <c:set var="videoType" value="video/ogg" />
                </c:if>
                <c:if test="${fn:endsWith(fn:toLowerCase(video.filePath), '.mov') or fn:endsWith(fn:toLowerCase(video.filePath), '.qt')}">
                    <c:set var="videoType" value="video/quicktime" />
                </c:if>
                <source src="${pageContext.request.contextPath}${video.filePath}" type="${videoType}">
                Your browser does not support the video tag.
            </video>
        </div>
        <div class="uploader-info">
            <i class="fas fa-user-circle"></i>
            <p>Uploaded by: <strong>${video.uploadedBy.name}</strong></p>
        </div>
    </c:if>

    <c:if test="${empty video}">
        <div class="empty-state">
            <i class="fas fa-video-slash"></i>
            <p>No video resume has been uploaded by this job seeker.</p>
        </div>
    </c:if>

    <a href="javascript:history.back()" class="btn-back">
        <i class="fas fa-arrow-left"></i> Back
    </a>
</div>

<script>
    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            window.history.back();
        }
    });
</script>
</body>
</html>
