<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${job.title} - SmartInterview Jobs</title>
    <meta name="description" content="${job.title} at ${job.companyName}. ${job.location}. Apply now on SmartInterview.">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #ffffff;
            --text-secondary: rgba(255, 255, 255, 0.85);
            --text-tertiary: rgba(255, 255, 255, 0.5);
            --border-color: rgba(255, 255, 255, 0.08);
            --card-bg: rgba(46, 62, 65, 0.6);
            --hover-bg: rgba(25, 167, 123, 0.15);
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --gradient-dark: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-darker) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.15);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.2);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.3);
            --glow-primary: 0 0 30px rgba(25, 167, 123, 0.2);
            --success: #19A77B;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
            --purple: #8b5cf6;
            --orange: #f97316;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Inter', sans-serif;
            background: var(--gradient-dark);
            color: var(--text-primary);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
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
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(25, 167, 123, 0.05) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: backgroundPulse 15s ease-in-out infinite;
        }

        @keyframes backgroundPulse {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }

        .sidebar {
            position: fixed; left: 0; top: 0; width: 280px; height: 100vh;
            background: rgba(26, 42, 44, 0.95);
            backdrop-filter: blur(20px); border-right: 1px solid var(--border-color);
            padding: 24px 16px; z-index: 100; overflow-y: auto;
            box-shadow: var(--shadow-lg);
        }
        
        .sidebar::-webkit-scrollbar { width: 6px; }
        .sidebar::-webkit-scrollbar-track { background: transparent; }
        .sidebar::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 3px; }

        .sidebar-logo {
            display: flex; align-items: center; gap: 14px;
            padding: 8px 12px 24px; border-bottom: 1px solid var(--border-color); margin-bottom: 24px;
        }
        .sidebar-logo .icon {
            width: 48px; height: 48px;
            background: var(--gradient-primary);
            border-radius: 14px; display: flex; align-items: center; justify-content: center;
            box-shadow: var(--glow-primary);
            animation: logoGlow 3s ease-in-out infinite;
        }
        
        @keyframes logoGlow {
            0%, 100% { box-shadow: 0 0 20px rgba(25, 167, 123, 0.3); }
            50% { box-shadow: 0 0 30px rgba(25, 167, 123, 0.5); }
        }
        
        .sidebar-logo .icon i { color: #fff; font-size: 24px; }
        .sidebar-logo h2 { 
            font-size: 20px; font-weight: 700; 
            background: linear-gradient(135deg, #fff, var(--accent));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-section { margin-bottom: 28px; }
        .nav-section h4 { 
            color: var(--text-tertiary); font-size: 11px; text-transform: uppercase; 
            letter-spacing: 1.5px; padding: 0 12px; margin-bottom: 14px; font-weight: 600;
        }
        .nav-link {
            display: flex; align-items: center; gap: 14px; padding: 12px 14px;
            border-radius: 12px; color: var(--text-secondary); text-decoration: none;
            font-size: 14px; font-weight: 500; transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); 
            margin-bottom: 4px; position: relative; overflow: hidden;
        }
        .nav-link i { width: 20px; text-align: center; font-size: 16px; transition: transform 0.3s ease; }
        
        .nav-link::before {
            content: ''; position: absolute; left: 0; top: 0; bottom: 0; width: 3px;
            background: var(--gradient-primary); transform: translateX(-100%);
            transition: transform 0.3s ease;
        }
        .nav-link:hover { 
            background: var(--hover-bg); 
            color: var(--primary); 
            transform: translateX(4px); 
        }
        .nav-link:hover i { transform: scale(1.1); }
        .nav-link:hover::before { transform: translateX(0); }
        .nav-link.active { 
            background: var(--hover-bg); color: var(--primary);
            box-shadow: inset 0 0 20px rgba(25, 167, 123, 0.1);
        }
        .nav-link.active::before { transform: translateX(0); }

        .main-content { 
            margin-left: 280px; padding: 28px 36px; max-width: 1100px; 
            position: relative; z-index: 1;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .back-link {
            display: inline-flex; align-items: center; gap: 10px;
            color: var(--accent); text-decoration: none; font-size: 14px; font-weight: 500;
            margin-bottom: 24px; transition: all 0.3s ease;
            padding: 8px 18px; border-radius: 30px;
            background: var(--hover-bg); border: 1px solid rgba(25, 167, 123, 0.2);
        }
        .back-link:hover { 
            background: var(--primary); color: white; 
            transform: translateX(-6px); box-shadow: var(--glow-primary); 
        }

        .alert { 
            padding: 16px 20px; border-radius: 16px; margin-bottom: 20px; 
            font-size: 14px; display: flex; align-items: center; gap: 12px; 
            backdrop-filter: blur(10px); animation: slideDown 0.4s ease-out;
        }
        @keyframes slideDown { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
        .alert-success { background: rgba(25, 167, 123, 0.1); border: 1px solid rgba(25, 167, 123, 0.3); color: #3BC49A; }
        .alert-error { background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.3); color: #fca5a5; }

        .job-detail-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px); border: 1px solid var(--border-color);
            border-radius: 28px; padding: 40px;
            box-shadow: var(--shadow-lg);
            position: relative; overflow: hidden;
            animation: cardAppear 0.5s ease-out;
        }
        
        @keyframes cardAppear { from { opacity: 0; transform: scale(0.98); } to { opacity: 1; transform: scale(1); } }

        .job-detail-card::before {
            content: ''; position: absolute; top: 0; left: 0;
            width: 100%; height: 4px;
            background: var(--gradient-primary);
            transform: translateX(-100%);
            transition: transform 0.8s ease;
        }
        .job-detail-card:hover::before { transform: translateX(0); }

        .job-detail-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 32px; flex-wrap: wrap; gap: 20px; }
        .job-detail-header h1 {
            font-size: 34px; font-weight: 800; 
            background: linear-gradient(135deg, #fff, var(--accent));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            background-clip: text; margin-bottom: 10px;
        }
        .company-name {
            display: flex; align-items: center; gap: 10px;
            font-size: 16px; color: var(--accent); font-weight: 600;
        }
        .company-icon {
            width: 52px; height: 52px; border-radius: 16px;
            background: var(--gradient-primary);
            display: flex; align-items: center; justify-content: center;
            color: #fff; font-size: 22px; font-weight: 700;
            box-shadow: var(--glow-primary);
        }
        .job-type-badge {
            padding: 8px 20px; border-radius: 30px;
            font-size: 13px; font-weight: 600; text-transform: uppercase;
            backdrop-filter: blur(10px);
        }
        .badge-fulltime { background: rgba(25, 167, 123, 0.15); color: #3BC49A; border: 1px solid rgba(25, 167, 123, 0.3); }
        .badge-remote { background: rgba(25, 167, 123, 0.15); color: var(--accent); border: 1px solid rgba(25, 167, 123, 0.3); }
        .badge-internship { background: rgba(245, 158, 11, 0.15); color: #fbbf24; border: 1px solid rgba(245, 158, 11, 0.3); }
        .badge-parttime { background: rgba(139, 92, 246, 0.15); color: #c084fc; border: 1px solid rgba(139, 92, 246, 0.3); }
        .badge-contract { background: rgba(236, 72, 153, 0.15); color: #f472b6; border: 1px solid rgba(236, 72, 153, 0.3); }

        .job-meta-grid {
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 18px; margin-bottom: 36px;
        }
        .meta-item {
            background: rgba(26, 42, 44, 0.5); border: 1px solid var(--border-color);
            border-radius: 16px; padding: 22px; text-align: center;
            transition: all 0.3s ease; backdrop-filter: blur(10px);
        }
        .meta-item:hover { 
            border-color: var(--primary); transform: translateY(-4px); 
            box-shadow: var(--glow-primary); 
        }
        .meta-item i { font-size: 24px; margin-bottom: 10px; display: block; }
        .meta-item i.red { color: #f87171; }
        .meta-item i.green { color: var(--success); }
        .meta-item i.blue { color: var(--info); }
        .meta-item i.purple { color: var(--purple); }
        .meta-item .label { 
            font-size: 11px; color: var(--text-tertiary); text-transform: uppercase; 
            letter-spacing: 1px; margin-bottom: 6px; 
        }
        .meta-item .value { font-size: 16px; font-weight: 700; color: var(--text-primary); }

        .section-title {
            font-size: 20px; font-weight: 700; color: var(--text-primary); margin-bottom: 18px;
            display: flex; align-items: center; gap: 12px;
        }
        .section-title i { color: var(--primary); }

        .description-box {
            background: rgba(26, 42, 44, 0.4); border: 1px solid var(--border-color);
            border-radius: 16px; padding: 28px; margin-bottom: 32px;
            font-size: 15px; line-height: 1.8; color: var(--text-secondary);
            backdrop-filter: blur(10px);
        }

        .skills-section { margin-bottom: 32px; }
        .skills-grid { display: flex; flex-wrap: wrap; gap: 12px; }
        .skill-chip {
            padding: 10px 20px; border-radius: 30px;
            background: var(--hover-bg); border: 1px solid var(--primary);
            color: var(--primary); font-size: 13px; font-weight: 600;
            transition: all 0.3s ease; backdrop-filter: blur(10px);
        }
        .skill-chip:hover { 
            background: var(--primary); color: #fff; 
            transform: translateY(-2px); box-shadow: var(--glow-primary); 
        }

        .apply-section {
            background: linear-gradient(135deg, rgba(25, 167, 123, 0.08), rgba(59, 196, 154, 0.08));
            border: 1px solid rgba(25, 167, 123, 0.2);
            border-radius: 20px; padding: 36px; text-align: center;
            backdrop-filter: blur(10px);
        }
        .apply-section h3 { font-size: 22px; font-weight: 700; color: var(--text-primary); margin-bottom: 10px; }
        .apply-section p { font-size: 14px; color: var(--text-tertiary); margin-bottom: 24px; }

        .btn-apply-lg {
            padding: 16px 44px; background: var(--gradient-primary);
            color: #fff; border: none; border-radius: 16px; font-size: 16px;
            font-weight: 700; cursor: pointer; transition: all 0.3s ease;
            display: inline-flex; align-items: center; gap: 12px;
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.3);
        }
        .btn-apply-lg:hover { 
            transform: translateY(-3px); 
            box-shadow: 0 10px 30px rgba(25, 167, 123, 0.4); 
        }

        .applied-badge {
            display: inline-flex; align-items: center; gap: 12px;
            padding: 16px 44px; background: rgba(25, 167, 123, 0.15);
            border: 2px solid rgba(25, 167, 123, 0.3); color: #3BC49A;
            border-radius: 16px; font-size: 16px; font-weight: 700;
        }

        /* Apply Form */
        .apply-form { text-align: left; max-width: 520px; margin: 0 auto; }
        .apply-form label { 
            display: block; font-size: 13px; color: var(--text-secondary); 
            margin-bottom: 8px; font-weight: 500; 
        }
        .file-upload-area {
            width: 100%; padding: 28px; border: 2px dashed rgba(25, 167, 123, 0.3);
            border-radius: 16px; text-align: center; cursor: pointer; margin-bottom: 20px;
            transition: all 0.3s ease; background: rgba(25, 167, 123, 0.05);
        }
        .file-upload-area:hover { border-color: var(--primary); background: var(--hover-bg); }
        .file-upload-area i { font-size: 36px; color: var(--primary); margin-bottom: 10px; display: block; }
        .file-upload-area span { color: var(--text-tertiary); font-size: 13px; }
        .apply-form textarea {
            width: 100%; background: rgba(26, 42, 44, 0.5);
            border: 1px solid var(--border-color); border-radius: 14px;
            padding: 14px 18px; color: var(--text-primary); font-size: 14px;
            font-family: 'Inter', sans-serif; resize: vertical; min-height: 110px; margin-bottom: 24px;
            outline: none; transition: all 0.3s ease;
        }
        .apply-form textarea:focus { border-color: var(--primary); box-shadow: var(--glow-primary); }
        .apply-form textarea::placeholder { color: var(--text-tertiary); }

        /* Mobile Responsive */
        @media (max-width: 1024px) {
            .job-meta-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media (max-width: 768px) {
            .sidebar { transform: translateX(-100%); transition: transform 0.3s ease; }
            .sidebar.active { transform: translateX(0); }
            .main-content { margin-left: 0 !important; padding: 20px !important; }
            .job-meta-grid { grid-template-columns: 1fr; }
            .job-detail-card { padding: 24px; }
            .job-detail-header h1 { font-size: 26px; }
        }
    </style>
	<jsp:include page="/views/commons/hackerrank_sidebar_styles.jsp" />
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-logo">
            <div class="icon"><i class="fas fa-brain"></i></div>
            <h2>SmartInterview</h2>
        </div>
        <div class="nav-section">
            <h4>Jobs</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/jobs" class="nav-link active">
                <i class="fas fa-briefcase"></i> Job Listings
            </a>
            <c:if test="${user.role == 'STUDENT'}">
                <a href="${pageContext.request.contextPath}/hackerrank/my-applications" class="nav-link">
                    <i class="fas fa-file-alt"></i> My Applications
                </a>
            </c:if>
        </div>
        <div class="nav-section">
            <h4>Main</h4>
            <c:if test="${user.role == 'STUDENT'}">
                <a href="${pageContext.request.contextPath}/hackerrank/student/dashboard" class="nav-link">
                    <i class="fas fa-th-large"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/hackerrank/student/coding-practice" class="nav-link">
                    <i class="fas fa-code"></i> Coding Practice
                </a>
            </c:if>
            <c:if test="${user.role == 'COMPANY'}">
                <a href="${pageContext.request.contextPath}/hackerrank/company/dashboard" class="nav-link">
                    <i class="fas fa-building"></i> Company Dashboard
                </a>
            </c:if>
        </div>
        <div class="nav-section">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/logout" class="nav-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>

    <div class="main-content">
        <a href="${pageContext.request.contextPath}/hackerrank/jobs" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Job Listings
        </a>

        <c:if test="${not empty success}">
            <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${error}</div>
        </c:if>

        <div class="job-detail-card">
            <div class="job-detail-header">
                <div style="display: flex; gap: 20px; align-items: flex-start;">
                    <div class="company-icon">${job.companyName.substring(0,1)}</div>
                    <div>
                        <h1>${job.title}</h1>
                        <div class="company-name"><i class="fas fa-building"></i> ${job.companyName}</div>
                    </div>
                </div>
                <c:choose>
                    <c:when test="${job.jobType == 'FULL_TIME'}"><span class="job-type-badge badge-fulltime"><i class="fas fa-briefcase"></i> Full Time</span></c:when>
                    <c:when test="${job.jobType == 'REMOTE'}"><span class="job-type-badge badge-remote"><i class="fas fa-globe"></i> Remote</span></c:when>
                    <c:when test="${job.jobType == 'INTERNSHIP'}"><span class="job-type-badge badge-internship"><i class="fas fa-graduation-cap"></i> Internship</span></c:when>
                    <c:when test="${job.jobType == 'PART_TIME'}"><span class="job-type-badge badge-parttime"><i class="fas fa-clock"></i> Part Time</span></c:when>
                    <c:when test="${job.jobType == 'CONTRACT'}"><span class="job-type-badge badge-contract"><i class="fas fa-file-contract"></i> Contract</span></c:when>
                </c:choose>
            </div>

            <div class="job-meta-grid">
                <div class="meta-item">
                    <i class="fas fa-map-marker-alt red"></i>
                    <div class="label">Location</div>
                    <div class="value">${job.location}</div>
                </div>
                <div class="meta-item">
                    <i class="fas fa-money-bill-wave green"></i>
                    <div class="label">Salary</div>
                    <div class="value">${job.salary}</div>
                </div>
                <div class="meta-item">
                    <i class="fas fa-layer-group blue"></i>
                    <div class="label">Experience</div>
                    <div class="value">${job.experienceLevel}</div>
                </div>
                <div class="meta-item">
                    <i class="fas fa-users purple"></i>
                    <div class="label">Applicants</div>
                    <div class="value">${job.applicantCount}</div>
                </div>
            </div>

            <h3 class="section-title"><i class="fas fa-file-alt"></i> Job Description</h3>
            <div class="description-box">${job.description}</div>

            <div class="skills-section">
                <h3 class="section-title"><i class="fas fa-tools"></i> Required Skills</h3>
                <div class="skills-grid">
                    <c:forEach var="skill" items="${job.skills.split(',')}">
                        <span class="skill-chip">${skill.trim()}</span>
                    </c:forEach>
                </div>
            </div>

            <c:if test="${user.role == 'STUDENT'}">
                <div class="apply-section">
                    <c:choose>
                        <c:when test="${hasApplied}">
                            <div class="applied-badge">
                                <i class="fas fa-check-circle"></i> You've already applied for this position
                            </div>
                        </c:when>
                        <c:otherwise>
                            <h3>Ready to Apply?</h3>
                            <p>Submit your application and let your skills speak for themselves. Your resume will be scored against this job's requirements.</p>
                            <form action="${pageContext.request.contextPath}/jobs/apply" method="post" enctype="multipart/form-data" class="apply-form" id="applyForm">
                                <input type="hidden" name="jobId" value="${job.id}">
                                <label><i class="fas fa-cloud-upload-alt"></i> Upload Resume (PDF) — optional if already uploaded</label>
                                <div class="file-upload-area" onclick="document.getElementById('resumeFile').click()">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                    <span id="fileLabel">Click to upload your resume (PDF)</span>
                                    <input type="file" name="resume" id="resumeFile" accept=".pdf" style="display:none;" onchange="document.getElementById('fileLabel').textContent = this.files[0] ? this.files[0].name : 'Click to upload your resume (PDF)'">
                                </div>
                                <label><i class="fas fa-envelope"></i> Cover Letter (optional)</label>
                                <textarea name="coverLetter" placeholder="Tell the company why you're a great fit..."></textarea>
                                <div style="text-align: center;">
                                    <button type="submit" class="btn-apply-lg" id="submitBtn">
                                        <i class="fas fa-paper-plane"></i> Submit Application
                                    </button>
                                </div>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Form submission with loading state
            const form = document.getElementById('applyForm');
            const submitBtn = document.getElementById('submitBtn');
            
            if (form && submitBtn) {
                form.addEventListener('submit', function() {
                    submitBtn.innerHTML = '<span class="loading-spinner"></span> Submitting...';
                    submitBtn.disabled = true;
                });
            }

            // Keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                // Escape to go back
                if (e.key === 'Escape') {
                    const backLink = document.querySelector('.back-link');
                    if (backLink) {
                        window.location.href = backLink.href;
                    }
                }
            });

            // Mobile responsive menu
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
                        .mobile-overlay.active { display: block; }
                    }
                    .mobile-menu-btn { display: none; }
                    .loading-spinner {
                        display: inline-block;
                        width: 18px;
                        height: 18px;
                        border: 2px solid rgba(255,255,255,0.3);
                        border-top-color: #fff;
                        border-radius: 50%;
                        animation: spin 0.6s linear infinite;
                    }
                    @keyframes spin { to { transform: rotate(360deg); } }
                `;
                document.head.appendChild(style);
            }

            const sidebar = document.querySelector('.sidebar');
            if (sidebar) {
                const topBar = document.querySelector('.top-bar') || document.querySelector('.chat-header') || document.body;
                let heading = topBar.querySelector('h1') || topBar.querySelector('h2');
                if (!heading) heading = topBar;
                
                if (heading && !document.querySelector('.mobile-menu-btn')) {
                    heading.style.display = 'flex';
                    heading.style.alignItems = 'center';

                    const toggleBtn = document.createElement('button');
                    toggleBtn.className = 'mobile-menu-btn';
                    toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
                    heading.insertBefore(toggleBtn, heading.firstChild);
                    
                    const overlay = document.createElement('div');
                    overlay.className = 'mobile-overlay';
                    document.body.appendChild(overlay);

                    toggleBtn.addEventListener('click', () => {
                        sidebar.classList.add('active');
                        overlay.classList.add('active');
                        document.body.style.overflow = 'hidden';
                    });
                    
                    overlay.addEventListener('click', () => {
                        sidebar.classList.remove('active');
                        overlay.classList.remove('active');
                        document.body.style.overflow = '';
                    });
                }
            }
        });
    </script>
</body>
</html>