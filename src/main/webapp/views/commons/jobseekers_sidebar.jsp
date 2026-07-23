<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<style>
/* Sidebar — match Admin Dashboard (dark #2E3E41 + green accents #19A77B/#3BC49A) */
.career-sidebar {
    background: linear-gradient(180deg, #2E3E41 0%, #1f2e30 100%) !important;
    width: 280px !important;
    height: 100vh !important;
    position: fixed !important;
    left: 0 !important;
    top: 0 !important;
    z-index: 1000 !important;
    padding: 0 !important;
    box-shadow: 4px 0 24px rgba(0, 0, 0, 0.12) !important;
    transition: transform 0.3s ease !important;
    border-radius: 0 !important;
    border-right: 1px solid rgba(25, 167, 123, 0.12) !important;
    overflow-y: auto !important;
}

.career-sidebar::-webkit-scrollbar { width: 5px !important; }
.career-sidebar::-webkit-scrollbar-track { background: transparent !important; }
.career-sidebar::-webkit-scrollbar-thumb {
    background: #19A77B !important;
    border-radius: 10px !important;
}

.sidebar-header {
    padding: 16px 20px !important;
    border-bottom: 1px solid rgba(255, 255, 255, 0.08) !important;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    gap: 15px !important;
    min-height: 80px !important;
}

.sidebar-logo {
    width: 44px !important;
    height: 44px !important;
    background-image: url('${pageContext.request.contextPath}/assets/images/logo/logo.png') !important;
    background-repeat: no-repeat !important;
    background-position: center !important;
    background-size: contain !important;
    flex-shrink: 0 !important;
    filter: none !important;
}

.sidebar-company-name {
    color: white !important;
    font-weight: 700 !important;
    font-size: 1.2rem !important;
    line-height: 1.2 !important;
}

.sidebar-dashboard-btn {
    display: flex !important;
    align-items: center !important;
    gap: 14px !important;
    padding: 10px 20px !important;
    text-decoration: none !important;
    color: rgba(255, 255, 255, 0.7) !important;
    border: none !important;
    background: transparent !important;
    justify-content: flex-start !important;
    width: 100% !important;
    margin: 4px 0 !important;
    transition: all 0.3s ease !important;
}

.sidebar-dashboard-btn i {
    font-size: 1.1rem !important;
    min-width: 20px !important;
    color: inherit !important;
}

.sidebar-dashboard-btn:hover {
    background: rgba(25, 167, 123, 0.15) !important;
    border-radius: 10px !important;
    transform: translateX(3px) !important;
    color: #3BC49A !important;
}

.sidebar-nav {
    list-style: none !important;
    padding: 0 !important;
    margin: 0 !important;
}

.sidebar-nav li { margin: 0 !important; }

.sidebar-nav a {
    display: flex !important;
    align-items: center !important;
    gap: 14px !important;
    padding: 10px 16px !important;
    color: rgba(255, 255, 255, 0.7) !important;
    text-decoration: none !important;
    font-weight: 500 !important;
    font-size: 0.9rem !important;
    transition: all 0.3s ease !important;
    border-left: 3px solid transparent !important;
    margin: 2px 8px !important;
    border-radius: 10px !important;
}

.sidebar-nav a i {
    width: 20px !important;
    text-align: center !important;
    font-size: 1.1rem !important;
    color: inherit !important;
}

.sidebar-nav a:hover {
    background: rgba(25, 167, 123, 0.15) !important;
    border-left-color: transparent !important;
    transform: translateX(3px) !important;
    color: #3BC49A !important;
}

.sidebar-nav a.active {
    background: linear-gradient(135deg, rgba(25,167,123,0.25), rgba(59,196,154,0.12)) !important;
    color: #3BC49A !important;
    border-left-color: #19A77B !important;
    font-weight: 600 !important;
    box-shadow: none !important;
}

.sidebar-nav a.active i { color: #3BC49A !important; }

.sidebar-nav .submenu {
    list-style: none !important;
    padding: 0 !important;
    margin: 0 !important;
    background: rgba(0, 0, 0, 0.15) !important;
    max-height: 0 !important;
    overflow: hidden !important;
    transition: max-height 0.3s ease !important;
}

.sidebar-nav .submenu.show { max-height: 500px !important; }
.sidebar-nav .submenu li { margin: 0 !important; }
.sidebar-nav .submenu a {
    padding: 8px 20px 8px 52px !important;
    font-size: 0.85rem !important;
}

.sidebar-nav .has-submenu > a::after {
    content: '\f107' !important;
    font-family: 'Font Awesome 6 Free' !important;
    font-weight: 900 !important;
    margin-left: auto !important;
    transition: transform 0.3s ease !important;
}

.sidebar-nav .has-submenu > a.open::after {
    transform: rotate(180deg) !important;
}

.sidebar-toggle-btn {
    display: none !important;
    position: fixed !important;
    top: 15px !important;
    left: 15px !important;
    z-index: 1001 !important;
    background: #19A77B !important;
    color: white !important;
    border: none !important;
    padding: 12px 18px !important;
    border-radius: 12px !important;
    font-size: 1.2rem !important;
    cursor: pointer !important;
    box-shadow: 0 4px 16px rgba(25, 167, 123, 0.3) !important;
    transition: all 0.3s ease !important;
}

.sidebar-toggle-btn:hover { transform: scale(1.08) !important; }

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

.sidebar-overlay.show { display: block; }


@media (max-width: 991.98px) {
    .sidebar-toggle-btn {
        display: block !important;
    }
    .career-sidebar {
        transform: translateX(-100%) !important;
        border-radius: 0 !important;
        height: 100vh !important;
    }
    .career-sidebar.show {
        transform: translateX(0) !important;
        border-radius: 0 20px 20px 0 !important;
    }
    .main-content-wrapper {
        margin-left: 0 !important;
    }
}
</style>

<!-- Sidebar Toggle Button (Mobile) -->
<button class="sidebar-toggle-btn" onclick="toggleSidebar()">
    <i class="fas fa-bars"></i>
</button>

<!-- Sidebar Overlay (Mobile) -->
<div class="sidebar-overlay" onclick="toggleSidebar()"></div>

<!-- Left Sidebar Navigation - Ultra Premium -->
<nav class="career-sidebar" id="careerSidebar">
    <div class="sidebar-header">
        <div class="sidebar-logo"></div>
        <div class="sidebar-company-name">SmartInterview</div>
    </div>

    <ul class="sidebar-nav">
        <li>
            <a href="${pageContext.request.contextPath}/userdashboard.html">
                <i class="fas fa-home"></i>
                <span>Back to Home</span>
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/jobSeekers/profile">
                <i class="fas fa-user"></i>
                <span>Create/Update Profile</span>
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/company/Alllist">
                <i class="fas fa-building"></i>
                <span>Companies</span>
            </a>
        </li>

        <!-- Jobs submenu - Premium -->
        <li class="has-submenu">
            <a href="#" onclick="toggleSubmenu(event, this)">
                <i class="fas fa-briefcase"></i>
                <span>Jobs</span>
            </a>
            <ul class="submenu">
                <li>
                    <a href="${pageContext.request.contextPath}/jobs/all">
                        <i class="fas fa-search"></i>
                        <span>Browse Jobs</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/seeker/saved-jobs">
                        <i class="fas fa-bookmark"></i>
                        <span>Saved Jobs</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/seeker/reported-jobs">
                        <i class="fas fa-flag"></i>
                        <span>Reported Jobs</span>
                    </a>
                </li>
            </ul>
        </li>
        
        <li>
            <a href="${pageContext.request.contextPath}/applications/track">
                <i class="fas fa-tasks"></i>
                <span>Track Applications</span>
            </a>
        </li>
        
        <li>
            <a href="${pageContext.request.contextPath}/jobseeker/videos">
                <i class="fas fa-video"></i>
                <span>Upload Video Resume</span>
            </a>
        </li>
        
        <li>
            <a href="${pageContext.request.contextPath}/assessment/available-badges">
                <i class="fas fa-trophy"></i>
                <span>Achieve Your Badges</span>
            </a>
        </li>
        
        <li>
            <a href="${pageContext.request.contextPath}/qna">
                <i class="fas fa-question-circle"></i>
                <span>Ask Your Questions</span>
            </a>
        </li>
        
        <li>
            <a href="${pageContext.request.contextPath}/notifications">
                <i class="fas fa-bell"></i>
                <span>Notifications</span>
            </a>
        </li>
        
        <li>
            <a href="${pageContext.request.contextPath}/assessment/my-invites">
                <i class="fas fa-clipboard-check"></i>
                <span>Assessments</span>
            </a>
        </li>
    </ul>
</nav>

<script>
function toggleSidebar() {
    const sidebar = document.getElementById('careerSidebar');
    const overlay = document.querySelector('.sidebar-overlay');
    sidebar.classList.toggle('show');
    overlay.classList.toggle('show');
}

function toggleSubmenu(event, element) {
    event.preventDefault();
    const submenu = element.nextElementSibling;
    
    // Close all other submenus
    document.querySelectorAll('.sidebar-nav .submenu').forEach(function(menu) {
        if (menu !== submenu) {
            menu.classList.remove('show');
        }
    });
    document.querySelectorAll('.sidebar-nav .has-submenu > a').forEach(function(link) {
        if (link !== element) {
            link.classList.remove('open');
        }
    });
    
    // Toggle current submenu
    submenu.classList.toggle('show');
    element.classList.toggle('open');
}

(function() {
    function highlightActiveLink() {
        const path = window.location.pathname;
        const origin = window.location.origin;
        
        // Remove active class from all links
        const navLinks = document.querySelectorAll('.career-sidebar a');
        navLinks.forEach(link => link.classList.remove('active'));
        
        let matched = false;
        
        // 1. Check custom path-based matches
        if (path.includes('/company/')) {
            const compLink = document.querySelector('.career-sidebar a[href*="/company/Alllist"]');
            if (compLink) { compLink.classList.add('active'); matched = true; }
        } else if (path.includes('/qna') || path.includes('/questions')) {
            const qnaLink = document.querySelector('.career-sidebar a[href*="/qna"]');
            if (qnaLink) { qnaLink.classList.add('active'); matched = true; }
        } else if (path.includes('/assessment/available-badges')) {
            const badgeLink = document.querySelector('.career-sidebar a[href*="/available-badges"]');
            if (badgeLink) { badgeLink.classList.add('active'); matched = true; }
        } else if (path.includes('/assessment/my-invites')) {
            const inviteLink = document.querySelector('.career-sidebar a[href*="/my-invites"]');
            if (inviteLink) { inviteLink.classList.add('active'); matched = true; }
        } else if (path.includes('/seeker/saved-jobs')) {
            const savedLink = document.querySelector('.career-sidebar a[href*="/seeker/saved-jobs"]');
            if (savedLink) { savedLink.classList.add('active'); matched = true; }
        } else if (path.includes('/seeker/reported-jobs')) {
            const reportedLink = document.querySelector('.career-sidebar a[href*="/seeker/reported-jobs"]');
            if (reportedLink) { reportedLink.classList.add('active'); matched = true; }
        } else if (path.includes('/jobs/all') || path.includes('/jobs/details/')) {
            const jobsLink = document.querySelector('.career-sidebar a[href*="/jobs/all"]');
            if (jobsLink) { jobsLink.classList.add('active'); matched = true; }
        } else if (path.includes('/jobSeekers/profile') || path.includes('/jobSeekers/update')) {
            const profileLink = document.querySelector('.career-sidebar a[href*="/jobSeekers/profile"]');
            if (profileLink) { profileLink.classList.add('active'); matched = true; }
        } else if (path.includes('/userdashboard')) {
            const dashLink = document.querySelector('.career-sidebar a[href*="/userdashboard"]');
            if (dashLink) { dashLink.classList.add('active'); matched = true; }
        } else if (path.includes('/applications/track')) {
            const appLink = document.querySelector('.career-sidebar a[href*="/applications/track"]');
            if (appLink) { appLink.classList.add('active'); matched = true; }
        } else if (path.includes('/jobseeker/videos')) {
            const videoLink = document.querySelector('.career-sidebar a[href*="/jobseeker/videos"]');
            if (videoLink) { videoLink.classList.add('active'); matched = true; }
        } else if (path.includes('/notifications')) {
            const noteLink = document.querySelector('.career-sidebar a[href*="/notifications"]');
            if (noteLink) { noteLink.classList.add('active'); matched = true; }
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
        
        // 3. Auto-expand Jobs submenu if any of its children are active
        const activeLink = document.querySelector('.career-sidebar a.active');
        if (activeLink) {
            const submenu = activeLink.closest('.submenu');
            if (submenu) {
                submenu.classList.add('show');
                const submenuToggle = submenu.previousElementSibling;
                if (submenuToggle) {
                    submenuToggle.classList.add('open');
                }
            }
        }
    }
    
    // Execute immediately and on DOMContentLoaded
    highlightActiveLink();
    document.addEventListener("DOMContentLoaded", highlightActiveLink);
    window.addEventListener("load", highlightActiveLink);
})();
</script>