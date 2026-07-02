<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin: Manage Q&A</title>
    <style>
        :root {
            --primary: #2042e3;
            --primary-hover: #081828;
            --bg-light: #f6f9fc;
            --text-main: #081828;
            --text-muted: #7E8890;
            --card-bg: #ffffff;
            --box-shadow: rgba(35, 38, 45, 0.15);
            --border-dashed: #eee;
        }

        body {
            background-color: var(--bg-light);
            font-family: 'Inter', sans-serif;
            color: var(--text-main);
            padding: 40px;
        }

        h2 {
            font-size: 28px;
            text-align: center;
            margin-bottom: 30px;
        }

        .question-card {
            background-color: var(--card-bg);
            border-radius: 12px;
            box-shadow: 0 4px 12px var(--box-shadow);
            margin-bottom: 24px;
            padding: 20px;
            transition: box-shadow 0.3s ease;
        }

        .question-card:hover {
            box-shadow: 0 6px 20px rgba(35, 38, 45, 0.25);
        }

        .question-header {
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 6px;
        }

        .meta {
            font-size: 13px;
            color: var(--text-muted);
            margin-bottom: 10px;
        }

        .answer-preview {
            background: var(--bg-light);
            border-left: 4px solid var(--primary);
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 10px;
            font-size: 14px;
            color: var(--text-main);
        }

        textarea {
            width: 100%;
            min-height: 80px;
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
            margin-top: 10px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 2px 6px rgba(35, 38, 45, 0.1);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .btn:hover {
            background-color: var(--primary-hover);
            box-shadow: 0 4px 12px rgba(35, 38, 45, 0.2);
        }

        .btn-delete {
            background-color: transparent;
            color: red;
            border: 1px dashed red;
            margin-left: 10px;
        }

        .btn-delete:hover {
            background-color: rgba(255, 0, 0, 0.05);
        }

        .action-bar {
            margin-top: 8px;
        }

        .toggle-section {
            display: none;
            margin-top: 10px;
        }
    </style>

    <script>
        function toggleAnswerForm(id) {
            const section = document.getElementById("form-" + id);
            section.style.display = section.style.display === "none" ? "block" : "none";
        }
    </script>
</head>
<body>

<h2>Q&A Moderator Panel</h2>

<c:forEach var="q" items="${questions}">
    <div class="question-card">
        <div class="question-header">Q: ${q.content}</div>
        <div class="meta">Asked by: ${q.displayName} | <i>${formattedTimestamps[q.id]}</i></div>

        <c:if test="${not empty q.answer}">
            <div class="answer-preview">
                <strong>Answer:</strong> ${q.answer.content}
            </div>
        </c:if>

        <div class="action-bar">
            <button class="btn" onclick="toggleAnswerForm('${q.id}')">
                ${not empty q.answer ? 'Edit Answer' : 'Answer'}
            </button>

            <form action="${pageContext.request.contextPath}/qna/admin/qna/delete" method="post" style="display:inline;">
                <input type="hidden" name="questionId" value="${q.id}" />
                <button type="submit" class="btn btn-delete">Delete</button>
            </form>
        </div>

        <div class="toggle-section" id="form-${q.id}">
            <form action="${pageContext.request.contextPath}/qna/admin/qna/answer" method="post">
                <input type="hidden" name="questionId" value="${q.id}" />
                <textarea name="content" required placeholder="Write your answer here...">${q.answer.content}</textarea>
                <button type="submit" class="btn">Post / Update</button>
            </form>
        </div>
    </div>
</c:forEach>

</body>
</html>
