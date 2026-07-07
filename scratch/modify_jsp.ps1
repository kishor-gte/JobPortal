$file = "c:\Users\NEHA\git\JobPortal\src\main\webapp\views\techperson\conduct-competition.jsp"
$content = [System.IO.File]::ReadAllText($file)
$startMarker = "<!-- Stats Row 1 -->"
$endMarker = "<script>`n        // Sidebar Toggle for Mobile"

$startIdx = $content.IndexOf($startMarker)
$endIdx = $content.IndexOf($endMarker)

if ($startIdx -eq -1 -or $endIdx -eq -1) {
    # Try finding end marker with \r\n
    $endMarker = "<script>`r`n        // Sidebar Toggle for Mobile"
    $endIdx = $content.IndexOf($endMarker)
}

if ($startIdx -ge 0 -and $endIdx -ge 0) {
    $replacement = @"
        <style>
            .form-card {
                background: rgba(255, 255, 255, 0.95);
                border: 1px solid var(--border-color);
                border-radius: var(--radius-lg);
                padding: 24px;
                backdrop-filter: blur(20px);
                margin-bottom: 24px;
                animation: slideUp 0.5s ease-out;
            }
            .form-card-title {
                font-size: 18px;
                font-weight: 700;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
                color: var(--primary);
                border-bottom: 1px solid rgba(0,0,0,0.05);
                padding-bottom: 12px;
            }
            body.light-mode .form-card-title {
                border-bottom: 1px solid #e2e8f0;
            }
            .form-group {
                margin-bottom: 16px;
            }
            .form-label {
                font-size: 14px;
                font-weight: 600;
                color: #fff;
                margin-bottom: 8px;
                display: block;
            }
            body.light-mode .form-label {
                color: #1e293b;
            }
            .form-control, .form-select {
                width: 100%;
                padding: 12px 16px;
                background: rgba(0,0,0,0.2);
                border: 1px solid rgba(255,255,255,0.1);
                border-radius: var(--radius-md);
                color: #fff;
                font-family: inherit;
                transition: var(--transition);
            }
            body.light-mode .form-control, body.light-mode .form-select {
                background: #fff;
                border: 1px solid #cbd5e1;
                color: #1e293b;
            }
            .form-control:focus, .form-select:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(25, 167, 123, 0.2);
            }
            .checkbox-group {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 12px;
            }
            .checkbox-group input[type="checkbox"] {
                width: 18px;
                height: 18px;
                accent-color: var(--primary);
            }
            .checkbox-group label {
                font-size: 14px;
                font-weight: 500;
                color: #fff;
            }
            body.light-mode .checkbox-group label {
                color: #1e293b;
            }
            .grid-2 {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }
            .btn-primary {
                background: var(--gradient-primary);
                color: white;
                border: none;
                padding: 14px 28px;
                border-radius: var(--radius-md);
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: var(--transition);
                display: inline-flex;
                align-items: center;
                gap: 10px;
                width: 100%;
                justify-content: center;
            }
            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-md);
            }
            .btn-secondary {
                background: rgba(255,255,255,0.1);
                color: white;
                border: 1px solid rgba(255,255,255,0.2);
                padding: 10px 20px;
                border-radius: var(--radius-md);
                font-size: 14px;
                cursor: pointer;
                transition: var(--transition);
            }
            body.light-mode .btn-secondary {
                background: #f1f5f9;
                color: #1e293b;
                border-color: #cbd5e1;
            }
            .btn-secondary:hover {
                background: rgba(255,255,255,0.2);
            }
            @keyframes slideUp {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }
            
            .toast-container {
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 9999;
            }
            .toast {
                background: #10b981;
                color: white;
                padding: 16px 24px;
                border-radius: var(--radius-md);
                box-shadow: var(--shadow-lg);
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 600;
                transform: translateX(120%);
                transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }
            .toast.show {
                transform: translateX(0);
            }
            .toast.error {
                background: #ef4444;
            }
            
            .question-builder {
                display: none;
                margin-top: 20px;
                padding: 20px;
                border: 1px dashed rgba(255,255,255,0.3);
                border-radius: var(--radius-md);
                background: rgba(0,0,0,0.1);
            }
            body.light-mode .question-builder {
                border-color: #cbd5e1;
                background: #f8fafc;
            }
            .question-builder.active {
                display: block;
            }
            
            .new-question-item {
                background: rgba(255,255,255,0.05);
                border-radius: var(--radius-md);
                padding: 16px;
                margin-bottom: 16px;
                position: relative;
            }
            body.light-mode .new-question-item {
                background: #fff;
                border: 1px solid #e2e8f0;
            }
        </style>

        <form id="competitionForm" onsubmit="saveCompetition(event)">
            
            <!-- Basic Details -->
            <div class="form-card">
                <div class="form-card-title"><i class="fas fa-info-circle"></i> Basic Details</div>
                <div class="form-group">
                    <label class="form-label">Competition Title *</label>
                    <input type="text" class="form-control" name="title" required placeholder="e.g. Summer Code Sprint 2026">
                </div>
                <div class="form-group">
                    <label class="form-label">Competition Description *</label>
                    <textarea class="form-control" name="description" rows="3" required placeholder="What is this competition about?"></textarea>
                </div>
                <div class="form-group">
                    <label class="form-label">Competition Rules *</label>
                    <textarea class="form-control" name="rules" rows="3" required placeholder="List the rules separated by newlines"></textarea>
                </div>
                <div class="grid-2">
                    <div class="form-group">
                        <label class="form-label">Difficulty *</label>
                        <select class="form-select" name="difficulty" required>
                            <option value="">Select Difficulty</option>
                            <option value="Easy">Easy</option>
                            <option value="Medium">Medium</option>
                            <option value="Hard">Hard</option>
                            <option value="Mixed">Mixed</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Allowed Programming Languages *</label>
                        <select class="form-select" name="allowedLanguages" required>
                            <option value="Java, Python, C++, JavaScript">All (Java, Python, C++, JS)</option>
                            <option value="Java">Java Only</option>
                            <option value="Python">Python Only</option>
                            <option value="C++">C++ Only</option>
                        </select>
                    </div>
                </div>
                <div class="grid-2">
                    <div class="form-group">
                        <label class="form-label">Number of Coding Questions *</label>
                        <input type="number" class="form-control" id="numQuestions" name="numberOfQuestions" required min="1" max="20" placeholder="e.g. 2">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Competition Banner Image URL (Optional)</label>
                        <input type="text" class="form-control" name="bannerImage" placeholder="https://...">
                    </div>
                </div>
            </div>

            <!-- Registration Settings -->
            <div class="form-card">
                <div class="form-card-title"><i class="fas fa-calendar-check"></i> Registration Settings</div>
                <div class="grid-2">
                    <div class="form-group">
                        <label class="form-label">Registration Start Date & Time *</label>
                        <input type="datetime-local" class="form-control" name="registrationStartTime" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Registration End Date & Time *</label>
                        <input type="datetime-local" class="form-control" name="registrationEndTime" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Maximum Participants *</label>
                    <input type="number" class="form-control" name="maxParticipants" required min="1" placeholder="e.g. 100">
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" name="allowWaitlist" id="allowWaitlist" value="true">
                    <label for="allowWaitlist">Allow Waitlist when capacity is full</label>
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" name="autoCloseRegistration" id="autoCloseRegistration" value="true" checked>
                    <label for="autoCloseRegistration">Auto Close Registration when Capacity is Full</label>
                </div>
            </div>

            <!-- Exam Settings -->
            <div class="form-card">
                <div class="form-card-title"><i class="fas fa-clock"></i> Exam Settings</div>
                <div class="grid-2">
                    <div class="form-group">
                        <label class="form-label">Exam Start Date & Time *</label>
                        <input type="datetime-local" class="form-control" name="examStartTime" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Exam Duration (Minutes) *</label>
                        <input type="number" class="form-control" name="examDurationMinutes" required min="5" placeholder="e.g. 90">
                    </div>
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" name="autoSubmit" id="autoSubmit" value="true" checked>
                    <label for="autoSubmit">Auto Submit when Time Ends</label>
                </div>
            </div>

            <!-- Coding Questions -->
            <div class="form-card">
                <div class="form-card-title"><i class="fas fa-code"></i> Coding Questions</div>
                <p style="font-size: 13px; color: var(--text-secondary); margin-bottom: 16px;">
                    You must select or create exactly <strong id="questionCountDisplay">0</strong> questions.
                </p>
                
                <div class="form-group">
                    <label class="form-label">Question Source *</label>
                    <select class="form-select" id="questionSource" onchange="toggleQuestionSource()">
                        <option value="">Select Option</option>
                        <option value="EXISTING">Option 1: Select Existing Questions</option>
                        <option value="NEW">Option 2: Add New Questions</option>
                    </select>
                </div>

                <!-- Option 1: Existing -->
                <div class="question-builder" id="existingQuestionsDiv">
                    <div class="form-group">
                        <label class="form-label">Select from Database (Ctrl+Click to select multiple)</label>
                        <select class="form-select" id="existingQuestionsSelect" multiple style="height: 150px;">
                            <c:forEach var="q" items="${existingQuestions}">
                                <option value="`$"{q.id}"`">`$"{q.title}"` (`$"{q.difficulty}"`)</option>
                            </c:forEach>
                        </select>
                        <small style="color:var(--text-secondary); margin-top: 8px; display:block;">Hold Ctrl (Windows) or Cmd (Mac) to select multiple.</small>
                    </div>
                </div>

                <!-- Option 2: New -->
                <div class="question-builder" id="newQuestionsDiv">
                    <div id="newQuestionsContainer"></div>
                    <button type="button" class="btn-secondary" id="btnAddQuestion" onclick="addNewQuestionForm()">
                        <i class="fas fa-plus"></i> Add Coding Question
                    </button>
                    <p style="font-size: 12px; color: var(--warning); margin-top: 10px;" id="newQuestionsStatus">Added: 0</p>
                </div>
            </div>

            <!-- Exam Security -->
            <div class="form-card">
                <div class="form-card-title"><i class="fas fa-shield-alt"></i> Exam Security</div>
                <div class="grid-2">
                    <div>
                        <div class="checkbox-group">
                            <input type="checkbox" name="disableCopyPaste" id="disableCopyPaste" value="true" checked>
                            <label for="disableCopyPaste">Disable Copy & Paste</label>
                        </div>
                        <div class="checkbox-group">
                            <input type="checkbox" name="disableRightClick" id="disableRightClick" value="true" checked>
                            <label for="disableRightClick">Disable Right Click</label>
                        </div>
                        <div class="checkbox-group">
                            <input type="checkbox" name="fullScreenMode" id="fullScreenMode" value="true" checked>
                            <label for="fullScreenMode">Enforce Full Screen Mode</label>
                        </div>
                    </div>
                    <div>
                        <div class="checkbox-group">
                            <input type="checkbox" name="autoSubmitTabSwitch" id="autoSubmitTabSwitch" value="true">
                            <label for="autoSubmitTabSwitch">Auto Submit if Candidate leaves Tab > 3 times</label>
                        </div>
                        <div class="checkbox-group">
                            <input type="checkbox" name="oneLoginPerCandidate" id="oneLoginPerCandidate" value="true" checked>
                            <label for="oneLoginPerCandidate">Allow Only One Login per Candidate</label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Publish Settings -->
            <div class="form-card">
                <div class="form-card-title"><i class="fas fa-upload"></i> Publish Settings</div>
                <div class="form-group">
                    <label class="form-label">Competition Status *</label>
                    <select class="form-select" name="status" required>
                        <option value="DRAFT">Draft (Save for later)</option>
                        <option value="PUBLISHED" selected>Published (Make available)</option>
                    </select>
                </div>
            </div>

            <button type="submit" class="btn-primary" id="btnSubmit">
                <i class="fas fa-save"></i> Save Competition
            </button>
        </form>
    </div>

    <!-- Toast Notification -->
    <div class="toast-container">
        <div class="toast" id="toastMessage">
            <i class="fas fa-check-circle"></i>
            <span id="toastText">Competition created successfully.</span>
        </div>
    </div>

    <script>
        // Track dynamically added questions
        let newQuestionCount = 0;

        document.getElementById('numQuestions').addEventListener('input', function(e) {
            document.getElementById('questionCountDisplay').innerText = e.target.value || 0;
            checkNewQuestionLimit();
        });

        function toggleQuestionSource() {
            const source = document.getElementById('questionSource').value;
            document.getElementById('existingQuestionsDiv').classList.remove('active');
            document.getElementById('newQuestionsDiv').classList.remove('active');
            
            if (source === 'EXISTING') {
                document.getElementById('existingQuestionsDiv').classList.add('active');
            } else if (source === 'NEW') {
                document.getElementById('newQuestionsDiv').classList.add('active');
            }
        }

        function checkNewQuestionLimit() {
            const required = parseInt(document.getElementById('numQuestions').value) || 0;
            const btn = document.getElementById('btnAddQuestion');
            const status = document.getElementById('newQuestionsStatus');
            
            status.innerText = 'Added: ' + newQuestionCount + ' / ' + required;
            
            if (required > 0 && newQuestionCount >= required) {
                btn.style.display = 'none';
            } else {
                btn.style.display = 'inline-flex';
            }
        }

        function addNewQuestionForm() {
            const required = parseInt(document.getElementById('numQuestions').value) || 0;
            if (required <= 0) {
                showToast("Please enter Number of Coding Questions first.", true);
                return;
            }
            if (newQuestionCount >= required) {
                return;
            }
            
            const container = document.getElementById('newQuestionsContainer');
            const idx = newQuestionCount;
            
            const html = `
                <div class="new-question-item" id="nq_` + idx + `">
                    <h5 style="margin-bottom: 12px; color: var(--primary);">Question ` + (idx + 1) + `</h5>
                    <div class="form-group">
                        <input type="text" class="form-control nq-title" placeholder="Question Title *" required>
                    </div>
                    <div class="grid-2">
                        <div class="form-group">
                            <select class="form-select nq-difficulty" required>
                                <option value="">Select Difficulty *</option>
                                <option value="Easy">Easy</option>
                                <option value="Medium">Medium</option>
                                <option value="Hard">Hard</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <input type="number" class="form-control nq-category" placeholder="Category ID *" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <textarea class="form-control nq-desc" placeholder="Problem Description *" required rows="2"></textarea>
                    </div>
                    <div class="grid-2">
                        <div class="form-group">
                            <textarea class="form-control nq-input" placeholder="Sample Input *" required rows="2"></textarea>
                        </div>
                        <div class="form-group">
                            <textarea class="form-control nq-output" placeholder="Sample Output *" required rows="2"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control nq-hint" placeholder="Solution Hint (Optional)">
                    </div>
                    <button type="button" class="btn-secondary" style="color: #ef4444; border-color: #ef4444;" onclick="removeNewQuestionForm('nq_` + idx + `')">Remove</button>
                </div>
            `;
            
            container.insertAdjacentHTML('beforeend', html);
            newQuestionCount++;
            checkNewQuestionLimit();
        }

        function removeNewQuestionForm(id) {
            document.getElementById(id).remove();
            newQuestionCount--;
            checkNewQuestionLimit();
            // Re-label questions
            const items = document.querySelectorAll('.new-question-item h5');
            items.forEach((el, index) => {
                el.innerText = 'Question ' + (index + 1);
            });
        }

        function showToast(message, isError = false) {
            const toast = document.getElementById('toastMessage');
            const text = document.getElementById('toastText');
            const icon = toast.querySelector('i');
            
            text.innerText = message;
            if (isError) {
                toast.classList.add('error');
                icon.className = 'fas fa-exclamation-circle';
            } else {
                toast.classList.remove('error');
                icon.className = 'fas fa-check-circle';
            }
            
            toast.classList.add('show');
            setTimeout(() => {
                toast.classList.remove('show');
            }, 3000);
        }

        async function saveCompetition(event) {
            event.preventDefault();
            const form = event.target;
            
            // Validate Questions Logic
            const requiredNum = parseInt(document.getElementById('numQuestions').value) || 0;
            const source = document.getElementById('questionSource').value;
            
            const payload = {
                title: form.title.value,
                description: form.description.value,
                rules: form.rules.value,
                difficulty: form.difficulty.value,
                allowedLanguages: form.allowedLanguages.value,
                bannerImage: form.bannerImage.value,
                numberOfQuestions: requiredNum,
                registrationStartTime: form.registrationStartTime.value,
                registrationEndTime: form.registrationEndTime.value,
                maxParticipants: parseInt(form.maxParticipants.value) || 0,
                allowWaitlist: form.allowWaitlist.checked,
                autoCloseRegistration: form.autoCloseRegistration.checked,
                examStartTime: form.examStartTime.value,
                examDurationMinutes: parseInt(form.examDurationMinutes.value) || 0,
                autoSubmit: form.autoSubmit.checked,
                disableCopyPaste: form.disableCopyPaste.checked,
                disableRightClick: form.disableRightClick.checked,
                fullScreenMode: form.fullScreenMode.checked,
                autoSubmitTabSwitch: form.autoSubmitTabSwitch.checked,
                oneLoginPerCandidate: form.oneLoginPerCandidate.checked,
                status: form.status.value,
                selectedQuestionIds: [],
                newQuestions: []
            };

            if (source === 'EXISTING') {
                const select = document.getElementById('existingQuestionsSelect');
                const selectedOptions = Array.from(select.selectedOptions);
                if (selectedOptions.length !== requiredNum) {
                    showToast('Please select exactly ' + requiredNum + ' questions.', true);
                    return;
                }
                payload.selectedQuestionIds = selectedOptions.map(opt => parseInt(opt.value));
            } else if (source === 'NEW') {
                if (newQuestionCount !== requiredNum) {
                    showToast('Please add exactly ' + requiredNum + ' questions.', true);
                    return;
                }
                
                const items = document.querySelectorAll('.new-question-item');
                items.forEach(item => {
                    payload.newQuestions.push({
                        title: item.querySelector('.nq-title').value,
                        difficulty: item.querySelector('.nq-difficulty').value,
                        categoryId: parseInt(item.querySelector('.nq-category').value) || 1,
                        description: item.querySelector('.nq-desc').value,
                        sampleInput: item.querySelector('.nq-input').value,
                        sampleOutput: item.querySelector('.nq-output').value,
                        solutionHint: item.querySelector('.nq-hint').value
                    });
                });
            } else {
                showToast('Please select a Question Source.', true);
                return;
            }

            const btn = document.getElementById('btnSubmit');
            const originalText = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
            btn.disabled = true;

            try {
                const response = await fetch('`$"{pageContext.request.contextPath}/tech/api/competitions"`', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload)
                });
                
                const result = await response.json();
                
                if (response.ok && result.success) {
                    showToast(result.message);
                    form.reset();
                    newQuestionCount = 0;
                    document.getElementById('newQuestionsContainer').innerHTML = '';
                    checkNewQuestionLimit();
                    toggleQuestionSource();
                } else {
                    showToast(result.message || 'Error saving competition.', true);
                }
            } catch (err) {
                console.error(err);
                showToast('Network error occurred.', true);
            } finally {
                btn.innerHTML = originalText;
                btn.disabled = false;
            }
        }
    </script>
"@

    $newContent = $content.Substring(0, $startIdx) + $replacement + "`r`n    <script>`r`n        // Sidebar Toggle for Mobile" + $content.Substring($endIdx + 45)
    [System.IO.File]::WriteAllText($file, $newContent)
    Write-Host "Success"
} else {
    Write-Host "Markers not found. start: $startIdx, end: $endIdx"
}
