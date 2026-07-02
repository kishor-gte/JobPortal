<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.*, java.time.format.*" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Company Alerts – Jobu</title>

<!-- Fonts & Icons -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<style>
:root{
  --bg: #f6f9fc;
  --card-bg: #ffffff;
  --muted: #6b7280;
  --text: #0b1220;
  --primary: #0f4de6;
  --accent: #ff7a59;
  --danger: #ef4444;
  --card-shadow: 0 8px 24px rgba(15,23,42,0.06);
  --radius: 10px;
  --max-width: 1200px;
}

/* Base */
* { box-sizing: border-box; }
body{
  margin:0;
  font-family: 'Inter', system-ui, -apple-system, "Segoe UI", Roboto, Arial;
  background: linear-gradient(180deg, #f0f6ff 0%, var(--bg) 100%);
  color: var(--text);
  -webkit-font-smoothing:antialiased;
  -moz-osx-font-smoothing:grayscale;
  padding:28px 18px;
}

/* Container & header */
.container { max-width: var(--max-width); margin: 0 auto; }
.header { display:flex; align-items:center; justify-content:space-between; gap:16px; margin-bottom: 12px; }
.header-left h2 { margin:0; color:var(--primary); font-size:22px; font-weight:700; }
.header-left p { margin:4px 0 0 0; color:var(--muted); font-size:13px; }

/* Action button */
.btn { display:inline-flex; gap:10px; align-items:center; background: linear-gradient(180deg,var(--primary), #0b3ad0); color:#fff; padding:10px 14px; border-radius:10px; font-weight:600; font-size:13px; text-decoration:none; box-shadow: 0 8px 20px rgba(15,77,230,0.12); }
.btn:hover { transform: translateY(-2px); }

/* Page-level notice */
.page-note { margin-top:10px; margin-bottom: 12px; background: rgba(255,244,229,0.95); border-left: 4px solid var(--danger); padding: 10px 14px; border-radius: 8px; color: var(--muted); font-size: 13px; display:flex; gap:10px; align-items:flex-start; }

/* Grid: compact & dense */
.alerts-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap:14px; margin-top: 6px; }

/* Card & link */
.card-link { display:block; color:inherit; text-decoration:none; }
.alert-card { background: var(--card-bg); border-radius: var(--radius); padding:12px; box-shadow: var(--card-shadow); border:1px solid rgba(15,23,42,0.03); display:flex; flex-direction:column; min-height: 120px; transition: transform .12s ease, box-shadow .12s ease; }
.card-link:hover .alert-card { transform: translateY(-6px); box-shadow: 0 18px 36px rgba(15,23,42,0.08); }

/* Top row */
.card-top { display:flex; justify-content:space-between; align-items:center; gap:8px; }
.company { display:flex; gap:10px; align-items:center; }
.logo { width:36px; height:36px; border-radius:8px; display:inline-flex; align-items:center; justify-content:center; background: linear-gradient(135deg, rgba(15,77,230,0.12), rgba(255,122,89,0.06)); color:var(--primary); font-size:16px; }
.company-name { font-size:14px; font-weight:700; color:#071233; }

/* Badge */
.badge { font-size:12px; padding:5px 8px; border-radius:999px; font-weight:700; display:inline-flex; gap:8px; align-items:center; color:var(--danger); background: rgba(239,68,68,0.06); border:1px solid rgba(239,68,68,0.08); }

/* Meta small row */
.meta { margin-top:6px; display:flex; gap:8px; align-items:center; font-size:12px; color:var(--muted); flex-wrap:wrap; }
.meta .chip { background: rgba(3,105,161,0.04); color:#0369a1; padding:4px 8px; border-radius:999px; font-weight:600; border:1px solid rgba(3,105,161,0.06); }

/* Issue & details */
.section { margin-top:8px; font-size:13px; color:#2b3440; }
.section strong { font-weight:700; font-size:13px; color:#071233; margin-right:6px; }

/* Preview text: strongly truncated to keep cards uniform */
.preview {
  margin-top:6px;
  color:#3b4754;
  font-size:13px;
  line-height:1.35;
  display:-webkit-box;
  -webkit-line-clamp:4; /* show up to 4 lines */
  -webkit-box-orient:vertical;
  overflow:hidden;
  text-overflow:ellipsis;
}

/* Read more indicator */
.read-more {
  margin-top:8px;
  text-align:right;
  font-size:13px;
}
.read-more a { color:var(--primary); text-decoration:none; font-weight:700; }
.read-more a:hover { text-decoration:underline; }

/* Footer */
.footer { margin-top:8px; display:flex; justify-content:space-between; align-items:center; font-size:12px; color:var(--muted); }

/* Empty state */
.empty { text-align:center; color:var(--muted); margin-top: 20px; padding:22px; border-radius:8px; background: linear-gradient(180deg, rgba(255,255,255,0.7), rgba(255,255,255,0.5)); }

/* Responsive */
@media (max-width:520px){ .alerts-grid { grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap:10px; } .company-name { font-size:13px; } .preview { -webkit-line-clamp:5; } }
</style>
</head>

<body>
<div class="container">
  <div class="header">
    <div class="header-left">
      <h2>Company Alerts</h2>
      <p>Community-shared experiences to help jobseekers stay informed & safe</p>
    </div>
    <div>
      <a class="btn" href="${pageContext.request.contextPath}/alerts/report">
        <i class="fa-solid fa-flag"></i>
        Report a Company
      </a>
    </div>
  </div>

  <!-- Page-level single notice (no per-card notice) -->
  <div class="page-note" role="status" aria-live="polite">
    <i class="fa-solid fa-shield-halved" style="color:var(--primary); font-size:18px; margin-top:2px;"></i>
    <div>
      These reports are submitted by community members and may not be independently verified by Jobu. Read each report carefully — click any card to view the full report.
    </div>
  </div>

  <c:if test="${empty alerts}">
    <p class="empty">No company alerts have been reported yet.</p>
  </c:if>

  <div class="alerts-grid" aria-live="polite">
    <c:forEach var="a" items="${alerts}">
      <%-- Prepare formatted date and truncated preview using Java in JSP --%>
      <%
        String reportedAtFormatted = "";
        String previewText = "";
        try {
            Object aBean = pageContext.getAttribute("a");
            Object rawReportedAt = null;
            Object rawReason = null;

            if (aBean != null) {
                try {
                    java.lang.reflect.Method m1 = aBean.getClass().getMethod("getReportedAt");
                    rawReportedAt = m1.invoke(aBean);
                } catch (NoSuchMethodException nsme) {
                    try {
                        java.lang.reflect.Field f1 = aBean.getClass().getField("reportedAt");
                        rawReportedAt = f1.get(aBean);
                    } catch (Exception ign) {}
                }

                try {
                    java.lang.reflect.Method m2 = aBean.getClass().getMethod("getReportReason");
                    rawReason = m2.invoke(aBean);
                } catch (NoSuchMethodException nsme2) {
                    try {
                        java.lang.reflect.Field f2 = aBean.getClass().getField("reportReason");
                        rawReason = f2.get(aBean);
                    } catch (Exception ign) {}
                }
            }

            // Date formatting
            if (rawReportedAt != null) {
                ZonedDateTime zdt = null;
                if (rawReportedAt instanceof java.util.Date) {
                    zdt = ((java.util.Date)rawReportedAt).toInstant().atZone(ZoneId.systemDefault());
                } else if (rawReportedAt instanceof Instant) {
                    zdt = ((Instant)rawReportedAt).atZone(ZoneId.systemDefault());
                } else if (rawReportedAt instanceof LocalDateTime) {
                    zdt = ((LocalDateTime)rawReportedAt).atZone(ZoneId.systemDefault());
                } else if (rawReportedAt instanceof ZonedDateTime) {
                    zdt = (ZonedDateTime) rawReportedAt;
                } else if (rawReportedAt instanceof String) {
                    String s = (String) rawReportedAt;
                    try {
                        zdt = ZonedDateTime.parse(s);
                    } catch (Exception e1) {
                        try {
                            LocalDateTime ldt = LocalDateTime.parse(s);
                            zdt = ldt.atZone(ZoneId.systemDefault());
                        } catch (Exception e2) {
                            try {
                                long epoch = Long.parseLong(s);
                                zdt = Instant.ofEpochMilli(epoch).atZone(ZoneId.systemDefault());
                            } catch (Exception e3) { /* fallback below */ }
                        }
                    }
                }
                if (zdt != null) {
                    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("d MMM yyyy, h:mm a");
                    reportedAtFormatted = zdt.format(fmt);
                } else {
                    reportedAtFormatted = rawReportedAt.toString();
                }
            }

            // Preview text: get reason and truncate to nearest word boundary around 240 chars
            if (rawReason != null) {
                String reason = rawReason.toString().trim();
                int maxChars = 240;
                if (reason.length() <= maxChars) {
                    previewText = reason;
                } else {
                    // cut at last space before maxChars to avoid mid-word cut
                    int cut = reason.lastIndexOf(' ', maxChars);
                    if (cut < maxChars / 2) cut = maxChars; // fallback
                    previewText = reason.substring(0, cut) + "...";
                }
            } else {
                previewText = "";
            }

            // Expose previewText and reportedAtFormatted for JSTL output
            pageContext.setAttribute("previewText", previewText);
            pageContext.setAttribute("reportedAtFormatted", reportedAtFormatted);
        } catch (Exception e) {
            pageContext.setAttribute("previewText", "");
            pageContext.setAttribute("reportedAtFormatted", "");
        }
      %>

      <%-- Make entire card clickable; link goes to a detail page for the report.
           Adjust the href to match your routing (e.g. /alerts/view/${a.id} or /alerts/${a.id}). --%>
      <a class="card-link" href="${pageContext.request.contextPath}/alerts/${a.id}" aria-label="View full report for ${a.companyName}">
        <article class="alert-card" role="article" aria-labelledby="company-${a.id}">
          <div class="card-top">
            <div class="company">
              <span class="logo" aria-hidden="true"><i class="fa-solid fa-building"></i></span>
              <div>
                <div class="company-name" id="company-${a.id}">${a.companyName}</div>
                <div class="meta" aria-hidden="false">
                  <c:if test="${not empty a.industry}">
                    <span class="chip"><i class="fa-solid fa-industry"></i>&nbsp;${a.industry}</span>
                  </c:if>
                  <c:if test="${not empty a.location}">
                    <span class="chip"><i class="fa-solid fa-location-dot"></i>&nbsp;${a.location}</span>
                  </c:if>
                </div>
              </div>
            </div>

            <div>
              <span class="badge" title="User reported"><i class="fa-solid fa-user"></i> User</span>
            </div>
          </div>

          <div class="section">
            <strong><i class="fa-solid fa-triangle-exclamation"></i>&nbsp;Issue:</strong>
            <span style="font-weight:600; margin-left:6px; font-size:13px;"><c:out value="${a.issueType}" default="Not specified"/></span>
          </div>

          <div class="preview" title="Click to read full report">
            <c:out value="${previewText}" />
          </div>

          <div class="read-more" aria-hidden="true">
            <span><i class="fa-solid fa-arrow-right-long"></i>&nbsp;<strong>Read full report</strong></span>
          </div>

          <div class="footer">
            <div><i class="fa-regular fa-clock"></i> Reported on <span><c:out value="${reportedAtFormatted}" /></span></div>
            <div style="opacity:0.8; font-size:12px; color:var(--muted);">ID: ${a.id}</div>
          </div>
        </article>
      </a>
    </c:forEach>
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

