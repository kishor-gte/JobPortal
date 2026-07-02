<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.*, java.time.format.*" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>Company Alert Details – Jobu</title>

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

  <style>
    /* (styles kept from previous design) */
    :root{ --bg:#f6f7f8; --card:#fff; --text:#1c1c1c; --muted:#6b7280; --border:#e5e7eb; --primary:#0079d3; --danger:#dc2626; --radius:8px; --container:1000px; }
    *{box-sizing:border-box}
    body{margin:0;font-family:Inter,system-ui,-apple-system,"Segoe UI",Roboto,Arial;background:var(--bg);color:var(--text);padding:24px 16px}
    .wrap{max-width:var(--container);margin:0 auto}
    .top{display:flex;justify-content:space-between;align-items:center;margin-bottom:16px}
    .page-title{font-size:20px;font-weight:700}
    .meta-small{font-size:13px;color:var(--muted)}
    .back a{font-size:14px;color:var(--primary);text-decoration:none;font-weight:600}
    .card{background:var(--card);border-radius:var(--radius);border:1px solid var(--border);display:flex;gap:24px;padding:20px;align-items:flex-start;flex-wrap:wrap}
    .main{flex:1 1 620px;min-width:280px}
    .aside{width:300px;min-width:260px;display:flex;flex-direction:column;gap:14px}
    .company-row{display:flex;justify-content:space-between;align-items:flex-start}
    .company{display:flex;gap:12px}
    .logo{width:48px;height:48px;border-radius:6px;background:#e9f5ff;color:var(--primary);display:flex;align-items:center;justify-content:center}
    .company-name{font-size:18px;font-weight:700;margin:0}
    .meta{font-size:13px;color:var(--muted);margin-top:4px}
    .badge{background:#fee2e2;color:var(--danger);font-size:12px;padding:4px 10px;border-radius:999px;font-weight:700}
    .meta-row{display:flex;gap:10px;flex-wrap:wrap;margin-top:12px}
    .chip{background:#f1f5f9;border:1px solid var(--border);color:#374151;font-size:12px;font-weight:600;padding:4px 10px;border-radius:999px}
    .section{margin-top:18px}
    .section h4{font-size:13px;font-weight:700;color:#374151;margin-bottom:6px}
    .value{font-size:14px;line-height:1.6;color:#111827}
    .notice{margin-top:20px;background:#fff7ed;border-left:4px solid var(--danger);padding:12px;font-size:13px;color:#7c2d12;border-radius:4px}
    .card-actions{border:1px solid var(--border);border-radius:var(--radius);padding:12px;background:#fafafa}
    .action-btn{width:100%;padding:10px;border-radius:6px;font-weight:700;font-size:14px;border:1px solid var(--border);cursor:pointer}
    .agree-btn{background:#e9f5ff;color:var(--primary);margin-bottom:8px}
    .contribute{background:#fff;color:#111827;text-align:center;margin-bottom:10px}
    .small-actions{display:flex;gap:8px}
    .share-btn{width:36px;height:36px;border-radius:6px;border:1px solid var(--border);background:#fff;cursor:pointer}
    .comments{margin-top:18px;border-top:1px solid var(--border);padding-top:14px}
    .comments-toggle{display:flex;justify-content:space-between;cursor:pointer;align-items:center}
    .comments-panel{margin-top:12px;display:flex;flex-direction:column;gap:12px}
    .comment-form{background:#f9fafb;border:1px solid var(--border);border-radius:10px;padding:14px;display:flex;flex-direction:column;gap:10px}
    .comment-form textarea{width:100%;min-height:80px;border-radius:8px;border:1px solid #d1d5db;padding:12px;font-size:14px;resize:vertical}
    .comment-form input{border:1px solid #d1d5db;border-radius:8px;padding:10px;font-size:13px}
    .post-btn{margin-top:8px;background:var(--primary);color:#fff;border-radius:999px;padding:8px 18px;font-weight:700;border:none;cursor:pointer;align-self:flex-end}
    .comment-scroll{max-height:420px;overflow-y:auto;-webkit-overflow-scrolling:touch;padding-right:6px;display:flex;flex-direction:column;gap:12px}
    .comment{background:#fff;border:1px solid var(--border);border-radius:10px;padding:12px}
    .who{display:flex;align-items:center;gap:10px;font-weight:700;color:#111827}
    .who span.time{margin-left:auto;font-weight:600;color:var(--muted);font-size:12px}
    /* ================= COMMENT TIME â€“ SUBTLE & COMPACT ================= */

.who span.time {
  font-size: 11px;              /* smaller text */
  font-weight: 500;             /* not bold */
  color: #9ca3af;               /* muted grey */
  white-space: nowrap;          /* stay in one line */
  margin-left: auto;            /* stay at right */
  line-height: 1;               /* reduce height */
}
    
    .comment p{margin:8px 0 0 0;font-size:14px;line-height:1.6;color:#374151}
    .loading{text-align:center;color:var(--muted);padding:8px 0}
    .comment-scroll::-webkit-scrollbar{width:10px}
    .comment-scroll::-webkit-scrollbar-thumb{background:#e2e8f0;border-radius:10px}
    @media (max-width:900px){.card{flex-direction:column}.aside{width:100%}}
    /* ================= INSTAGRAM-STYLE COMMENTS (FINAL, CORRECT) ================= */

/* Discussion container */
.comments-panel {
  display: flex;
  flex-direction: column-reverse;   /* ðŸ”¥ THIS IS THE KEY */
  max-height: 520px;
  border: 1px solid var(--border);
  border-radius: 10px;
  background: #ffffff;
  overflow: hidden;
}

/* Comment list (ON TOP, scrollable) */
.comment-scroll {
  flex: 1 1 auto;
  overflow-y: auto;
  padding: 14px;
  background: #ffffff;
}

/* Post comment form (STAYS AT BOTTOM) */
.comment-form {
  flex-shrink: 0;
  position: sticky;
  bottom: 0;
  background: #f9fafb;
  border-top: 1px solid var(--border);
  padding: 12px 14px;
  z-index: 2;
}

/* Ensure clean input sizing */
.comment-form textarea,
.comment-form input {
  width: 100%;
  box-sizing: border-box;
}

/* Smooth, modern scrollbar */
.comment-scroll::-webkit-scrollbar {
  width: 6px;
}
.comment-scroll::-webkit-scrollbar-thumb {
  background: #d1d5db;
  border-radius: 6px;
}
.comment-scroll::-webkit-scrollbar-thumb:hover {
  background: #9ca3af;
}

/* ================= COMMUNITY MODAL ================= */
.discussion-overlay{
  position:fixed; inset:0;
  background:rgba(0,0,0,0.5);
  display:none; z-index:999;
}

.discussion-modal{
  position:fixed;
  top:50%; left:50%;
  transform:translate(-50%,-50%);
  width:680px; max-width:95%;
  height:90vh;
  background:#fff;
  border-radius:14px;
  display:none;
  flex-direction:column;
  z-index:1000;
}

.discussion-header{
  padding:14px;
  border-bottom:1px solid #e5e7eb;
  font-weight:800;
  display:flex;
  justify-content:space-between;
}

.discussion-comments{
  flex:1;
  overflow-y:auto;
  padding:14px;
}

.discussion-form{
  border-top:1px solid #e5e7eb;
  padding:12px;
  background:#f9fafb;
}

.discussion-form textarea{
  width:100%; min-height:70px;
  border-radius:8px;
  padding:10px;
}

.discussion-form .row{
  display:flex; gap:8px; margin-top:8px;
}

.discussion-form input{
  flex:1; padding:8px;
  border-radius:8px;
}

.discussion-form button{
      margin-top:8px;
      float:right;
      background:#0079d3;
      color:#fff;
      border:none;
      border-radius:999px;
      padding:8px 18px;
    }

    .comment.pinned {
        background-color: #f0f7ff;
        border: 1px solid #2042e3;
        box-shadow: 0 4px 12px rgba(32, 66, 227, 0.1);
        position: relative;
    }
    
    .comment.pinned .who span:first-of-type {
        color: #2042e3;
        font-weight: 800;
    }
    
  </style>
</head>
<body>
  <div class="wrap">
    <div class="top">
      <div>
        <div class="page-title">Company Alert</div>
        <div class="meta-small">Detailed report and community discussion</div>
      </div>
      <div class="back">
        <a href="${pageContext.request.contextPath}/alerts/list"><i class="fa-solid fa-arrow-left"></i> Back to Alerts</a>
      </div>
    </div>

    <div class="card" role="region" aria-labelledby="company-heading">
      <%-- prepare formattedReportedAt safely using the bean from pageContext --%>
      <%
        Object alertBean = pageContext.getAttribute("alert");
        String formattedReportedAt = "";
        if (alertBean != null) {
          try {
            Object raw = null;
            try {
              java.lang.reflect.Method gm = alertBean.getClass().getMethod("getReportedAt");
              raw = gm.invoke(alertBean);
            } catch (NoSuchMethodException nsme) {
              try { java.lang.reflect.Field f = alertBean.getClass().getField("reportedAt"); raw = f.get(alertBean); } catch (Exception ign) {}
            }
            if (raw != null) {
              ZonedDateTime zdt = null;
              if (raw instanceof java.util.Date) zdt = ((java.util.Date)raw).toInstant().atZone(ZoneId.systemDefault());
              else if (raw instanceof Instant) zdt = ((Instant)raw).atZone(ZoneId.systemDefault());
              else if (raw instanceof LocalDateTime) zdt = ((LocalDateTime)raw).atZone(ZoneId.systemDefault());
              else if (raw instanceof ZonedDateTime) zdt = (ZonedDateTime) raw;
              else if (raw instanceof String) {
                try { zdt = ZonedDateTime.parse((String)raw); } catch(Exception e1) {
                  try { LocalDateTime l = LocalDateTime.parse((String)raw); zdt = l.atZone(ZoneId.systemDefault()); } catch(Exception e2) {}
                }
              }
              if (zdt != null) formattedReportedAt = zdt.format(DateTimeFormatter.ofPattern("d MMM yyyy, h:mm a"));
              else formattedReportedAt = raw.toString();
            }
          } catch(Exception e){ formattedReportedAt = ""; }
        }
        pageContext.setAttribute("formattedReportedAt", formattedReportedAt);
      %>

      <!-- MAIN -->
      <div class="main">
        <div class="company-row">
          <div class="company">
            <div class="logo" aria-hidden="true"><i class="fa-solid fa-building"></i></div>
            <div>
              <h1 id="company-heading" class="company-name"><c:out value="${alert.companyName}"/></h1>
              <div class="meta"><c:out value="${formattedReportedAt}"/></div>
            </div>
          </div>

          <div>
            <span class="badge"><i class="fa-solid fa-user"></i> User reported</span>
          </div>
        </div>

        <div class="meta-row">
          <c:if test="${not empty alert.industry}"><div class="chip"><i class="fa-solid fa-industry"></i>&nbsp;<c:out value="${alert.industry}"/></div></c:if>
          <c:if test="${not empty alert.location}"><div class="chip"><i class="fa-solid fa-location-dot"></i>&nbsp;<c:out value="${alert.location}"/></div></c:if>
        <%--   <div style="color:var(--muted); font-size:13px;">ID: <c:out value="${alert.id}"/></div> --%>
        </div>

        <div class="section">
          <h4>Reported Issue</h4>
          <div class="value"><c:out value="${alert.issueType}"/></div>
        </div>

        <div class="section">
          <h4>Detailed Description</h4>
          <div class="value"><c:out value="${alert.reportReason}"/></div>
        </div>

        <c:if test="${not empty alert.howDidYouKnow}">
          <div class="section">
            <h4>How the reporter knows</h4>
            <div class="value"><c:out value="${alert.howDidYouKnow}"/></div>
          </div>
        </c:if>

        <c:if test="${not empty alert.roleMentioned}">
          <div class="section">
            <h4>Role Mentioned</h4>
            <div class="value"><c:out value="${alert.roleMentioned}"/></div>
          </div>
        </c:if>

        <c:if test="${not empty alert.website}">
          <div class="section">
            <h4>Website</h4>
            <div class="value"><a href="${alert.website}" target="_blank" rel="noopener noreferrer"><c:out value="${alert.website}"/></a></div>
          </div>
        </c:if>

        <c:if test="${not empty alert.linkedinUrl}">
          <div class="section">
            <h4>LinkedIn</h4>
            <div class="value"><a href="${alert.linkedinUrl}" target="_blank" rel="noopener noreferrer">View Company Page</a></div>
          </div>
        </c:if>

        <div class="notice" role="note" aria-live="polite">
          <i class="fa-solid fa-shield-halved" style="color:var(--primary); font-size:18px; margin-top:2px;"></i>
          <div>These reports are community-submitted and may not be independently verified by Jobu. Use your discretion — read details and comments carefully.</div>
        </div>
      </div>

      <!-- ASIDE -->
      <aside class="aside" aria-label="Actions and community">
        <div class="card-actions">
          <button id="agreeBtn_<c:out value='${alert.id}'/>"
                  class="action-btn agree-btn"
                  onclick="agreeReport('<c:out value='${alert.id}'/>', this)"
                  aria-pressed="false"
                  title="If you faced the same">
            <i class="fa-regular fa-thumbs-up"></i>
            <span style="margin-left:8px;">I faced the same</span>
            <span id="agreeCount_<c:out value='${alert.id}'/>" style="margin-left:10px;font-weight:800;"><c:out value="${alert.agreeCount}"/></span>
          </button>

          <a class="action-btn contribute" href="${pageContext.request.contextPath}/alerts/report?company=${fn:escapeXml(alert.companyName)}" style="text-decoration:none; display:inline-flex; justify-content:center;">
            <i class="fa-solid fa-pen-to-square"></i>&nbsp;<span>Add your experience</span>
          </a>

          <div class="small-actions" aria-hidden="false">
            <button class="share-btn" title="WhatsApp" onclick="shareWhatsApp()"><i class="fa-brands fa-whatsapp" style="color:#25D366"></i></button>
            <button class="share-btn" title="LinkedIn" onclick="shareLinkedIn()"><i class="fa-brands fa-linkedin" style="color:#0A66C2"></i></button>
            <button class="share-btn" title="Facebook" onclick="shareFacebook()"><i class="fa-brands fa-facebook" style="color:#1877F2"></i></button>
            <button class="share-btn" title="Copy link" onclick="copyLink()" id="copyBtn"><i class="fa-solid fa-link" style="color:#6b7280"></i></button>
          </div>
        </div>

        <div class="comments" id="commentsRoot">
          <div class="comments-toggle" id="commentsToggle" onclick="openDiscussion()"
">
            <div style="display:flex;align-items:center;gap:10px;">
              <i class="fa-solid fa-comments" style="color:var(--primary);"></i>
              <div>
                <div style="font-weight:800;">Community Discussion</div>
                <div style="font-size:13px;color:var(--muted);">Share experience, ask questions</div>
              </div>
            </div>
            <div id="commentsCount" style="font-weight:700;color:var(--muted);">(<c:out value="${fn:length(comments)}"/>)</div>
          </div>

          <div class="comments-panel" id="commentsPanel" aria-hidden="true">


            <div class="comment-scroll" id="commentScroll" role="list" aria-live="polite">
              <c:set var="pageSize" value="20" />
              <c:forEach var="cmt" items="${comments}" varStatus="vs">
                <c:if test="${vs.index lt pageSize}">
                  <c:set var="isPinned" value="${vs.index == 0 and cmt.adminComment}" />
                  <div class="comment ${isPinned ? 'pinned' : ''}" role="listitem" data-comment-id="${cmt.id}">
                    <div class="who">
                      <c:choose>
                        <c:when test="${isPinned}">
                          <i class="fas fa-thumbtack" style="color:#2042e3; transform:rotate(45deg);"></i>
                          <span style="color:#2042e3; font-weight:800;">Pinned Message</span>
                        </c:when>
                        <c:otherwise>
                          <i class="fa-solid fa-user" style="color:var(--primary)"></i>
                          <span><c:out value="${empty cmt.commenterName ? 'Anonymous' : cmt.commenterName}"/></span>
                        </c:otherwise>
                      </c:choose>
                      <%
    String formattedCommentTime = "";
    Object rawTime = pageContext.findAttribute("cmt") != null
            ? ((in.sp.main.Entities.CompanyAlertComment)pageContext.findAttribute("cmt")).getCommentedAt()
            : null;

    if (rawTime != null) {
        if (rawTime instanceof LocalDateTime) {
            formattedCommentTime =
                ((LocalDateTime) rawTime)
                .format(DateTimeFormatter.ofPattern("d MMM yyyy, h:mm a"));
        } else if (rawTime instanceof java.util.Date) {
            formattedCommentTime =
                ((java.util.Date) rawTime)
                .toInstant()
                .atZone(ZoneId.systemDefault())
                .format(DateTimeFormatter.ofPattern("d MMM yyyy, h:mm a"));
        } else {
            formattedCommentTime = rawTime.toString();
        }
    }
%>

<span class="time"><%= formattedCommentTime %></span>

                    </div>
                    <p><c:out value="${cmt.commentText}"/></p>
                  </div>
                </c:if>
              </c:forEach>

              <c:set var="totalComments" value="${fn:length(comments)}" />
              <c:set var="hasMore" value="${totalComments gt pageSize}" />
              <div id="loadMoreIndicator" class="loading" style="${hasMore ? '' : 'display:none'}">Scroll to load more...</div>
            </div>
          </div>
        </div>
      </aside>
    </div>
  </div>


<!-- ================= COMMUNITY DISCUSSION MODAL ================= -->
<div class="discussion-overlay" id="discussionOverlay" onclick="closeDiscussion()"></div>

<div class="discussion-modal" id="discussionModal">
  <div class="discussion-header">
    <span>Community Discussion</span>
    <button onclick="closeDiscussion()">✕</button>
  </div>

  <!-- COMMENTS -->
  <div class="discussion-comments">
      <c:forEach var="cmt" items="${comments}" varStatus="vs">
       <c:set var="isPinned" value="${vs.index == 0 and cmt.adminComment}" />
       <div class="comment ${isPinned ? 'pinned' : ''}">
          <div class="who">
            <c:choose>
               <c:when test="${isPinned}">
                  <i class="fas fa-thumbtack" style="color:#2042e3; transform:rotate(45deg);"></i>
                  <span style="color:#2042e3; font-weight:800;">Pinned Message</span>
               </c:when>
               <c:otherwise>
                  <i class="fa-solid fa-user"></i>
                  <span><c:out value="${empty cmt.commenterName ? 'Anonymous' : cmt.commenterName}"/></span>
               </c:otherwise>
            </c:choose>

          <%-- DATE FORMAT (SCRIPTLET ONLY) --%>
         <%
    in.sp.main.Entities.CompanyAlertComment cmtBean =
        (in.sp.main.Entities.CompanyAlertComment) pageContext.getAttribute("cmt");

    String formattedCommentTime = "";

    if (cmtBean != null && cmtBean.getCommentedAt() != null) {
        Object rawTime = cmtBean.getCommentedAt();

        if (rawTime instanceof LocalDateTime) {
            formattedCommentTime =
                ((LocalDateTime) rawTime)
                .format(DateTimeFormatter.ofPattern("d MMM yyyy, h:mm a"));

        } else if (rawTime instanceof java.util.Date) {
            formattedCommentTime =
                ((java.util.Date) rawTime)
                .toInstant()
                .atZone(ZoneId.systemDefault())
                .format(DateTimeFormatter.ofPattern("d MMM yyyy, h:mm a"));

        } else {
            formattedCommentTime = rawTime.toString();
        }
    }
%>

<span class="time"><%= formattedCommentTime %></span>

        </div>
        <p><c:out value="${cmt.commentText}"/></p>
      </div>
    </c:forEach>
  </div>

  <!-- FIXED POST FORM -->
  <form class="discussion-form"
        action="${pageContext.request.contextPath}/alerts/${alert.id}/comment"
        method="post">
    <textarea name="commentText" placeholder="Add a comment…" required></textarea>
    <div class="row">
      <input type="text" name="commenterName" placeholder="Name (optional)">
      <input type="email" name="commenterEmail" placeholder="Email (optional)">
    </div>
    <button type="submit">Post</button>
  </form>
</div>


  <script>
    (function(){
      const alertId = '<c:out value="${alert.id}"/>';
      const commentScroll = document.getElementById('commentScroll');
      const commentsCountEl = document.getElementById('commentsCount');
      const pageSize = parseInt('<c:out value="${pageSize}"/>', 10) || 20;
      let currentPage = 1;
      let loading = false;
      let hasMore = <c:out value="${hasMore}" />;

      window.toggleComments = function() {
        const panel = document.getElementById('commentsPanel');
        const hidden = panel.getAttribute('aria-hidden') === 'true';
        panel.style.display = hidden ? 'flex' : 'none';
        panel.setAttribute('aria-hidden', !hidden);
        if (hidden) setTimeout(()=>{ document.getElementById('commentText').focus(); }, 250);
      };

      if (commentScroll) {
        commentScroll.addEventListener('scroll', function() {
          if (!hasMore || loading) return;
          const threshold = 140;
          if (commentScroll.scrollHeight - commentScroll.scrollTop - commentScroll.clientHeight < threshold) {
            loadNextPage();
          }
        });
      }

      function appendComments(comments) {
        if (!comments || comments.length === 0) return;
        comments.forEach(function(cmt) {
          const div = document.createElement('div');
          div.className = 'comment';
          div.setAttribute('role','listitem');
          if (cmt.id) div.dataset.commentId = cmt.id;
          // build HTML using string concatenation to avoid JSP EL eval issues
          const commenterName = escapeHtml(cmt.commenterName || 'Anonymous');
          const commentedAt = escapeHtml(cmt.commentedAt || '');
          const commentText = escapeHtml(cmt.commentText || '');
          let html = '<div class="who">' +
                       '<i class="fa-solid fa-user" style="color:var(--primary)"></i>' +
                       '<span>' + commenterName + '</span>' +
                       '<span class="time">' + commentedAt + '</span>' +
                     '</div>' +
                     '<p>' + commentText + '</p>';
          div.innerHTML = html;
          commentScroll.appendChild(div);
        });
        // update count (extract numeric and add)
        const current = parseInt(commentsCountEl.textContent.replace(/[()]/g,''),10) || 0;
        commentsCountEl.textContent = '(' + (current + comments.length) + ')';
      }

      async function loadNextPage() {
        loading = true;
        currentPage += 1;
        const indicator = document.getElementById('loadMoreIndicator');
        if (indicator) indicator.textContent = 'Loading...';
        try {
          const resp = await fetch(window.location.origin + '${pageContext.request.contextPath}' + '/alerts/' + encodeURIComponent(alertId) + '/comments?page=' + currentPage + '&pageSize=' + pageSize, {
            headers: { 'Accept': 'application/json' }
          });
          if (!resp.ok) throw new Error('Network response was not ok');
          const payload = await resp.json();
          appendComments(payload.comments || []);
          hasMore = !!payload.hasMore;
          if (!hasMore && indicator) indicator.style.display = 'none';
          else if (indicator) indicator.textContent = 'Scroll to load more...';
        } catch (err) {
          console.error('Failed to load comments:', err);
          const indicator = document.getElementById('loadMoreIndicator');
          if (indicator) indicator.textContent = 'Unable to load more comments';
          currentPage -= 1;
        } finally {
          loading = false;
        }
      }

      window.agreeReport = function(id, btn) {
        const countEl = document.getElementById('agreeCount_' + id);
        if (!countEl) return;
        const current = parseInt(countEl.innerText || '0',10);
        countEl.innerText = current + 1;
        btn.setAttribute('disabled','true');
        btn.setAttribute('aria-pressed','true');

        fetch('${pageContext.request.contextPath}/alerts/' + encodeURIComponent(id) + '/agree', {
          method:'POST', headers:{'Content-Type':'application/json'}, body:JSON.stringify({})
        }).then(function(res){
          if (!res.ok) {
            countEl.innerText = current;
            btn.removeAttribute('disabled');
            btn.setAttribute('aria-pressed','false');
            alert('Unable to record your response.');
          }
        }).catch(function(){
          countEl.innerText = current;
          btn.removeAttribute('disabled');
          btn.setAttribute('aria-pressed','false');
          alert('Network error.');
        });
      };

      window.shareWhatsApp = function(){ window.open('https://wa.me/?text=' + encodeURIComponent('Important company alert on Jobu — please read:') + '%20' + encodeURIComponent(window.location.href), '_blank'); };
      window.shareLinkedIn = function(){ window.open('https://www.linkedin.com/sharing/share-offsite/?url=' + encodeURIComponent(window.location.href), '_blank'); };
      window.shareFacebook = function(){ window.open('https://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(window.location.href), '_blank'); };
      window.copyLink = function(){ navigator.clipboard.writeText(window.location.href).then(()=>{ const btn = document.getElementById('copyBtn'); const old = btn.innerHTML; btn.innerHTML = '<i class="fa-solid fa-check" style="color:var(--success)"></i>'; setTimeout(()=>btn.innerHTML = old,1500); }); };

      window.submitComment = async function(form) {
        const text = form.commentText.value.trim();
        if (!text) { alert('Please enter a comment.'); return false; }
        const payload = {
          commenterName: form.commenterName.value || null,
          commenterEmail: form.commenterEmail.value || null,
          commentText: text
        };
        // optimistic UI: prepend temp comment
        const tmpId = 'tmp-' + Date.now();
        const tmpDiv = document.createElement('div');
        tmpDiv.className = 'comment';
        tmpDiv.id = tmpId;
        const nameEsc = escapeHtml(payload.commenterName || 'You');
        const textEsc = escapeHtml(payload.commentText || '');
        tmpDiv.innerHTML = '<div class="who"><i class="fa-solid fa-user" style="color:var(--primary)"></i><span>' + nameEsc + '</span><span class="time">just now</span></div><p>' + textEsc + '</p>';
        if (document.getElementById('commentsPanel').getAttribute('aria-hidden') === 'true') toggleComments();
        commentScroll.insertBefore(tmpDiv, commentScroll.firstChild);
        form.commentText.value = '';
        form.commenterName.value = '';
        form.commenterEmail.value = '';
        try {
          const resp = await fetch(form.action, {
            method: form.method || 'POST',
            headers: { 'Content-Type':'application/json', 'Accept':'application/json' },
            body: JSON.stringify(payload)
          });
          if (!resp.ok) throw new Error('Network response not ok');
          const resJson = await resp.json();
          if (resJson && resJson.comment) {
            const real = document.createElement('div');
            real.className = 'comment';
            real.setAttribute('role','listitem');
            if (resJson.comment.id) real.dataset.commentId = resJson.comment.id;
            const rn = escapeHtml(resJson.comment.commenterName || 'Anonymous');
            const rt = escapeHtml(resJson.comment.commentedAt || '');
            const rc = escapeHtml(resJson.comment.commentText || '');
            real.innerHTML = '<div class="who"><i class="fa-solid fa-user" style="color:var(--primary)"></i><span>' + rn + '</span><span class="time">' + rt + '</span></div><p>' + rc + '</p>';
            commentScroll.replaceChild(real, tmpDiv);
          } else {
            const timeEl = tmpDiv.querySelector('.time');
            if (timeEl) timeEl.textContent = (new Date()).toLocaleString();
          }
          const current = parseInt(commentsCountEl.textContent.replace(/[()]/g,''),10) || 0;
          commentsCountEl.textContent = '(' + (current + 1) + ')';
        } catch (err) {
          console.error('Comment post failed', err);
          if (tmpDiv && tmpDiv.parentNode) tmpDiv.parentNode.removeChild(tmpDiv);
          alert('Failed to post comment. You can try again or reload the page.');
          return false;
        }
        return false;
      };

      function escapeHtml(str) {
        if (!str) return '';
        return String(str)
          .replace(/&/g, '&amp;')
          .replace(/</g, '&lt;')
          .replace(/>/g, '&gt;')
          .replace(/"/g, '&quot;')
          .replace(/'/g, '&#39;');
      }
    })();
    
    function openDiscussion(){
    	  document.getElementById('discussionModal').style.display='flex';
    	  document.getElementById('discussionOverlay').style.display='block';
    	}

    	function closeDiscussion(){
    	  document.getElementById('discussionModal').style.display='none';
    	  document.getElementById('discussionOverlay').style.display='none';
    	}

  </script>
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

