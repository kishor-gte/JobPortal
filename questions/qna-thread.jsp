<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Q&A Thread - View</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        :root {
            --primary: #2042e3;
            --primary-hover: #081828;
            --bg-light: #f6f9fc;
            --text-main: #081828;
            --text-muted: #7E8890;
            --card-bg: #ffffff;
            --box-shadow: rgba(35, 38, 45, 0.15);
            --border: #eee;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-light);
            color: var(--text-main);
            padding: 40px 20px;
            margin: 0;
        }

        .thread-container {
            max-width: 960px;
            margin: auto;
            background-color: var(--card-bg);
            border-radius: 12px;
            box-shadow: 0 4px 12px var(--box-shadow);
            padding: 30px;
        }

        .section-title {
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .meta {
            font-size: 13px;
            color: var(--text-muted);
            margin-bottom: 16px;
        }

        .answer-box {
            border-left: 4px solid var(--primary);
            background: #f1f5ff;
            padding: 18px;
            border-radius: 10px;
            margin-bottom: 24px;
        }

        .reply {
            margin-left: 30px;
            padding: 12px 16px;
            background-color: #f9fafb;
            border-left: 3px dashed var(--border);
            border-radius: 6px;
            margin-top: 12px;
        }

        .comment-form, .reply-form {
            margin-top: 16px;
        }

        textarea {
            width: 100%;
            min-height: 70px;
            border-radius: 8px;
            border: 1px solid #ccc;
            padding: 10px;
            font-size: 14px;
            margin-top: 10px;
        }

        .btn {
            background-color: var(--primary);
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            margin-top: 10px;
            cursor: pointer;
            font-weight: 600;
            box-shadow: 0 2px 5px rgba(0,0,0,0.08);
        }

        .btn:hover {
            background-color: var(--primary-hover);
        }

        .action-links {
            display: flex;
            gap: 16px;
            margin-bottom: 10px;
        }

        .action-links button {
            background: none;
            border: none;
            color: var(--primary);
            font-size: 14px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 0;
        }

        .action-links button:hover {
            text-decoration: underline;
        }

        .hidden {
            display: none;
        }

        i {
            font-size: 14px;
        }
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

<div class="thread-container">
    <!-- Question Section -->
    <div class="section-title"><i class="fas fa-question-circle"></i> ${thread.content}</div>
    <p class="meta">Asked by <strong>${thread.displayName}</strong> | ${thread.postedAt}</p>

    <!-- Admin Answer -->
    <c:if test="${not empty thread.answer}">
        <div class="answer-box">
            <strong><i class="fas fa-user-shield"></i> Admin:</strong>
            <p style="margin-top: 6px;">${thread.answer.content}</p>
            <p class="meta">Answered at ${thread.answer.answeredAt}</p>

            <div class="action-links">
                <button onclick="toggle('replies-to-answer')"><i class="fas fa-comments"></i> View Replies</button>
                <button onclick="toggle('reply-to-answer-form')"><i class="fas fa-reply"></i> Reply</button>
            </div>

            <!-- Replies to Answer -->
            <div id="replies-to-answer" class="hidden">
                <c:forEach var="comment" items="${thread.comments}">
                    <c:if test="${comment.parentType == 'ANSWER'}">
                        <div class="reply">
                            <p>${comment.content}</p>
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
    <div class="section-title"><i class="fas fa-comments"></i> Public Comments</div>
    <c:forEach var="comment" items="${thread.comments}">
        <c:if test="${comment.parentType == 'QUESTION'}">
            <div class="reply">
                <p>${comment.content}</p>
                <small class="meta"><strong>${comment.displayName}</strong> at ${comment.commentedAt}</small>
            </div>
        </c:if>
    </c:forEach>

    <!-- Add Public Comment -->
    <div class="action-links" style="margin-top: 20px;">
        <button onclick="toggle('comment-on-question-form')"><i class="fas fa-comment-dots"></i> Add Comment</button>
    </div>

    <form id="comment-on-question-form" class="comment-form hidden" action="${pageContext.request.contextPath}/qna/thread/${thread.id}/comment" method="post">
        <input type="hidden" name="parentType" value="QUESTION"/>
        <input type="hidden" name="parentId" value="${thread.id}"/>
        <textarea name="content" required placeholder="Write a public comment..."></textarea>
        <button type="submit" class="btn"><i class="fas fa-paper-plane"></i> Post Comment</button>
    </form>
</div>

</body>
</html>
