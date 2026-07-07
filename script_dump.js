>     <script>
          if (localStorage.getItem('theme') !== 'dark') {
              document.body.classList.add('light-mode');
          }
      </script>
  
      <div class="mobile-overlay" id="mobileOverlay"></div>
      <div id="toast">Coding question added successfully!</div>
  
              <div class="sidebar" id="sidebar">
          <div class="sidebar-logo">
              <div class="icon"><i class="fas fa-laptop-code"></i></div>
              <h2>Tech Person</h2>
          </div>
          <div class="nav-section">
              <h4>Overview</h4>
              <a href="${pageContext.request.contextPath}/tech/dashboard" class="nav-link ">
                  <i class="fas fa-th-large"></i> Dashboard
              </a>
          </div>
          <div class="nav-section">
              <h4>Management</h4>
              <a href="${pageContext.request.contextPath}/tech/manage-users" class="nav-link ">
                  <i class="fas fa-users-cog"></i> Manage Users
              </a>
              <a href="${pageContext.request.contextPath}/tech/manage-questions" class="nav-link active">
                  <i class="fas fa-question-circle"></i> Manage Questions
              </a>
              <a href="${pageContext.request.contextPath}/tech/manage-categories" class="nav-link ">
                  <i class="fas fa-tags"></i> Manage Categories
              </a>
          </div>
          <div class="nav-section">
              <h4>Evaluation</h4>
              <a href="${pageContext.request.contextPath}/tech/results" class="nav-link ">
                  <i class="fas fa-poll"></i> Results
              </a>
              <a href="${pageContext.request.contextPath}/tech/ai-evaluation" class="nav-link ">
                  <i class="fas fa-robot"></i> AI Evaluation
              </a>
          </div>
          <div class="nav-section">
              <h4>Account</h4>
              <a href="${pageContext.request.contextPath}/tech/logout" class="nav-link">
                  <i class="fas fa-sign-out-alt"></i> Logout
              </a>
          </div>
      </div>
  
      <div class="main-content">
          <div class="top-bar">
              <h1>
                  <button class="mobile-menu-btn" id="mobileMenuBtn">
                      <i class="fas fa-bars"></i>
                  </button>
                  <i class="fas fa-question-circle"></i>
                  Manage Questions
              </h1>
              <div class="top-bar-actions">
                  <button id="theme-toggle" class="theme-toggle" title="Toggle Theme" onclick="toggleTheme()">
                      <i class="fas fa-moon"></i>
                  </button>
                  <a href="${pageContext.request.contextPath}/tech/logout" class="btn-logout">
                      <i class="fas fa-sign-out-alt"></i> Logout
                  </a>
              </div>
          </div>
  
          <c:if test="${not empty success}">
              <div class="alert alert-success">
                  <i class="fas fa-check-circle"></i> ${success}
              </div>
          </c:if>
  
          <div class="tabs">
              <div class="tab active" onclick="switchTab('coding')">
                  <i class="fas fa-code"></i> Coding Questions
              </div>
              <div class="tab" onclick="switchTab('interview')">
                  <i class="fas fa-comments"></i> Interview Questions
              </div>
          </div>
  
          <!-- Coding Questions Tab -->
          <div class="tab-content active" id="coding-tab">
              <div class="add-form">
                  <h3>
                      <i class="fas fa-plus-circle"></i>
                      Add Coding Question
                  </h3>
                  <form id="codingQuestionForm">
                      <div class="form-grid">
                          <div class="form-group">
                              <label><i class="fas fa-heading"></i> Title</label>
                              <input type="text" name="title" required placeholder="Question title">
                          </div>
                          <div class="form-group">
                              <label><i class="fas fa-signal"></i> Difficulty</label>
                              <select name="difficulty" required>
                                  <option value="EASY">Easy</option>
                                  <option value="MEDIUM">Medium</option>
                                  <option value="HARD">Hard</option>
                              </select>
                          </div>
                          <div class="form-group">
                              <label><i class="fas fa-folder"></i> Category</label>
                              <select name="categoryId" required>
                                  <c:forEach var="cat" items="${categories}">
                                      <option value="${cat.id}">${cat.name}</option>
                                  </c:forEach>
                              </select>
                          </div>
                          <div class="form-group">
                              <label><i class="fas fa-sign-in-alt"></i> Sample Input</label>
                              <input type="text" name="sampleInput" placeholder="Sample input">
                          </div>
                          <div class="form-group full">
                              <label><i class="fas fa-align-left"></i> Description</label>
                              <textarea name="description" required placeholder="Question description"></textarea>
                          </div>
                          <div class="form-group">
                              <label><i class="fas fa-sign-out-alt"></i> Sample Output</label>
                              <input type="text" name="sampleOutput" placeholder="Expected output">
                          </div>
                          <div class="form-group">
                              <label><i class="fas fa-lightbulb"></i> Solution Hint</label>
                              <input type="text" name="solution" placeholder="Solution approach">
                          </div>
                      </div>
                      <button type="submit" class="btn-add">
                          <i class="fas fa-plus"></i> Add Question
                      </button>
                  </form>
              </div>
  
              <div class="question-list" id="codingQuestionList">
                  <c:forEach var="q" items="${codingQuestions}">
                      <div class="q-item">
                          <div>
                              <h4>${q.title}</h4>
                              <div class="tags">
                                  <span class="tag tag-${q.difficulty == 'EASY' ? 'easy' : q.difficulty == 'MEDIUM' ? 'medium' : 'hard'}">
                                      ${q.difficulty}
                                  </span>
                                  <c:if test="${not empty q.categoryName}">
                                      <span class="tag tag-cat">${q.categoryName}</span>
                                  </c:if>
                              </div>
                          </div>
                          <form action="${pageContext.request.contextPath}/tech/delete-coding-question/${q.id}" method="post"
                              onsubmit="return confirm('Delete this coding question?');">
                              <button class="btn-del" type="submit">
                                  <i class="fas fa-trash-alt"></i> Delete
                              </button>
                          </form>
                      </div>
                  </c:forEach>
                  <c:if test="${empty codingQuestions}">
                      <div class="empty-state">
                          <i class="fas fa-code"></i>
                          <p>No coding questions yet. Add your first question above.</p>
                      </div>
                  </c:if>
              </div>
          </div>
  
          <!-- Interview Questions Tab -->
          <div class="tab-content" id="interview-tab">
              <div class="add-form">
                  <h3>
                      <i class="fas fa-plus-circle"></i>
                      Add Interview Question
                  </h3>
                  <form action="${pageContext.request.contextPath}/tech/add-interview-question" method="post">
                      <div class="form-grid">
                          <div class="form-group full">
                              <label><i class="fas fa-question"></i> Question</label>
                              <textarea name="question" required placeholder="Interview question"></textarea>
                          </div>
                          <div class="form-group">
                              <label><i class="fas fa-tag"></i> Type</label>
                              <select name="questionType" required>
                                  <option value="TECHNICAL">Technical</option>
                                  <option value="BEHAVIORAL">Behavioral</option>
                                  <option value="HR">HR</option>
                              </select>
                          </div>
                          <div class="form-group">
                              <label><i class="fas fa-signal"></i> Difficulty</label>
                              <select name="difficulty" required>
                                  <option value="EASY">Easy</option>
                                  <option value="MEDIUM" selected>Medium</option>
                                  <option value="HARD">Hard</option>
                              </select>
                          </div>
                          <div class="form-group">
                              <label><i class="fas fa-folder"></i> Category</label>
                              <select name="categoryId">
                                  <option value="">None</option>
                                  <c:forEach var="cat" items="${categories}">
                                      <option value="${cat.id}">${cat.name}</option>
                                  </c:forEach>
                              </select>
                          </div>
                          <div class="form-group full">
                              <label><i class="fas fa-check-circle"></i> Expected Answer</label>
                              <textarea name="expectedAnswer" placeholder="Expected answer or evaluation criteria"></textarea>
                          </div>
                      </div>
                      <button type="submit" class="btn-add">
                          <i class="fas fa-plus"></i> Add Question
                      </button>
                  </form>
              </div>
  
              <div class="question-list">
                  <c:forEach var="q" items="${interviewQuestions}">
                      <div class="q-item">
                          <div>
                              <h4>${q.question}</h4>
                              <div class="tags">
                                  <span class="tag tag-type">${q.questionType}</span>
                                  <span class="tag tag-${q.difficulty == 'EASY' ? 'easy' : q.difficulty == 'MEDIUM' ? 'medium' : 'hard'}">
                                      ${q.difficulty}
                                  </span>
                                  <c:if test="${not empty q.categoryName}">
                                      <span class="tag tag-cat">${q.categoryName}</span>
                                  </c:if>
                              </div>
                          </div>
                          <form action="${pageContext.request.contextPath}/tech/delete-interview-question/${q.id}" method="post"
                              onsubmit="return confirm('Delete this interview question?');">
                              <button class="btn-del" type="submit">
                                  <i class="fas fa-trash-alt"></i> Delete
                              </button>
                          </form>
                      </div>
                  </c:forEach>
                  <c:if test="${empty interviewQuestions}">
                      <div class="empty-state">
                          <i class="fas fa-comments"></i>
                          <p>No interview questions yet. Add your first question above.</p>
                      </div>
                  </c:if>
              </div>
          </div>
      </div>
  
>     <script>
          function switchTab(type) {
              document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
              document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
              if (type === 'coding') {
                  document.querySelectorAll('.tab')[0].classList.add('active');
                  document.getElementById('coding-tab').classList.add('active');
              } else {
                  document.querySelectorAll('.tab')[1].classList.add('active');
                  document.getElementById('interview-tab').classList.add('active');
              }
          }
  
          function updateThemeIcon() {
              const icon = document.querySelector('#theme-toggle i');
              if (document.body.classList.contains('light-mode')) {
                  icon.classList.remove('fa-moon');
                  icon.classList.add('fa-sun');
              } else {
                  icon.classList.remove('fa-sun');
                  icon.classList.add('fa-moon');
              }
          }
  
          updateThemeIcon();
  
          function toggleTheme() {
              document.body.classList.toggle('light-mode');
              if (document.body.classList.contains('light-mode')) {
                  localStorage.setItem('theme', 'light');
              } else {
                  localStorage.setItem('theme', 'dark');
              }
              updateThemeIcon();
          }
  
          // Mobile Menu Functionality
          document.addEventListener('DOMContentLoaded', function() {
              const mobileMenuBtn = document.getElementById('mobileMenuBtn');
              const sidebar = document.getElementById('sidebar');
              const overlay = document.getElementById('mobileOverlay');
  
              if (mobileMenuBtn) {
                  mobileMenuBtn.style.display = window.innerWidth <= 768 ? 'inline-block' : 'none';
  
                  mobileMenuBtn.addEventListener('click', function() {
                      sidebar.classList.add('active');
                      overlay.classList.add('active');
                      document.body.style.overflow = 'hidden';
                  });
  
                  overlay.addEventListener('click', function() {
                      sidebar.classList.remove('active');
                      overlay.classList.remove('active');
                      document.body.style.overflow = '';
                  });
              }
  
              // Touch swipe support
              let touchStartX = 0;
              let touchEndX = 0;
  
              document.body.addEventListener('touchstart', e => {
                  touchStartX = e.changedTouches[0].screenX;
              }, { passive: true });
  
              document.body.addEventListener('touchend', e => {
                  touchEndX = e.changedTouches[0].screenX;
                  if (touchEndX < touchStartX - 50) {
                      sidebar.classList.remove('active');
                      overlay.classList.remove('active');
                      document.body.style.overflow = '';
                  }
                  if (touchEndX > touchStartX + 50 && touchStartX < 30) {
                      sidebar.classList.add('active');
                      overlay.classList.add('active');
                      document.body.style.overflow = 'hidden';
                  }
              }, { passive: true });
  
              // Window resize handler
              window.addEventListener('resize', function() {
                  if (mobileMenuBtn) {
                      mobileMenuBtn.style.display = window.innerWidth <= 768 ? 'inline-block' : 'none';
                  }
                  if (window.innerWidth > 768) {
                      sidebar.classList.remove('active');
                      overlay.classList.remove('active');
                      document.body.style.overflow = '';
                  }
              });
  
              // Keyboard shortcuts
              document.addEventListener('keydown', function(e) {
                  if (e.key === 'Escape') {
                      sidebar.classList.remove('active');
                      overlay.classList.remove('active');
                      document.body.style.overflow = '';
                  }
              });
          });
              // AJAX form submission for coding questions
          document.addEventListener('DOMContentLoaded', function() {
              const form = document.getElementById('codingQuestionForm');
              if(form) {
                  form.addEventListener('submit', function(e) {
                      e.preventDefault();
                      
                      const formData = new FormData(form);
                      
                                          fetch('/tech/add-coding-question', {
                          method: 'POST',
                          body: formData
                      })
                      .then(response => response.json())
                      .then(data => {
                          if(data.success) {
                              showToast();
                              
                              // Remove empty state if present
                              const emptyState = document.querySelector('#codingQuestionList .empty-state');
                              if(emptyState) emptyState.remove();
                              
                              // Determine tag color classes
                              let diffClass = 'medium';
                              if(data.question.difficulty === 'EASY') diffClass = 'easy';
                              if(data.question.difficulty === 'HARD') diffClass = 'hard';
                              
                              let catTag = '';
                              if(data.question.categoryId) {
                                  catTag = '<span class="tag tag-cat">Category ID: ' + data.question.categoryId + '</span>';
                              }
                              
                              // Append new question to list
                              const list = document.getElementById('codingQuestionList');
                              const newItem = document.createElement('div');
                              newItem.className = 'q-item';
                              newItem.innerHTML = 
                                  '<div>' +
                                      '<h4>' + data.question.title + '</h4>' +
                                      '<div class="tags">' +
                                          '<span class="tag tag-type">CODING</span>' +
                                          '<span class="tag tag-' + diffClass + '">' + data.question.difficulty + '</span>' +
                                          catTag +
                                      '</div>' +
                                  '</div>' +
                                  '<form action="/tech/delete-coding-question/' + data.question.id + '" method="post" onsubmit="return confirm(\'Delete this coding question?\');">' +
                                      '<button class="btn-del" type="submit">' +
                                          '<i class="fas fa-trash-alt"></i> Delete' +
                                      '</button>' +
                                  '</form>';
                              list.appendChild(newItem);
                              
                              form.reset();
                          } else {
                              alert("Error: " + data.message);
                          }
                      })
                      .catch(err => console.error("Error submitting form:", err));
                  });
              }
          });
  
          function showToast() {
              const toast = document.getElementById("toast");
              toast.className = "show";
              setTimeout(function(){ toast.className = toast.className.replace("show", ""); }, 3000);
          }
  </script>
  </body>
  </html>
  
  
  
  
  
  
  
  
  
  
