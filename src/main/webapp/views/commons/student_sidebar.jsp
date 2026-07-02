<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<style>
/* Student Sidebar Premium - Green SmartInterview Theme (Bulletproof Overrides) */
.career-sidebar, .nav-sidebar, .sidebar {
    background: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%) !important;
    width: 280px !important;
    height: 100vh !important;
    position: fixed !important;
    left: 0 !important;
    top: 0 !important;
    z-index: 1000 !important;
    padding: 24px 16px !important;
    box-shadow: 0 16px 40px rgba(0, 0, 0, 0.08) !important;
    transition: transform 0.3s ease !important;
    backdrop-filter: blur(10px) !important;
    overflow-y: auto !important;
    border-right: none !important;
}

/* Custom scrollbar - premium */
.career-sidebar::-webkit-scrollbar,
.nav-sidebar::-webkit-scrollbar,
.sidebar::-webkit-scrollbar {
    width: 5px !important;
}
.career-sidebar::-webkit-scrollbar-track,
.nav-sidebar::-webkit-scrollbar-track,
.sidebar::-webkit-scrollbar-track {
    background: rgba(255, 255, 255, 0.08) !important;
    border-radius: 10px !important;
}
.career-sidebar::-webkit-scrollbar-thumb,
.nav-sidebar::-webkit-scrollbar-thumb,
.sidebar::-webkit-scrollbar-thumb {
    background: #ffffff !important;
    border-radius: 10px !important;
}

/* Sidebar Logo Section */
.sidebar-logo {
    display: flex !important;
    align-items: center !important;
    gap: 14px !important;
    padding: 8px 12px 24px !important;
    border-bottom: 1px solid rgba(255, 255, 255, 0.15) !important;
    margin-bottom: 24px !important;
    justify-content: flex-start !important;
    background: transparent !important;
    border-radius: 0 !important;
    box-shadow: none !important;
}

.sidebar-logo .icon {
    width: 48px !important;
    height: 48px !important;
    background: #ffffff !important;
    border-radius: 14px !important;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    box-shadow: 0 4px 12px rgba(25, 167, 123, 0.2) !important;
    flex-shrink: 0 !important;
}

.sidebar-logo .icon i {
    color: #19A77B !important;
    font-size: 24px !important;
}

.sidebar-logo h2 {
    color: white !important;
    font-weight: 700 !important;
    font-size: 1.2rem !important;
    line-height: 1.2 !important;
    margin: 0 !important;
    background: none !important;
    -webkit-text-fill-color: white !important;
}

/* Navigation Section - Header styling */
.nav-section {
    margin-bottom: 24px !important;
}

.nav-section h4 {
    color: rgba(255, 255, 255, 0.65) !important;
    font-size: 11px !important;
    text-transform: uppercase !important;
    letter-spacing: 1.5px !important;
    padding: 0 12px !important;
    margin-bottom: 12px !important;
    font-weight: 600 !important;
}

/* Sidebar Link item - Premium styling */
.nav-link-custom {
    display: flex !important;
    align-items: center !important;
    gap: 14px !important;
    padding: 10px 16px !important;
    color: #ffffff !important;
    text-decoration: none !important;
    font-weight: 500 !important;
    font-size: 0.9rem !important;
    transition: all 0.3s ease !important;
    border-left: 3px solid transparent !important;
    margin-bottom: 6px !important;
    border-radius: 0 12px 12px 0 !important;
}

.nav-link-custom i {
    width: 20px !important;
    text-align: center !important;
    font-size: 16px !important;
    color: #ffffff !important;
}

.nav-link-custom:hover {
    background: rgba(255, 255, 255, 0.15) !important;
    border-left-color: #ffffff !important;
    transform: translateX(4px) !important;
    color: #ffffff !important;
}

.nav-link-custom.active {
    background: rgba(255, 255, 255, 0.2) !important;
    color: #ffffff !important;
    border-left-color: #ffffff !important;
    font-weight: 600 !important;
    border-radius: 0 12px 12px 0 !important;
    box-shadow: inset 0 0 20px rgba(255, 255, 255, 0.1) !important;
}

/* Mobile Toggle and Overlay overrides */
.sidebar-toggle-btn {
    background: #19A77B !important;
    color: white !important;
    border: none !important;
    padding: 12px 18px !important;
    border-radius: 12px !important;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08) !important;
}

@media (max-width: 768px) {
    .career-sidebar, .nav-sidebar, .sidebar {
        transform: translateX(-100%) !important;
        border-radius: 0 !important;
    }
    .career-sidebar.active, .nav-sidebar.active, .sidebar.active {
        transform: translateX(0) !important;
        border-radius: 0 20px 20px 0 !important;
    }
}
</style>

<!-- Left Sidebar Navigation - Ultra Premium -->
<div class="career-sidebar" id="sidebar">
    <div class="sidebar-logo">
        <div class="icon"><i class="fas fa-brain"></i></div>
        <h2>SmartInterview</h2>
    </div>
    
    <div class="nav-section">
        <h4>Main</h4>
        <a href="${pageContext.request.contextPath}/userdashboard.html" class="nav-link-custom">
            <i class="fas fa-home"></i> Back to Home
        </a>
        <a href="${pageContext.request.contextPath}/hackerrank/student/dashboard" class="nav-link-custom">
            <i class="fas fa-th-large"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/jobSeekers/profile" class="nav-link-custom">
            <i class="fas fa-user"></i> Profile
        </a>
        <a href="${pageContext.request.contextPath}/hackerrank/student/coding-practice" class="nav-link-custom">
            <i class="fas fa-code"></i> Coding Practice
        </a>
        <a href="${pageContext.request.contextPath}/hackerrank/student/mock-interview" class="nav-link-custom">
            <i class="fas fa-video"></i> Mock Interview
        </a>
    </div>
    
    <div class="nav-section">
        <h4>Jobs</h4>
        <a href="${pageContext.request.contextPath}/company/Alllist" class="nav-link-custom">
            <i class="fas fa-building"></i> Companies
        </a>
        <a href="${pageContext.request.contextPath}/hackerrank/jobs" class="nav-link-custom">
            <i class="fas fa-briefcase"></i> Job Listings
        </a>
        <a href="${pageContext.request.contextPath}/seeker/saved-jobs" class="nav-link-custom">
            <i class="fas fa-bookmark"></i> Saved Jobs
        </a>
        <a href="${pageContext.request.contextPath}/seeker/reported-jobs" class="nav-link-custom">
            <i class="fas fa-flag"></i> Reported Jobs
        </a>
        <a href="${pageContext.request.contextPath}/hackerrank/my-applications" class="nav-link-custom">
            <i class="fas fa-file-alt"></i> My Applications
        </a>
        <a href="${pageContext.request.contextPath}/applications/track" class="nav-link-custom">
            <i class="fas fa-tasks"></i> Track Applications
        </a>
    </div>
    
    <div class="nav-section">
        <h4>Tools</h4>
        <a href="${pageContext.request.contextPath}/assessment/available-badges" class="nav-link-custom">
            <i class="fas fa-trophy"></i> Achievements
        </a>
        <a href="${pageContext.request.contextPath}/hackerrank/chat" class="nav-link-custom">
            <i class="fas fa-comments"></i> Messages
        </a>
        <a href="${pageContext.request.contextPath}/hackerrank/student/upload-resume" class="nav-link-custom">
            <i class="fas fa-file-upload"></i> Upload Resume
        </a>
        <a href="${pageContext.request.contextPath}/jobseeker/videos" class="nav-link-custom">
            <i class="fas fa-video"></i> Upload Video Resume
        </a>
        <a href="${pageContext.request.contextPath}/hackerrank/student/performance" class="nav-link-custom">
            <i class="fas fa-chart-line"></i> Performance
        </a>
        <a href="${pageContext.request.contextPath}/qna" class="nav-link-custom">
            <i class="fas fa-question-circle"></i> Ask Your Question
        </a>
        <a href="${pageContext.request.contextPath}/hackerrank/ai-evaluation/dashboard" class="nav-link-custom">
            <i class="fas fa-robot"></i> AI Feedback
        </a>
    </div>
    
    <div class="nav-section">
        <h4>Account</h4>
        <a href="${pageContext.request.contextPath}/hackerrank/logout" class="nav-link-custom">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>

<script>
(function() {
    function highlightActiveLink() {
        const path = window.location.pathname;
        const origin = window.location.origin;
        
        // Remove active class from all links
        const navLinks = document.querySelectorAll('.career-sidebar a');
        navLinks.forEach(link => link.classList.remove('active'));
        
        let matched = false;
        
        // 1. Check custom path-based matches
        if (path.includes('/student/dashboard')) {
            const compLink = document.querySelector('.career-sidebar a[href*="/student/dashboard"]');
            if (compLink) { compLink.classList.add('active'); matched = true; }
        } else if (path.includes('/jobSeekers/profile') || path.includes('/jobSeekers/update')) {
            const profileLink = document.querySelector('.career-sidebar a[href*="/jobSeekers/profile"]');
            if (profileLink) { profileLink.classList.add('active'); matched = true; }
        } else if (path.includes('/student/coding-practice') || path.includes('/student/coding-question')) {
            const practiceLink = document.querySelector('.career-sidebar a[href*="/student/coding-practice"]');
            if (practiceLink) { practiceLink.classList.add('active'); matched = true; }
        } else if (path.includes('/student/mock-interview')) {
            const mockLink = document.querySelector('.career-sidebar a[href*="/student/mock-interview"]');
            if (mockLink) { mockLink.classList.add('active'); matched = true; }
        } else if (path.includes('/company/')) {
            const compLink = document.querySelector('.career-sidebar a[href*="/company/Alllist"]');
            if (compLink) { compLink.classList.add('active'); matched = true; }
        } else if (path.includes('/hackerrank/jobs') || path.includes('/hackerrank/job/details')) {
            const jobsLink = document.querySelector('.career-sidebar a[href*="/hackerrank/jobs"]');
            if (jobsLink) { jobsLink.classList.add('active'); matched = true; }
        } else if (path.includes('/seeker/saved-jobs')) {
            const savedLink = document.querySelector('.career-sidebar a[href*="/seeker/saved-jobs"]');
            if (savedLink) { savedLink.classList.add('active'); matched = true; }
        } else if (path.includes('/my-applications')) {
            const appLink = document.querySelector('.career-sidebar a[href*="/my-applications"]');
            if (appLink) { appLink.classList.add('active'); matched = true; }
        } else if (path.includes('/applications/track')) {
            const trackLink = document.querySelector('.career-sidebar a[href*="/applications/track"]');
            if (trackLink) { trackLink.classList.add('active'); matched = true; }
        } else if (path.includes('/available-badges')) {
            const badgeLink = document.querySelector('.career-sidebar a[href*="/available-badges"]');
            if (badgeLink) { badgeLink.classList.add('active'); matched = true; }
        } else if (path.includes('/hackerrank/chat')) {
            const chatLink = document.querySelector('.career-sidebar a[href*="/hackerrank/chat"]');
            if (chatLink) { chatLink.classList.add('active'); matched = true; }
        } else if (path.includes('/student/upload-resume')) {
            const uploadLink = document.querySelector('.career-sidebar a[href*="/student/upload-resume"]');
            if (uploadLink) { uploadLink.classList.add('active'); matched = true; }
        } else if (path.includes('/jobseeker/videos')) {
            const videoLink = document.querySelector('.career-sidebar a[href*="/jobseeker/videos"]');
            if (videoLink) { videoLink.classList.add('active'); matched = true; }
        } else if (path.includes('/student/performance')) {
            const perfLink = document.querySelector('.career-sidebar a[href*="/student/performance"]');
            if (perfLink) { perfLink.classList.add('active'); matched = true; }
        } else if (path.includes('/qna')) {
            const qnaLink = document.querySelector('.career-sidebar a[href*="/qna"]');
            if (qnaLink) { qnaLink.classList.add('active'); matched = true; }
        } else if (path.includes('/ai-evaluation/')) {
            const aiLink = document.querySelector('.career-sidebar a[href*="/ai-evaluation/dashboard"]');
            if (aiLink) { aiLink.classList.add('active'); matched = true; }
        } else if (path.includes('/jobs/all') || path.includes('/jobs/search')) {
            const jobsLink = document.querySelector('.career-sidebar a[href*="/hackerrank/jobs"]');
            if (jobsLink) { jobsLink.classList.add('active'); matched = true; }
        } else if (path.includes('/notifications')) {
            // No specific sidebar link for notifications — fallback will handle it
        } else if (path.includes('/assessment/my-invites') || path.includes('/assessment/take') || path.includes('/assessment/result')) {
            // No specific sidebar link for assessments — fallback will handle it
        } else if (path.includes('/seeker/reported-jobs')) {
            const reportLink = document.querySelector('.career-sidebar a[href*="/seeker/reported-jobs"]');
            if (reportLink) { reportLink.classList.add('active'); matched = true; }
        } else if (path === '/' || path.includes('/userdashboard')) {
            const homeLink = document.querySelector('.career-sidebar a[href*="/userdashboard"]');
            if (homeLink) { homeLink.classList.add('active'); matched = true; }
        }
        
        // 2. Fallback to exact path mapping if no custom match was found
        if (!matched) {
            navLinks.forEach(link => {
                try {
                    const linkPath = new URL(link.href, origin).pathname;
                    if (path === linkPath) {
                        link.classList.add('active');
                        matched = true;
                    }
                } catch(e) {}
            });
        }
    }
    
    // Execute immediately and on DOMContentLoaded/load
    highlightActiveLink();
    document.addEventListener("DOMContentLoaded", highlightActiveLink);
    window.addEventListener("load", highlightActiveLink);
})();
</script>
