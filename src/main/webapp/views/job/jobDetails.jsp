<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ page import="in.sp.main.Entities.Job" %>
<%@ page import="java.time.LocalDate, java.util.Date, java.time.ZoneId, java.text.SimpleDateFormat" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>

<%
    Job job = (Job) request.getAttribute("job");
    
    if (job == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Job not found");
        return;
    }

    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
    String posted = "N/A", expiry = "N/A";
    if(job.getPostedDate()!=null){
        posted = sdf.format(Date.from(job.getPostedDate().atStartOfDay(ZoneId.systemDefault()).toInstant()));
    }
    if(job.getExpiryDate()!=null){
        expiry = sdf.format(Date.from(job.getExpiryDate().atStartOfDay(ZoneId.systemDefault()).toInstant()));
    }

    // If you have responsibilities & perks in entity, else leave blank
   // String responsibilities = job.getResponsibilities()!=null ? job.getResponsibilities() : "Not specified.";
    //String perks = job.getPerks()!=null ? job.getPerks() : "No additional perks listed.";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title><c:out value="${job.title}" default="Job Details"/> | JobU</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
:root{
 --primary:#2042e3;
 --dark:#081828;
 --bg:#f6f9fc;
 --card:#ffffff;
 --muted:#7E8890;
 --text:#081828;
 --border:#e7ecf3;
 --success:#19A77B;
}

*{box-sizing:border-box;}
body{margin:0;font-family:'Inter',sans-serif;background:var(--bg);padding:32px;}

.container{max-width:1080px;margin:auto;display:grid;grid-template-columns:2.5fr 1fr;gap:28px;}

/* ===== MAIN CARD ===== */
.card{
 background:var(--card);
 border-radius:16px;
 box-shadow:0 12px 36px rgba(0,0,0,0.08);
}

/* HEADER */
.header{padding:28px 32px;border-bottom:1px solid var(--border);}
.title{font-size:30px;font-weight:700;color:var(--text);}
.meta{margin-top:8px;font-size:15px;color:var(--muted);display:flex;gap:18px;flex-wrap:wrap;}
.meta span{display:flex;gap:6px;align-items:center;}

.highlights{margin-top:16px;display:flex;gap:12px;flex-wrap:wrap;}
.highlight{padding:8px 16px;background:#eef2ff;color:var(--primary);border-radius:20px;font-size:13px;font-weight:600;}

/* CONTENT */
.content{padding:32px;}

/* SECTION TITLE */
.section-title{
 margin:24px 0 16px;
 font-size:20px;
 font-weight:700;
 color:var(--text);
 border-bottom:2px solid var(--border);
 padding-bottom:6px;
}

/* GRID BOXES */
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:18px;}
.box{border:1px solid var(--border);border-radius:12px;padding:16px 18px;background:#fafcff;}
.box label{font-size:12px;color:var(--muted);text-transform:uppercase;font-weight:600;margin-bottom:6px;display:block;}
.box span{font-size:15px;font-weight:600;color:var(--text);}

/* LONG TEXT BLOCKS */
.text-block{background:#fafcff;border:1px solid var(--border);border-radius:12px;padding:20px;line-height:1.75;color:var(--text);font-size:15px;}

/* PERKS */
.perk{margin:6px 0;padding-left:20px;position:relative;}
.perk i{position:absolute;left:0;color:var(--success);font-size:12px;}

/* ACTIONS */
.actions{margin-top:32px;display:flex;gap:16px;flex-wrap:wrap;}
.btn{padding:14px 28px;border-radius:10px;font-size:15px;font-weight:600;border:none;cursor:pointer;display:flex;align-items:center;gap:10px;}
.btn-company{background:#eef2ff;color:var(--primary);}
.btn-apply{background:linear-gradient(135deg,var(--primary),var(--dark));color:#fff;}

/* SIDEBAR */
.job-sidebar{background:var(--card);border-radius:16px;box-shadow:0 10px 30px rgba(0,0,0,0.08);padding:24px;font-size:15px;}
.job-sidebar h4{margin:0 0 14px;font-size:18px;color:var(--text);border-bottom:2px solid var(--border);padding-bottom:10px;}
.job-sidebar .item{margin-bottom:16px;display:flex;gap:8px;color:var(--text);align-items:center;}
.job-sidebar .item i{color:var(--primary);width:20px;text-align:center;font-size:16px;}
.job-sidebar .item span{font-weight:600;color:var(--muted);margin-right:2px;}

/* SHARE */
.share{margin-top:20px;display:flex;gap:12px;}
.share i{font-size:20px;color:var(--primary);cursor:pointer;transition:0.2s;}
.share i:hover{color:var(--dark);}

/* RESPONSIVE */
@media(max-width:900px){.container{grid-template-columns:1fr;}}
.share {
    display: flex;
    gap: 14px;
    margin-top: 16px;
}

/* ===== SHARE SECTION ===== */
.share-section {
    margin-top: 28px;
    padding-top: 18px;
    border-top: 1px solid var(--border);
}

.share-label {
    font-size: 14px;
    font-weight: 600;
    color: var(--muted);
    display: block;
    margin-bottom: 12px;
}

/* buttons wrapper */
.share-buttons {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
}

/* base button */
.share-btn {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    padding: 10px 16px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 600;
    text-decoration: none;
    border: 1px solid var(--border);
    background: #ffffff;
    color: var(--text);
    transition: all 0.25s ease;
}

/* icon */
.share-btn i {
    font-size: 16px;
}

/* hover – subtle, professional */
.share-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(0,0,0,0.08);
}

/* platform colors */
.share-btn.linkedin i { color: #0a66c2; }
.share-btn.whatsapp i { color: #25d366; }
.share-btn.facebook i { color: #1877f2; }

.share-btn.linkedin:hover {
    border-color: #0a66c2;
    background: rgba(10, 102, 194, 0.05);
}

.share-btn.whatsapp:hover {
    border-color: #25d366;
    background: rgba(37, 211, 102, 0.06);
}

.share-btn.facebook:hover {
    border-color: #1877f2;
    background: rgba(24, 119, 242, 0.06);
}

/* mobile */
@media (max-width: 576px) {
    .share-btn {
        width: 100%;
        justify-content: center;
    }
}
/* ===== SIDEBAR ACTION BUTTONS ===== */

.sidebar-actions {
    margin-top: 20px;
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.sidebar-btn {
    width: 100%;
    padding: 14px;
    border-radius: 10px;
    font-size: 15px;
    font-weight: 600;
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    transition: all 0.25s ease;
}

/* Apply button */
.apply-btn {
    background: linear-gradient(135deg, var(--primary), var(--dark));
    color: #ffffff;
}

.apply-btn:hover {
    box-shadow: 0 10px 24px rgba(32, 66, 227, 0.35);
    transform: translateY(-2px);
}

/* Company button */
.company-btn {
    background: #eef2ff;
    color: var(--primary);
    border: 1px solid #dbe3ff;
}

.company-btn:hover {
    background: #e0e7ff;
}

/* Optional: sticky sidebar actions */
@media (min-width: 900px) {
    .job-sidebar {
        position: sticky;
        top: 24px;
    }
}
.title-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
}


.match-badge {
  padding: 6px 14px;
  border-radius: 20px;
  font-size: 13px;
  font-weight: 600;
  white-space: nowrap;
}

/* Match score colors */
.match-badge.high {
  background: #e6f7f1;
  color: #0f9d58;
}

.match-badge.medium {
  background: #fff4e5;
  color: #f57c00;
}

.match-badge.low {
  background: #fdecea;
  color: #d32f2f;
}

</style>

<!-- ===== Open Graph Meta Tags (LinkedIn / Facebook Preview) ===== -->
<meta property="og:type" content="website" />
<meta property="og:title" content="<c:out value="${job.title}"/> | <c:out value="${job.company != null ? job.company.name : 'Company'}"/>" />
<meta property="og:description" content="Apply for <c:out value="${job.title}"/> at <c:out value="${job.company != null ? job.company.name : 'Company'}"/>. Location: <c:out value="${job.location}"/>. Experience: <c:out value="${job.experienceRequired}"/>+ years." />
<meta property="og:url" content="${pageContext.request.requestURL}" />
<meta property="og:image" content="${pageContext.request.contextPath}/assets/images/job-preview.png" />

<!-- Twitter / LinkedIn fallback -->
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:title" content="<c:out value="${job.title}"/> | <c:out value="${job.company != null ? job.company.name : 'Company'}"/>" />
<meta name="twitter:description" content="Apply now for <c:out value="${job.title}"/>. View job details on JobU." />
<%
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM yyyy");

    String postedDateFormatted = "";
    String expiryDateFormatted = "";

    if (job.getPostedDate() != null) {
        postedDateFormatted = job.getPostedDate().format(formatter);
    }

    if (job.getExpiryDate() != null) {
        expiryDateFormatted = job.getExpiryDate().format(formatter);
    }
%>

</head>
<body>

<div class="container">

<!-- MAIN -->
<div class="card">

 <!-- HEADER -->
 <div class="header">
  <div class="title"><c:out value="${job.title}"/></div>
   <div class="match-badge <c:choose><c:when test="${matchScore >= 80}">high</c:when><c:when test="${matchScore >= 60}">medium</c:when><c:otherwise>low</c:otherwise></c:choose>">
      <c:out value="${matchScore}" default="0"/>% Match
    </div>

  <div class="meta">
   <span><i class="fas fa-building"></i><c:out value="${job.company != null ? job.company.name : 'Company Not Available'}"/></span>
   <span><i class="fas fa-map-marker-alt"></i><c:out value="${job.location}"/></span>
   <span><i class="fas fa-id-badge"></i>Job ID: <c:out value="${job.id}"/></span>
  </div>

  <div class="highlights">
   <div class="highlight"><c:out value="${job.employmentType}" default="Not specified"/></div>
   <div class="highlight"><c:out value="${job.workMode}" default="Not specified"/></div>
   <div class="highlight"><c:out value="${job.experienceRequired}" default="0"/>+ yrs</div>
   <div class="highlight"><c:out value="${matchScore}" default="0"/>% Match</div>
  </div>
 </div>

 <!-- DETAILS -->
 <div class="content">

  <div class="section-title">Job Details</div>

  <div class="grid">
    <div class="box">
      <label>Salary</label>
      <span>
        <c:choose>
          <c:when test="${job.salaryMin != null && job.salaryMax != null}">
            &#8377;<fmt:formatNumber value="${job.salaryMin}" maxFractionDigits="0"/> - &#8377;<fmt:formatNumber value="${job.salaryMax}" maxFractionDigits="0"/>
          </c:when>
          <c:otherwise>Not specified</c:otherwise>
        </c:choose>
      </span>
    </div>
    <div class="box"><label>Education</label><span><c:out value="${job.education}" default="Not specified"/></span></div>
    <div class="box"><label>Skills</label><span><c:out value="${not empty job.skillRequirement ? fn:replace(job.skillRequirement, ',', ', ') : 'Not specified'}"/></span></div>
    <div class="box"><label>Job Category</label><span><c:out value="${job.jobCategory}" default="Not specified"/></span></div>
    <div class="box"><label>Job Sector</label><span><c:out value="${job.jobSector}" default="Not specified"/></span></div>
  </div>

  <div class="section-title">Description</div>
  <div class="text-block"><c:out value="${job.description}" default="No description available."/></div>

 <%--  <div class="section-title">Responsibilities</div>
  <div class="text-block">${responsibilities}</div>

  <div class="section-title">Perks & Benefits</div>
  <div class="text-block">
     <c:forEach var="p" items="${fn:split(perks,',')}">
         <div class="perk"><i class="fas fa-check-circle"></i>${p.trim()}</div>
     </c:forEach>
  </div> --%>

  <%-- <div class="actions">
    <form action="${pageContext.request.contextPath}/company/details/${job.company.id}">
      <button class="btn btn-company"><i class="fas fa-building"></i>Company Profile</button>
    </form>

    <form action="${pageContext.request.contextPath}/applications/apply" method="post">
      <input type="hidden" name="jobId" value="${job.id}">
      <button class="btn btn-apply"><i class="fas fa-paper-plane"></i>Apply Now</button>
    </form>
  </div> --%>

 </div>

</div>

<!-- SIDEBAR -->
<div class="job-sidebar">

    <!-- JOB SUMMARY -->
    <h4>Job Summary</h4>

   <div class="item">
    <i class="far fa-calendar-alt"></i>
    <span>Posted:</span> <%= postedDateFormatted %>
</div>

<div class="item">
    <i class="far fa-clock"></i>
    <span>Expiry:</span> <%= expiryDateFormatted %>
</div>


    <div class="item">
        <i class="fas fa-map-marker-alt"></i>
        <span>Location:</span> <c:out value="${job.location}" default="Not specified"/>
    </div>

    <div class="item">
        <i class="fas fa-briefcase"></i>
        <span>Work Mode:</span> <c:out value="${job.workMode}" default="Not specified"/>
    </div>

    <!-- ACTION BUTTONS -->
    <div class="sidebar-actions">

        <c:choose>
            <c:when test="${hasApplied}">
                <button type="button" class="sidebar-btn apply-btn" disabled style="background-color: #6c757d; cursor: not-allowed; opacity: 0.8;">

                    <i class="fas fa-check-circle"></i>
                    Applied
                </button>
            </c:when>
            <c:otherwise>
                <form action="${pageContext.request.contextPath}/applications/apply" method="post">
                    <input type="hidden" name="jobId" value="<c:out value='${job.id}'/>">
                    <button type="submit" class="sidebar-btn apply-btn">
                        <i class="fas fa-paper-plane"></i>
                        Apply Now
                    </button>
                </form>
            </c:otherwise>
        </c:choose>

        <c:if test="${job.company != null}">
        <form action="${pageContext.request.contextPath}/company/details/<c:out value='${job.company.id}'/>">
            <button type="submit" class="sidebar-btn company-btn">
                <i class="fas fa-building"></i>
                View Company
            </button>
        </form>
        </c:if>

    </div>

    <!-- SHARE SECTION -->
    <div class="share-section">
        <span class="share-label">Share this job</span>

        <div class="share-buttons">

            <a class="share-btn linkedin"
               href="https://www.linkedin.com/sharing/share-offsite/?url=${pageContext.request.requestURL}"
               target="_blank">
                <i class="fab fa-linkedin-in"></i>
                <span>LinkedIn</span>
            </a>

            <a class="share-btn whatsapp"
               href="https://wa.me/?text=Check%20out%20this%20job:%20<c:out value='${job.title}'/>%20-%20${pageContext.request.requestURL}"
               target="_blank">
                <i class="fab fa-whatsapp"></i>
                <span>WhatsApp</span>
            </a>

            <a class="share-btn facebook"
               href="https://www.facebook.com/sharer/sharer.php?u=${pageContext.request.requestURL}"
               target="_blank">
                <i class="fab fa-facebook-f"></i>
                <span>Facebook</span>
            </a>

        </div>
    </div>

</div>


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

