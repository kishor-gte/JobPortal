<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Q&A Forum</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        :root {
            --primary: #2042e3;
            --primary-hover: #081828;
            --bg-light: #f6f9fc;
            --text-main: #081828;
            --text-muted: #7E8890;
            --card-bg: #ffffff;
            --box-shadow: rgba(35, 38, 45, 0.1);
            --border: #eee;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-light);
            color: var(--text-main);
            padding: 40px 20px;
            margin: 0;
        }

        h1 {
            font-size: 28px;
            text-align: center;
            margin-bottom: 10px;
        }

        .ask-toggle {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .ask-toggle button {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 10px 18px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 600;
            box-shadow: 0 3px 8px var(--box-shadow);
        }

        .ask-toggle button:hover {
            background-color: var(--primary-hover);
        }

        .ask-form {
            background-color: var(--card-bg);
            border: 2px dashed var(--primary);
            padding: 20px;
            border-radius: 12px;
            margin: 0 auto 40px auto;
            max-width: 800px;
            box-shadow: 0 2px 6px var(--box-shadow);
            display: none;
        }

        .ask-form textarea,
        .ask-form input[type="text"] {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .ask-form button[type="submit"] {
            background-color: var(--primary);
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
        }

        .ask-form button[type="submit"]:hover {
            background-color: var(--primary-hover);
        }

        h2 {
            text-align: center;
            font-size: 22px;
            margin-bottom: 20px;
        }

        .question-card {
            background-color: var(--card-bg);
            padding: 20px;
            margin: 0 auto 20px auto;
            max-width: 800px;
            border-radius: 12px;
            border: 1px solid var(--border);
            box-shadow: 0 2px 5px var(--box-shadow);
        }

        .question-card p {
            margin: 6px 0;
            font-size: 15px;
        }

        .question-card i {
            color: var(--primary);
            margin-right: 6px;
        }

        .question-card a {
            text-decoration: none;
            color: var(--primary);
            font-weight: 500;
            display: inline-block;
            margin-top: 10px;
        }

        .question-card a:hover {
            color: var(--primary-hover);
            text-decoration: underline;
        }

        .meta {
            font-size: 13px;
            color: var(--text-muted);
        }
    </style>

    <script>
        function toggleAskForm() {
            const form = document.getElementById("askForm");
            form.style.display = form.style.display === "none" ? "block" : "none";
        }
    </script>
</head>
<body>

    <h1><i class="fas fa-comments"></i> Q&A Forum</h1>

    <!-- Toggle Button -->
    <div class="ask-toggle">
        <button onclick="toggleAskForm()">
            <i class="fas fa-circle-question"></i> Ask a Question
        </button>
    </div>

    <!-- Collapsible Ask Form -->
    <div class="ask-form" id="askForm">
        <form action="${pageContext.request.contextPath}/qna/ask" method="post">
            <textarea name="content" required placeholder="Type your question here..."></textarea>
            <input type="text" name="displayName" placeholder="Your name (optional)">
            <button type="submit"><i class="fas fa-paper-plane"></i> Submit Question</button>
        </form>
    </div>

    <h2><i class="fas fa-list"></i> Recent Questions</h2>

    <c:forEach var="q" items="${threads}">
        <div class="question-card">
            <p><i class="fas fa-question-circle"></i> <strong>Q:</strong> ${q.content}</p>
            <p class="meta"><i class="fas fa-user"></i> ${q.displayName} &nbsp; | &nbsp; <i class="fas fa-clock"></i> ${q.postedAt}</p>
            <a href="${pageContext.request.contextPath}/qna/thread/${q.id}"><i class="fas fa-eye"></i> View Full Thread</a>
        </div>
    </c:forEach>

</body>
</html>
