<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Q&A Thread | JobU - Community Discussion</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    
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
            padding: 2rem;
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

        /* Premium Container */
        .thread-container {
            max-width: 1100px;
            margin: 0 auto;
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.1);
            padding: 2.5rem;
            position: relative;
            z-index: 2;
            animation: fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px) scale(0.96); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .thread-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--accent), var(--primary));
            border-radius: var(--radius-lg) var(--radius-lg) 0 0;
        }

        /* Section Title */
        .section-title {
            font-size: 1.3rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 1rem;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title i {
            color: var(--primary);
            font-size: 1.3rem;
        }

        /* Meta Info */
        .meta {
            font-size: 0.75rem;
            color: var(--text-muted);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            flex-wrap: wrap;
        }

        .meta i {
            color: var(--primary);
            width: 16px;
        }

        /* Question Section */
        .question-content {
            background: rgba(25,167,123,0.03);
            border-radius: var(--radius-md);
            padding: 1.25rem;
            margin-bottom: 1.5rem;
        }

        .question-text {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--text-dark);
            line-height: 1.5;
            margin-bottom: 1rem;
        }

        /* Answer Box Premium */
        .answer-box {
            background: linear-gradient(135deg, rgba(25,167,123,0.06), rgba(59,196,154,0.03));
            border-left: 4px solid var(--primary);
            border-radius: var(--radius-md);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: var(--transition);
        }

        .answer-box:hover {
            background: rgba(25,167,123,0.08);
        }

        .answer-header {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.75rem;
        }

        .admin-badge {
            background: var(--primary);
            color: white;
            padding: 0.2rem 0.6rem;
            border-radius: 40px;
            font-size: 0.7rem;
            font-weight: 700;
        }

        /* Reply/Comment Box */
        .reply {
            margin-left: 2rem;
            padding: 1rem;
            background: rgba(25,167,123,0.03);
            border-left: 3px solid var(--accent);
            border-radius: var(--radius-sm);
            margin-top: 0.75rem;
            transition: var(--transition);
        }

        .reply:hover {
            background: rgba(25,167,123,0.06);
            transform: translateX(4px);
        }

        /* Action Links */
        .action-links {
            display: flex;
            gap: 1rem;
            margin: 1rem 0;
        }

        .action-links button {
            background: none;
            border: none;
            color: var(--primary);
            font-size: 0.8rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.4rem 0.8rem;
            border-radius: 40px;
            transition: var(--transition);
        }

        .action-links button:hover {
            background: rgba(25,167,123,0.1);
            transform: translateY(-2px);
        }

        /* Forms */
        .comment-form, .reply-form {
            margin-top: 1rem;
            animation: slideDown 0.3s ease-out;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        textarea {
            width: 100%;
            min-height: 100px;
            border-radius: var(--radius-sm);
            border: 2px solid #e2ede7;
            padding: 0.9rem;
            font-size: 0.9rem;
            font-family: 'Inter', sans-serif;
            transition: var(--transition);
            resize: vertical;
        }

        textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.12);
        }

        .btn {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 700;
            margin-top: 0.75rem;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
        }

        .hidden {
            display: none;
        }

        /* Responsive */
        @media (max-width: 768px) {
            body { padding: 1rem; }
            .thread-container { padding: 1.5rem; }
            .question-text { font-size: 1rem; }
            .reply { margin-left: 0.75rem; }
            .action-links { flex-wrap: wrap; }
        }

        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::selection { background: var(--primary); color: white; }
    </style>

    <script>
        function toggle(id) {
            const el = document.getElementById(id);
            if (el) {
                el.classList.toggle('hidden');
            }
        }
    </script>
</head>
<body>

<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<div class="thread-container">
    <!-- Question Section -->
    <div class="question-content">
        <div class="section-title"><i class="fas fa-question-circle"></i> Question</div>
        <div class="question-text">${thread.content}</div>
        <div class="meta">
            <span><i class="fas fa-user"></i> Asked by <strong>${thread.displayName}</strong></span>
            <span><i class="fas fa-clock"></i> ${thread.postedAt}</span>
        </div>
    </div>

    <!-- Admin Answer -->
    <c:if test="${not empty thread.answer}">
        <div class="answer-box">
            <div class="answer-header">
                <i class="fas fa-user-shield" style="color: var(--primary);"></i>
                <span class="admin-badge">Admin Response</span>
            </div>
            <p style="margin: 0.5rem 0 0.75rem; line-height: 1.6;">${thread.answer.content}</p>
            <div class="meta">
                <span><i class="fas fa-calendar-check"></i> Answered at ${thread.answer.answeredAt}</span>
            </div>

            <div class="action-links">
                <button onclick="toggle('replies-to-answer')"><i class="fas fa-comments"></i> View Replies</button>
                <button onclick="toggle('reply-to-answer-form')"><i class="fas fa-reply"></i> Reply to Answer</button>
            </div>

            <!-- Replies to Answer -->
            <div id="replies-to-answer" class="hidden">
                <c:forEach var="comment" items="${thread.comments}">
                    <c:if test="${comment.parentType == 'ANSWER'}">
                        <div class="reply">
                            <p style="margin-bottom: 0.5rem;">${comment.content}</p>
                            <small class="meta"><strong>${comment.displayName}</strong> at ${comment.commentedAt}</small>
                        </div>
                    </c:if>
                </c:forEach>
            </div>

            <!-- Reply Form -->
            <form id="reply-to-answer-form" class="reply-form hidden" action="${pageContext.request.contextPath}/qna/thread/${thread.id}/comment" method="post">
                <input type="hidden" name="parentType" value="ANSWER"/>
                <input type="hidden" name="parentId" value="${thread.answer.id}"/>
                <textarea name="content" required placeholder="Reply to this answer..."></textarea>
                <button type="submit" class="btn"><i class="fas fa-paper-plane"></i> Post Reply</button>
            </form>
        </div>
    </c:if>

    <!-- Public Comments -->
    <div class="section-title" style="margin-top: 0.5rem;"><i class="fas fa-comments"></i> Public Comments</div>
    <c:forEach var="comment" items="${thread.comments}">
        <c:if test="${comment.parentType == 'QUESTION'}">
            <div class="reply">
                <p style="margin-bottom: 0.5rem;">${comment.content}</p>
                <small class="meta"><strong>${comment.displayName}</strong> at ${comment.commentedAt}</small>
            </div>
        </c:if>
    </c:forEach>

    <!-- Add Public Comment -->
    <div class="action-links" style="margin-top: 1.5rem;">
        <button onclick="toggle('comment-on-question-form')"><i class="fas fa-comment-dots"></i> Add Comment</button>
    </div>

    <form id="comment-on-question-form" class="comment-form hidden" action="${pageContext.request.contextPath}/qna/thread/${thread.id}/comment" method="post">
        <input type="hidden" name="parentType" value="QUESTION"/>
        <input type="hidden" name="parentId" value="${thread.id}"/>
        <textarea name="content" required placeholder="Write a public comment..."></textarea>
        <button type="submit" class="btn"><i class="fas fa-paper-plane"></i> Post Comment</button>
    </form>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
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
    const textareas = document.querySelectorAll('textarea');
    textareas.forEach(textarea => {
        textarea.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                if (this.value.trim() !== '') {
                    this.closest('form').submit();
                }
            }
        });
    });
});
</script>
</body>
</html>