<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${competition.title} - Exam</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/codemirror.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/theme/dracula.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/addon/hint/show-hint.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/addon/fold/foldgutter.min.css">
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #ffffff;
            --text-secondary: rgba(255, 255, 255, 0.85);
            --text-tertiary: rgba(255, 255, 255, 0.5);
            --border-color: rgba(255, 255, 255, 0.08);
            --card-bg: rgba(46, 62, 65, 0.6);
            --hover-bg: rgba(25, 167, 123, 0.15);
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --gradient-dark: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-darker) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.15);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.2);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.3);
            --glow-primary: 0 0 30px rgba(25, 167, 123, 0.2);
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--gradient-dark);
            color: var(--text-primary);
            min-height: 100vh;
            overflow: hidden;
            position: relative;
        }

        /* Animated background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.08) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: backgroundPulse 15s ease-in-out infinite;
        }

        @keyframes backgroundPulse {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }

        /* ===== TOP NAVBAR ===== */
        .top-navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            height: 56px;
            background: rgba(26, 42, 44, 0.95);
            border-bottom: 1px solid var(--border-color);
            backdrop-filter: blur(20px);
            z-index: 200;
            position: relative;
        }
        .nav-left { display: flex; align-items: center; gap: 16px; }
        .nav-title {
            font-size: 16px;
            font-weight: 700;
            background: linear-gradient(135deg, #fff, var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .nav-center { display: flex; align-items: center; gap: 12px; }
        .lang-selector { display: flex; align-items: center; gap: 10px; }
        .lang-selector label { font-size: 12px; color: var(--text-tertiary); text-transform: uppercase; letter-spacing: 1px; font-weight: 600; }
        .lang-selector select {
            padding: 8px 36px 8px 14px; background: var(--card-bg); border: 1px solid var(--border-color);
            border-radius: 30px; color: var(--text-primary); font-size: 13px; font-weight: 500; cursor: pointer; outline: none; appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%2319A77B' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");
            background-repeat: no-repeat; background-position: right 12px center;
        }
        .nav-right { display: flex; align-items: center; gap: 12px; }
        .timer-badge { display: flex; align-items: center; gap: 8px; padding: 8px 16px; background: rgba(251, 191, 36, 0.08); border: 1px solid rgba(251, 191, 36, 0.2); border-radius: 30px; font-size: 13px; color: #fbbf24; }
        .timer-badge span { font-family: 'JetBrains Mono', monospace; font-weight: 600; }
        .btn-finish { background: var(--danger); color: white; border: none; padding: 8px 16px; border-radius: 30px; font-weight: 600; cursor: pointer; }

        /* ===== MAIN LAYOUT ===== */
        .ide-container { display: flex; height: calc(100vh - 56px); position: relative; z-index: 1; }
        
        /* SIDEBAR */
        .sidebar-panel { width: 220px; background: rgba(26, 42, 44, 0.9); border-right: 1px solid var(--border-color); display: flex; flex-direction: column; }
        .sidebar-header { padding: 16px; font-size: 14px; font-weight: bold; border-bottom: 1px solid var(--border-color); color: var(--text-secondary); text-transform: uppercase; }
        .question-list { list-style: none; overflow-y: auto; flex: 1; }
        .question-item { padding: 16px; cursor: pointer; border-bottom: 1px solid var(--border-color); transition: background 0.2s; display: flex; align-items: center; gap: 10px; }
        .question-item:hover { background: var(--hover-bg); }
        .question-item.active { background: rgba(25, 167, 123, 0.2); border-left: 4px solid var(--primary); }
        .q-icon { font-size: 14px; color: var(--text-tertiary); }
        .question-item.solved .q-icon { color: var(--success); }

        /* PROBLEM PANEL */
        .problem-panel { width: 30%; min-width: 300px; background: rgba(26, 42, 44, 0.7); border-right: 1px solid var(--border-color); display: flex; flex-direction: column; overflow: hidden; }
        .panel-content { flex: 1; overflow-y: auto; padding: 24px; }
        .problem-title { font-size: 20px; font-weight: 700; color: var(--accent); margin-bottom: 10px; }
        .problem-meta { margin-bottom: 20px; }
        .meta-badge { padding: 4px 10px; border-radius: 20px; font-size: 11px; font-weight: bold; text-transform: uppercase; background: rgba(255,255,255,0.1); }
        .problem-desc { font-size: 14px; color: var(--text-secondary); line-height: 1.6; white-space: pre-wrap; margin-bottom: 20px; }
        .sample-block { background: rgba(0,0,0,0.2); border: 1px solid var(--border-color); border-radius: 10px; margin-bottom: 16px; }
        .sample-header { padding: 8px 12px; font-size: 11px; font-weight: bold; color: var(--text-tertiary); text-transform: uppercase; border-bottom: 1px solid var(--border-color); }
        .sample-block pre { padding: 12px; font-family: 'JetBrains Mono', monospace; font-size: 12px; color: var(--accent); margin: 0; white-space: pre-wrap; }

        /* RESIZE HANDLE */
        .resize-handle { width: 5px; cursor: col-resize; z-index: 10; }
        .resize-handle:hover { background: var(--primary); }

        /* EDITOR PANEL */
        .editor-panel { flex: 1; display: flex; flex-direction: column; overflow: hidden; background: var(--bg-darker); }
        .editor-toolbar { display: flex; justify-content: space-between; align-items: center; padding: 10px 16px; background: rgba(26, 42, 44, 0.9); border-bottom: 1px solid var(--border-color); }
        .tool-btn { padding: 8px 16px; border-radius: 30px; font-size: 12px; font-weight: 600; cursor: pointer; border: none; transition: 0.2s; }
        .btn-run { background: var(--gradient-primary); color: white; }
        .btn-submit-code { background: #3b82f6; color: white; }
        .editor-wrapper { flex: 1; overflow: hidden; }
        .CodeMirror { height: 100% !important; font-family: 'JetBrains Mono', monospace !important; font-size: 14px !important; background: var(--bg-darker) !important; }
        
        /* OUTPUT PANEL */
        .output-panel { height: 250px; display: flex; flex-direction: column; border-top: 1px solid var(--border-color); background: rgba(26, 42, 44, 0.95); }
        .output-tabs { display: flex; padding: 10px 16px; border-bottom: 1px solid var(--border-color); }
        .output-body { flex: 1; padding: 16px; overflow-y: auto; font-family: 'JetBrains Mono', monospace; font-size: 13px; }
        .exec-result { margin-bottom: 10px; padding: 10px; border-radius: 8px; display: none; }
        .exec-result.show { display: block; }
        .exec-result.pass { background: rgba(16, 185, 129, 0.1); border: 1px solid rgba(16, 185, 129, 0.3); color: #4ade80; }
        .exec-result.fail { background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.3); color: #f87171; }
    </style>
</head>
<body>
    <div class="top-navbar">
        <div class="nav-left">
            <span class="nav-title">${competition.title}</span>
        </div>
        <div class="nav-center">
            <div class="lang-selector">
                <label>Language</label>
                <select id="languageSelect" onchange="changeLanguage()">
                    <option value="java">Java</option>
                    <option value="python">Python</option>
                    <option value="c">C</option>
                    <option value="c++">C++</option>
                    <option value="javascript">JavaScript</option>
                </select>
            </div>
        </div>
        <div class="nav-right">
            <div class="timer-badge">
                <i class="fas fa-clock"></i>
                <span id="timerDisplay">--:--</span>
            </div>
            <button class="btn-finish" onclick="finishExam()">Finish Exam</button>
        </div>
    </div>

    <div class="ide-container">
        <!-- Sidebar -->
        <div class="sidebar-panel">
            <div class="sidebar-header">Questions</div>
            <ul class="question-list" id="questionList">
                <c:forEach var="q" items="${questions}" varStatus="status">
                    <li class="question-item ${status.index == 0 ? 'active' : ''}" data-qid="${q.id}" onclick="selectQuestion(${q.id}, this)">
                        <i class="fas fa-circle q-icon" id="q-icon-${q.id}"></i> Question ${status.index + 1}
                    </li>
                </c:forEach>
            </ul>
        </div>

        <!-- Problem Panel -->
        <div class="problem-panel">
            <div class="panel-content">
                <h2 class="problem-title" id="pTitle">Loading...</h2>
                <div class="problem-meta"><span class="meta-badge" id="pDiff"></span></div>
                <div class="problem-desc" id="pDesc"></div>
                
                <div class="sample-block">
                    <div class="sample-header">Sample Input</div>
                    <pre id="pInput"></pre>
                </div>
                
                <div class="sample-block">
                    <div class="sample-header">Sample Output</div>
                    <pre id="pOutput"></pre>
                </div>
            </div>
        </div>

        <!-- Editor Panel -->
        <div class="editor-panel">
            <div class="editor-toolbar">
                <div></div>
                <div style="display:flex;gap:10px;">
                    <button class="tool-btn btn-run" onclick="runCode()"><i class="fas fa-play"></i> Run Code</button>
                    <button class="tool-btn btn-submit-code" onclick="submitQuestion()"><i class="fas fa-paper-plane"></i> Submit Answer</button>
                </div>
            </div>
            <div class="editor-wrapper">
                <textarea id="codeEditor"></textarea>
            </div>
            <div class="output-panel">
                <div class="output-tabs">Output</div>
                <div class="output-body">
                    <div class="exec-result" id="execResult"></div>
                    <div id="outputArea" style="color:var(--text-secondary); white-space: pre-wrap;">Console output will appear here.</div>
                </div>
            </div>
        </div>
    </div>

    <!-- JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/codemirror.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/mode/clike/clike.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/mode/python/python.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/mode/javascript/javascript.min.js"></script>

    <script>
        const questionsData = {};
        <c:forEach var="q" items="${questions}">
            questionsData[${q.id}] = {
                title: "${fn:escapeXml(q.title)}",
                difficulty: "${q.difficulty}",
                description: `${fn:replace(fn:escapeXml(q.description), '`', '\\`')}`,
                sampleInput: `${fn:replace(fn:escapeXml(q.sampleInput), '`', '\\`')}`,
                sampleOutput: `${fn:replace(fn:escapeXml(q.sampleOutput), '`', '\\`')}`
            };
        </c:forEach>
        
        const savedCodes = {};
        <c:forEach var="entry" items="${savedCodes}">
            savedCodes[${entry.key}] = `${fn:replace(fn:escapeXml(entry.value), '`', '\\`')}`;
        </c:forEach>

        const templates = {
            'java': 'import java.util.*;\n\nclass Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        \n        // Write your solution here\n        \n        sc.close();\n    }\n}',
            'python': '# Write your solution here\n\nimport sys\n\ndef solve():\n    # Read input\n    \n    # Your logic here\n    pass\n\nsolve()',
            'c': '#include <stdio.h>\n#include <stdlib.h>\n\nint main() {\n    // Write your solution here\n    \n    return 0;\n}',
            'c++': '#include <iostream>\n#include <vector>\n#include <algorithm>\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    // Write your solution here\n    \n    return 0;\n}',
            'javascript': '// Write your solution here\nconst readline = require("readline");\nconst rl = readline.createInterface({ input: process.stdin });\n\nconst lines = [];\nrl.on("line", (line) => lines.push(line));\nrl.on("close", () => {\n    // Your logic here\n    \n});'
        };

        const mimeTypes = { 'java': 'text/x-java', 'python': 'text/x-python', 'c': 'text/x-csrc', 'c++': 'text/x-c++src', 'javascript': 'text/javascript' };

        let editor = CodeMirror.fromTextArea(document.getElementById('codeEditor'), {
            mode: 'text/x-java', theme: 'dracula', lineNumbers: true, indentUnit: 4
        });

        let currentQuestionId = null;

        function loadQuestionData(qid) {
            const data = questionsData[qid];
            document.getElementById('pTitle').innerText = data.title;
            document.getElementById('pDiff').innerText = data.difficulty;
            document.getElementById('pDesc').innerText = data.description;
            document.getElementById('pInput').innerText = data.sampleInput;
            document.getElementById('pOutput').innerText = data.sampleOutput;
            
            if (savedCodes[qid]) {
                editor.setValue(savedCodes[qid]);
            } else {
                editor.setValue(templates[document.getElementById('languageSelect').value]);
            }
        }

        function selectQuestion(qid, liElement) {
            // Save current code
            if (currentQuestionId) {
                savedCodes[currentQuestionId] = editor.getValue();
            }
            
            document.querySelectorAll('.question-item').forEach(el => el.classList.remove('active'));
            liElement.classList.add('active');
            currentQuestionId = qid;
            
            // Clear output
            document.getElementById('execResult').classList.remove('show');
            document.getElementById('outputArea').innerText = 'Console output will appear here.';
            
            loadQuestionData(qid);
        }

        function changeLanguage() {
            const lang = document.getElementById('languageSelect').value;
            editor.setOption('mode', mimeTypes[lang]);
            if (!savedCodes[currentQuestionId]) {
                editor.setValue(templates[lang]);
            }
        }

        async function runCode() {
            const code = editor.getValue();
            const language = document.getElementById('languageSelect').value;
            const stdin = questionsData[currentQuestionId].sampleInput;
            
            document.getElementById('outputArea').innerHTML = '<i class="fas fa-spinner fa-spin"></i> Running...';
            document.getElementById('execResult').classList.remove('show');
            
            try {
                const res = await fetch(`${pageContext.request.contextPath}/student/coding-competitions/${competition.id}/run-code`, {
                    method: 'POST', headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({ code, language, stdin })
                });
                const data = await res.json();
                
                const resEl = document.getElementById('execResult');
                if(data.success && data.exitCode === 0) {
                    resEl.className = 'exec-result show pass';
                    resEl.innerHTML = '<i class="fas fa-check-circle"></i> Executed Successfully';
                    document.getElementById('outputArea').innerText = data.output || '(No output)';
                } else {
                    resEl.className = 'exec-result show fail';
                    resEl.innerHTML = '<i class="fas fa-times-circle"></i> Execution Failed';
                    document.getElementById('outputArea').innerText = data.stderr || data.output || data.error;
                }
            } catch(e) {
                document.getElementById('outputArea').innerText = 'Network error.';
            }
        }

        async function submitQuestion() {
            const code = editor.getValue();
            const language = document.getElementById('languageSelect').value;
            
            document.getElementById('outputArea').innerHTML = '<i class="fas fa-spinner fa-spin"></i> Evaluating...';
            document.getElementById('execResult').classList.remove('show');
            
            // Save locally
            savedCodes[currentQuestionId] = code;
            
            try {
                const res = await fetch(`${pageContext.request.contextPath}/student/coding-competitions/${competition.id}/submit-question`, {
                    method: 'POST', headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({ questionId: currentQuestionId, code, language })
                });
                const data = await res.json();
                
                const resEl = document.getElementById('execResult');
                if(data.success) {
                    if(data.isCorrect) {
                        resEl.className = 'exec-result show pass';
                        resEl.innerHTML = '<i class="fas fa-check-circle"></i> Correct Answer!';
                        document.getElementById('q-icon-' + currentQuestionId).style.color = 'var(--success)';
                        document.getElementById('outputArea').innerText = 'All test cases passed.';
                    } else {
                        resEl.className = 'exec-result show fail';
                        resEl.innerHTML = '<i class="fas fa-times-circle"></i> Wrong Answer!';
                        document.getElementById('outputArea').innerText = 'Output did not match expected result.';
                    }
                } else {
                    alert(data.message || 'Submission failed');
                }
            } catch(e) {
                document.getElementById('outputArea').innerText = 'Network error.';
            }
        }

        async function finishExam() {
            if(!confirm("Are you sure you want to finish the exam? You cannot return to it later.")) return;
            
            // Save last code
            if (currentQuestionId) savedCodes[currentQuestionId] = editor.getValue();
            
            try {
                const res = await fetch(`${pageContext.request.contextPath}/student/coding-competitions/${competition.id}/finish-exam`, {
                    method: 'POST', headers: {'Content-Type': 'application/json'}
                });
                const data = await res.json();
                if(data.success) {
                    window.location.href = `${pageContext.request.contextPath}/student/coding-competitions`;
                } else {
                    alert(data.message || 'Failed to finish exam');
                }
            } catch(e) {
                alert('Network error.');
            }
        }

        // Initialize First Question
        <c:if test="${not empty questions}">
            currentQuestionId = ${questions[0].id};
            loadQuestionData(currentQuestionId);
        </c:if>
        
        // Timer
        let totalSeconds = ${remainingSeconds};
        const timerInterval = setInterval(() => {
            if (totalSeconds <= 0) {
                clearInterval(timerInterval);
                alert("Time is up! Submitting exam automatically.");
                finishExam();
            } else {
                totalSeconds--;
                let m = Math.floor(totalSeconds / 60);
                let s = totalSeconds % 60;
                document.getElementById('timerDisplay').innerText = (m < 10 ? '0' : '') + m + ':' + (s < 10 ? '0' : '') + s;
            }
        }, 1000);
    </script>
</body>
</html>
