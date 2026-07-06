
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

