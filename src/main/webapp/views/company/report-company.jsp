<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<meta charset="UTF-8">
<title>Report a Company – Jobu</title>

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<style>
body {
    font-family: 'Inter', sans-serif;
    background: #f6f9fc;
    margin: 0;
    padding: 30px 15px;
}

.container {
    max-width: 820px;
    margin: auto;
    background: #fff;
    padding: 35px 40px;
    border-radius: 18px;
    box-shadow: 0 6px 24px rgba(35,38,45,.15);
}

h2 {
    text-align: center;
    color: #2042e3;
    font-size: 28px;
    margin-bottom: 10px;
}

.sub {
    text-align: center;
    color: #7E8890;
    margin-bottom: 30px;
    font-size: 14px;
}

label {
    font-weight: 600;
    color: #081828;
    margin-top: 18px;
    display: block;
}

label i {
    color: #2042e3;
    margin-right: 6px;
}

input, textarea, select {
    width: 100%;
    padding: 13px 14px;
    margin-top: 6px;
    border-radius: 10px;
    border: 1.5px solid #d0d7f3;
    font-size: 15px;
}

input:focus, textarea:focus, select:focus {
    outline: none;
    border-color: #2042e3;
}

textarea {
    resize: vertical;
}

.optional {
    font-size: 12px;
    color: #7E8890;
    font-weight: 400;
}

hr {
    margin: 30px 0;
    border: none;
    border-top: 1px dashed #ddd;
}

.custom-field {
    display: none;
}

button {
    margin-top: 30px;
    width: 100%;
    background: #2042e3;
    color: #fff;
    padding: 15px;
    font-size: 16px;
    font-weight: 600;
    border: none;
    border-radius: 12px;
    cursor: pointer;
    box-shadow: 0 6px 18px rgba(32,66,227,.25);
}

button:hover {
    background: #081828;
}

.note {
    background: #f1f5ff;
    border-left: 4px solid #2042e3;
    padding: 12px 15px;
    border-radius: 10px;
    font-size: 13px;
    color: #555;
    margin-bottom: 25px;
}
</style>

<script>
function toggleOther(selectEl, inputId) {
    const input = document.getElementById(inputId);
    if (selectEl.value === 'Other') {
        input.style.display = 'block';
        input.querySelector('input').required = true;
    } else {
        input.style.display = 'none';
        input.querySelector('input').required = false;
        input.querySelector('input').value = '';
    }
}
</script>
</head>

<body>

<div class="container">

<h2><i class="fa-solid fa-flag"></i> Report a Company</h2>
<p class="sub">Help other jobseekers by sharing your experience or information</p>

<div class="note">
<i class="fa-solid fa-circle-info"></i>
 You can report even if you didn'ty-based.
</div>

<form action="${pageContext.request.contextPath}/alerts/save" method="post">

<!-- MANDATORY -->
<label><i class="fa-solid fa-building"></i> Company Name *</label>
<input type="text" name="companyName" required>

<label><i class="fa-solid fa-triangle-exclamation"></i> Why are you reporting this company? *</label>
<textarea name="reportReason" rows="5" required
 placeholder="Eg: Asked money, fake job post, MLM scheme, toxic behaviour..."></textarea>

<!-- OPTIONAL -->
<label><i class="fa-solid fa-industry"></i> Industry <span class="optional">(optional)</span></label>
<input type="text" name="industry">

<label><i class="fa-solid fa-location-dot"></i> Location <span class="optional">(optional)</span></label>
<input type="text" name="location">

<label><i class="fa-solid fa-globe"></i> Website <span class="optional">(optional)</span></label>
<input type="url" name="website">

<label><i class="fa-brands fa-linkedin"></i> LinkedIn Company Page <span class="optional">(optional)</span></label>
<input type="url" name="linkedinUrl" placeholder="https://linkedin.com/company/...">

<label><i class="fa-solid fa-circle-info"></i> How did you know about this issue?</label>
<select name="howDidYouKnow" onchange="toggleOther(this,'knowOther')">
    <option value="">-- Optional --</option>
    <option>Interview</option>
    <option>HR Call</option>
    <option>Job Portal</option>
    <option>Friend / Colleague</option>
    <option>Offer Letter</option>
    <option>Consultancy</option>
    <option>Online Reviews</option>
    <option>Other</option>
</select>

<div id="knowOther" class="custom-field">
    <label>Specify other source *</label>
    <input type="text" name="howDidYouKnowOther">
</div>

<label><i class="fa-solid fa-bug"></i> Issue Type</label>
<select name="issueType" onchange="toggleOther(this,'issueOther')">
    <option value="">-- Optional --</option>
    <option>Scam / Fake Hiring</option>
    <option>Money Asked</option>
    <option>Ghosting</option>
    <option>MLM / Consultancy Trap</option>
    <option>Toxic Work Culture</option>
    <option>Fake Offer Letter</option>
    <option>Other</option>
</select>

<div id="issueOther" class="custom-field">
    <label>Specify other issue *</label>
    <input type="text" name="issueTypeOther">
</div>

<label><i class="fa-solid fa-user-tie"></i> Role Mentioned <span class="optional">(if any)</span></label>
<input type="text" name="roleMentioned">

<label><i class="fa-solid fa-microphone"></i> Did you attend interview?</label>
<select name="interviewAttended">
    <option value="">Not sure</option>
    <option value="true">Yes</option>
    <option value="false">No</option>
</select>

<hr>

<label><i class="fa-solid fa-user"></i> Your Name <span class="optional">(optional)</span></label>
<input type="text" name="reporterName">

<label><i class="fa-solid fa-envelope"></i> Your Email <span class="optional">(optional)</span></label>
<input type="email" name="reporterEmail">

<button type="submit">
    <i class="fa-solid fa-paper-plane"></i> Submit Alert
</button>

</form>

</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
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
                /* Table responsiveness */
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
    
    const sidebar = document.querySelector('.sidebar') || document.querySelector('.nav-sidebar');
    if (sidebar) {
        const topBar = document.querySelector('.top-bar') || document.querySelector('.chat-header') || document.querySelector('.dashboard-header') || document.body;
        
        let heading = null;
        if (topBar && topBar !== document.body) {
            heading = topBar.querySelector('h1') || topBar.querySelector('.chat-header-info') || topBar.querySelector('h2');
            if (!heading) heading = topBar;
        } else if (!document.querySelector('.mobile-menu-btn')) {
            // Absolute fallback for simple pages
            heading = document.createElement('div');
            heading.style.padding = '10px';
            document.body.insertBefore(heading, document.body.firstChild);
        }
        
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

            let touchstartX = 0;
            let touchendX = 0;
            document.body.addEventListener('touchstart', e => { touchstartX = e.changedTouches[0].screenX; }, {passive: true});
            document.body.addEventListener('touchend', e => { 
                touchendX = e.changedTouches[0].screenX; 
                if (touchendX < touchstartX - 50) closeSidebar(); 
                if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); 
            }, {passive: true});
            
            function openSidebar() {
                sidebar.classList.add('active');
                overlay.classList.add('active');
                document.body.style.overflow = 'hidden';
            }
            
            function closeSidebar() {
                sidebar.classList.remove('active');
                overlay.classList.remove('active');
                document.body.style.overflow = '';
            }
            
            toggleBtn.addEventListener('click', openSidebar);
            overlay.addEventListener('click', closeSidebar);
        }
    }
    
    // Add data-labels
    const tables = document.querySelectorAll('table:not(.table-responsive)');
    tables.forEach(table => {
        const headers = Array.from(table.querySelectorAll('th')).map(th => th.innerText);
        const rows = Array.from(table.querySelectorAll('tbody tr'));
        rows.forEach(row => {
            Array.from(row.querySelectorAll('td')).forEach((td, index) => {
                if(headers[index]) {
                    td.setAttribute('data-label', headers[index]);
                }
            });
        });
    });
});
</script>
</body>
</html>

