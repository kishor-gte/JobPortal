<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Company Jobs | JobU - Manage Your Job Listings</title>

    <!-- Recruiter Header Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/LineIcons.2.0.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/animate.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/glightbox.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"> 

    <style>
        /* Header styling from profile.jsp */
        .header .navbar-area {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
        }
        .header .navbar-nav > .nav-item > a {
            color: #1e293b !important;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        .header .navbar-nav > .nav-item > a:hover,
        .header .navbar-nav > .nav-item > a.active {
            color: #19A77B !important;
        }
        @media (min-width: 992px) {
            .header, .header .navbar-area, .header .navbar, .header .navbar-collapse, .header .navbar-nav, .header .navbar-nav > .nav-item {
                overflow: visible !important;
            }
        }
        .header .navbar-nav li .sub-menu {
            overflow: visible !important;
            z-index: 9999999 !important;
        }
        .header .navbar-nav li .sub-menu::before {
            height: 15px !important;
            top: -15px !important;
            content: '';
            position: absolute;
            left: 0;
            width: 100%;
            background: transparent;
        }
        .header .navbar-nav .sub-menu li a {
            color: #1e293b !important;
            background-color: transparent !important;
        }
        .header .navbar-nav .sub-menu li a:hover,
        .header .navbar-nav .sub-menu li:hover > a,
        .header .navbar-nav .sub-menu li a:focus,
        .header .navbar-nav .sub-menu li:focus-within > a,
        .header .navbar-nav .sub-menu li a:active,
        .header .navbar-nav .sub-menu li a.active {
            background-color: #19A77B !important;
            color: #ffffff !important;
        }
        .header .button .btn {
            background: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
            color: white !important;
            border: none;
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }
        .header .button .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }
    
/* ========== PAGE HEADER ========== */
        .page-header {
            background: var(--gradient);
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

    <!-- Company Jobs Specific Styles (Override generic styles above) -->
    <!-- Using Bootstrap 5.3.2 from above instead of 4.5.2 to avoid conflicts -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/companyJobs.css">
    
    <style>
        /* ============================================
           PREMIUM COLOR SCHEME
           --primary: #19A77B
           --primary-dark: #148F69
           --accent: #3BC49A
           --bg-dark: #2E3E41
        ============================================ */
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --accent-light: #6ed4b2;
            --bg-dark: #2E3E41;
            --bg-dark-light: #3d5256;
            --bg-light: #eef3f0;
            --card-bg: rgba(255, 255, 255, 0.98);
            --text-dark: #1e2a2e;
            --text-muted: #5b7c6e;
            --success: #19A77B;
            --danger: #ef4444;
            --warning: #f59e0b;
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
            --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.08);
            --shadow-xl: 0 25px 50px -12px rgba(25, 167, 123, 0.25);
            --transition: all 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            --radius-sm: 12px;
            --radius-md: 16px;
            --radius-lg: 24px;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: radial-gradient(ellipse at 20% 30%, #eef7f2 0%, #e0ece6 100%);
            color: var(--text-dark);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* animated background mesh */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 15% 30%, rgba(25,167,123,0.05) 0%, transparent 40%),
                radial-gradient(circle at 85% 70%, rgba(59,196,154,0.04) 0%, transparent 45%),
                radial-gradient(circle at 50% 90%, rgba(25,167,123,0.03) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: meshFloat 18s ease-in-out infinite alternate;
        }

        @keyframes meshFloat {
            0% { opacity: 0.5; transform: scale(1); }
            100% { opacity: 1; transform: scale(1.03); }
        }

        /* floating particles */
        body::after {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(circle at 20% 40%, rgba(25,167,123,0.06) 1px, transparent 1px);
            background-size: 32px 32px;
            pointer-events: none;
            animation: particleDrift 25s linear infinite;
        }

        @keyframes particleDrift {
            0% { background-position: 0 0; }
            100% { background-position: 65px 65px; }
        }

        .floating-shape {
            position: fixed;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            opacity: 0.03;
            pointer-events: none;
            z-index: 0;
            filter: blur(45px);
        }

        /* Hero Section Premium (Matching Profile.jsp) */
        .call-action {
            position: relative;
            background: var(--gradient-primary) url('${pageContext.request.contextPath}/assets/images/hero/company2.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 80px 20px 60px;
            border-radius: 0 0 30px 30px;
            text-align: center;
            overflow: hidden;
            margin-bottom: 40px;
            box-shadow: var(--shadow-md);
        }

        .call-action::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(25, 167, 123, 0.85); /* fallback */
            background: linear-gradient(135deg, rgba(25, 167, 123, 0.9) 0%, rgba(59, 196, 154, 0.85) 100%);
            z-index: 1;
        }

        .call-action .container {
            position: relative;
            z-index: 2;
        }

        .call-action h2 {
            color: #fff;
            font-size: 32px;
            font-weight: 800;
            margin-bottom: 15px;
            position: relative;
            z-index: 2;
        }

        .call-action p {
            color: rgba(255, 255, 255, 0.95);
            font-size: 18px;
            margin-bottom: 1.5rem;
            position: relative;
            z-index: 2;
        }

        .btn-outline-light {
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.25);
            border-radius: 50px;
            padding: 0.7rem 1.8rem;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-outline-light:hover {
            background: white;
            color: var(--primary-dark);
            transform: translateY(-2px);
        }

        /* Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1.5rem 3rem;
            position: relative;
            z-index: 2;
        }

        /* Job Card Premium */
        .job-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.08);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            animation: cardFadeIn 0.5s ease-out both;
        }

        @keyframes cardFadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .job-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        .job-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s ease;
        }

        .job-card:hover::before {
            transform: scaleX(1);
        }

        /* Badge Status */
        .badge-status {
            position: absolute;
            top: 1.5rem;
            right: 1.5rem;
            padding: 0.25rem 0.75rem;
            border-radius: 40px;
            font-size: 0.7rem;
            font-weight: 700;
            background: rgba(25,167,123,0.12);
            color: var(--primary);
        }

        .badge-status:contains("ACTIVE") { background: rgba(25, 167, 123,0.12); color: #19A77B; }
        .badge-status:contains("INACTIVE") { background: rgba(239,68,68,0.12); color: #ef4444; }

        /* Card Header */
        .card-header {
            background: none;
            border: none;
            padding: 0 0 1rem 0;
            margin-bottom: 1rem;
            border-bottom: 2px solid rgba(25,167,123,0.1);
        }

        .card-header h4 {
            font-size: 1.3rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin: 0;
        }

        /* Job Details Grid */
        .job-details {
            margin-bottom: 0.75rem;
        }

        .field {
            font-size: 0.85rem;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }

        .field i {
            color: var(--primary);
            width: 24px;
            font-size: 0.9rem;
        }

        .field strong {
            color: var(--bg-dark);
        }

        /* Button Group */
        .btn-group {
            display: flex;
            gap: 0.75rem;
            margin-top: 1rem;
            flex-wrap: wrap;
        }

        .btn-edit, .btn-delete {
            padding: 0.6rem 1.2rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.8rem;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            border: none;
        }

        .btn-edit {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
        }

        .btn-edit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(105deg, #ef4444, #dc2626);
            color: white;
            box-shadow: 0 4px 12px rgba(239,68,68,0.3);
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(239,68,68,0.4);
            color: white;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
        }

        .empty-state i {
            font-size: 4rem;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--bg-dark);
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            color: var(--text-muted);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .call-action h2 { font-size: 1.5rem; }
            .container { padding: 0 1rem 2rem; }
            .job-card { padding: 1.25rem; }
            .card-header h4 { font-size: 1.1rem; }
            .field { font-size: 0.75rem; }
            .btn-group { flex-direction: column; }
            .btn-edit, .btn-delete { width: 100%; justify-content: center; }
            .badge-status { top: 1rem; right: 1rem; }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }

        ::selection { background: var(--primary); color: white; }
    
/* ========== PAGE HEADER ========== */
        .page-header {
            background: var(--gradient);
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

<style>
:root {
    --white: #ffffff;
    --border: #e2e8f0;
    --radius: 24px;
    --gradient: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
    --gradient-dark: linear-gradient(135deg, #1e2f32 0%, #2E3E41 100%);
    --primary-glow: rgba(25,167,123,0.15);
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
        <a href="${pageContext.request.contextPath}/recruiter/posted-jobs" class="back-btn" data-aos="fade-right">
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
                <p><strong>Want to know how your questions are used?</strong><br>After uploading, these questions will be sent to job seekers as an assessment test. <a href="${pageContext.request.contextPath}/recruiter/assessments/info" style="color: var(--primary); font-weight: 600;">Learn more about the assessment process →</a></p>
            </div>

            <!-- Upload Form -->
            <form action="${pageContext.request.contextPath}/recruiter/assessments/upload" method="post" enctype="multipart/form-data" id="uploadForm">
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

    
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Job Filtering Logic
    const filterButtons = document.querySelectorAll('#jobFilterTab .nav-link');
    const jobCards = document.querySelectorAll('.job-card');
    const initialFilter = document.getElementById('initialFilter').value;

    function applyFilter(filter) {
        jobCards.forEach(card => {
            const type = card.getAttribute('data-type');
            if (filter === 'all' || type === filter || (filter === 'JOB' && type === 'job') || (filter === 'INTERNSHIP' && type === 'internship')) {
                card.style.display = '';
            } else {
                card.style.display = 'none';
            }
        });
    }

    filterButtons.forEach(button => {
        button.addEventListener('click', () => {
            filterButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            applyFilter(button.getAttribute('data-filter'));
        });
    });

    // Handle initial server-side filter
    if (initialFilter) {
        applyFilter(initialFilter);
    }

    if (!document.getElementById('mobile-responsive-style')) {
        const style = document.createElement('style');
        style.id = 'mobile-responsive-style';
        style.innerHTML = `@media (max-width: 768px) { .sidebar, .nav-sidebar { transform: translateX(-100%); transition: transform 0.3s ease; position: fixed !important; z-index: 1001 !important; height: 100vh; } .sidebar.active, .nav-sidebar.active { transform: translateX(0); box-shadow: 2px 0 20px rgba(0,0,0,0.2) !important; } .main-content { margin-left: 0 !important; padding: 16px !important; width: 100% !important; max-width: 100% !important; } } .mobile-menu-btn { display: none; }`;
        document.head.appendChild(style);
    }
    
    const sidebar = document.querySelector('.sidebar') || document.querySelector('.nav-sidebar');
    if (sidebar) {
        const topBar = document.querySelector('.top-bar') || document.querySelector('.chat-header') || document.querySelector('.dashboard-header') || document.body;
        let heading = null;
        if (topBar && topBar !== document.body) heading = topBar.querySelector('h1') || topBar.querySelector('.chat-header-info') || topBar.querySelector('h2');
        if (!heading && !document.querySelector('.mobile-menu-btn')) { heading = document.createElement('div'); heading.style.padding = '10px'; document.body.insertBefore(heading, document.body.firstChild); }
        if (heading && !document.querySelector('.mobile-menu-btn')) {
            heading.style.display = 'flex'; heading.style.alignItems = 'center';
            const toggleBtn = document.createElement('button'); toggleBtn.className = 'mobile-menu-btn'; toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
            heading.insertBefore(toggleBtn, heading.firstChild);
            const overlay = document.createElement('div'); overlay.className = 'mobile-overlay'; document.body.appendChild(overlay);
            let touchstartX = 0, touchendX = 0;
            document.body.addEventListener('touchstart', e => { touchstartX = e.changedTouches[0].screenX; }, {passive: true});
            document.body.addEventListener('touchend', e => { touchendX = e.changedTouches[0].screenX; if (touchendX < touchstartX - 50) closeSidebar(); if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); }, {passive: true});
            function openSidebar() { sidebar.classList.add('active'); overlay.classList.add('active'); document.body.style.overflow = 'hidden'; }
            function closeSidebar() { sidebar.classList.remove('active'); overlay.classList.remove('active'); document.body.style.overflow = ''; }
            toggleBtn.addEventListener('click', openSidebar); overlay.addEventListener('click', closeSidebar);
        }
    }
    
    const tables = document.querySelectorAll('table:not(.table-responsive)');
    tables.forEach(table => {
        const headers = Array.from(table.querySelectorAll('th')).map(th => th.innerText);
        const rows = Array.from(table.querySelectorAll('tbody tr'));
        rows.forEach(row => { Array.from(row.querySelectorAll('td')).forEach((td, index) => { if(headers[index]) td.setAttribute('data-label', headers[index]); }); });
    });
});
</script>

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






