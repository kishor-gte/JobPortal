/**
 * Mobile Responsive JavaScript for Job Portal
 * Include this JS file in all JSP pages for mobile interactivity
 */

(function() {
    'use strict';
    
    // Mobile Menu Toggle Functionality
    function initMobileMenu() {
        // Create mobile menu toggle button if sidebar exists
        const sidebar = document.querySelector('.sidebar') || document.querySelector('.nav-sidebar');
        
        if (sidebar && window.innerWidth <= 768) {
            // Create toggle button if it doesn't exist
            if (!document.querySelector('.mobile-menu-toggle')) {
                const toggleBtn = document.createElement('button');
                toggleBtn.className = 'mobile-menu-toggle';
                toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
                toggleBtn.setAttribute('aria-label', 'Toggle Menu');
                document.body.appendChild(toggleBtn);
                
                // Create overlay
                const overlay = document.createElement('div');
                overlay.className = 'sidebar-overlay';
                document.body.appendChild(overlay);
                
                // Toggle functionality
                toggleBtn.addEventListener('click', function() {
                    sidebar.classList.toggle('active');
                    overlay.classList.toggle('active');
                });
                
                overlay.addEventListener('click', function() {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                });
                
                // Close sidebar when clicking a link
                const links = sidebar.querySelectorAll('a');
                links.forEach(function(link) {
                    link.addEventListener('click', function() {
                        sidebar.classList.remove('active');
                        overlay.classList.remove('active');
                    });
                });
            }
        }
    }
    
    // Add data-labels to table cells for mobile responsive tables
    function initResponsiveTables() {
        const tables = document.querySelectorAll('table');
        
        tables.forEach(function(table) {
            const headers = table.querySelectorAll('thead th');
            const headerTexts = Array.from(headers).map(function(th) {
                return th.textContent.trim();
            });
            
            const rows = table.querySelectorAll('tbody tr');
            rows.forEach(function(row) {
                const cells = row.querySelectorAll('td');
                cells.forEach(function(cell, index) {
                    if (headerTexts[index]) {
                        cell.setAttribute('data-label', headerTexts[index]);
                    }
                });
            });
        });
    }
    
    // Smooth scroll for anchor links
    function initSmoothScroll() {
        document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    }
    
    // Form validation enhancements
    function initFormValidation() {
        const forms = document.querySelectorAll('form');
        
        forms.forEach(function(form) {
            form.addEventListener('submit', function(e) {
                const requiredFields = form.querySelectorAll('[required]');
                let isValid = true;
                
                requiredFields.forEach(function(field) {
                    if (!field.value.trim()) {
                        isValid = false;
                        field.classList.add('is-invalid');
                        
                        // Add shake animation
                        field.style.animation = 'shake 0.5s';
                        setTimeout(function() {
                            field.style.animation = '';
                        }, 500);
                    } else {
                        field.classList.remove('is-invalid');
                    }
                });
                
                if (!isValid) {
                    e.preventDefault();
                    // Show toast notification
                    showToast('Please fill in all required fields', 'error');
                }
            });
            
            // Remove invalid class on input
            form.querySelectorAll('input, select, textarea').forEach(function(field) {
                field.addEventListener('input', function() {
                    this.classList.remove('is-invalid');
                });
            });
        });
    }
    
    // Toast notification system
    function showToast(message, type) {
        // Remove existing toasts
        const existingToast = document.querySelector('.mobile-toast');
        if (existingToast) {
            existingToast.remove();
        }
        
        const toast = document.createElement('div');
        toast.className = 'mobile-toast toast-' + type;
        toast.innerHTML = '<i class="fas fa-' + (type === 'error' ? 'exclamation-circle' : 'check-circle') + '"></i> ' + message;
        
        // Styles
        toast.style.cssText = `
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: ${type === 'error' ? '#dc3545' : '#28a745'};
            color: white;
            padding: 15px 25px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            z-index: 10000;
            font-size: 14px;
            animation: slideDown 0.3s ease;
        `;
        
        document.body.appendChild(toast);
        
        // Auto remove after 3 seconds
        setTimeout(function() {
            toast.style.animation = 'slideUp 0.3s ease';
            setTimeout(function() {
                toast.remove();
            }, 300);
        }, 3000);
    }
    
    // Add CSS animations - prevent duplicate injection
    function addAnimationStyles() {
        // Check if styles already exist to prevent duplicate injection on refresh
        if (document.getElementById('mobile-responsive-animations')) {
            return;
        }
        
        const style = document.createElement('style');
        style.id = 'mobile-responsive-animations';
        style.textContent = `
            @keyframes slideDown {
                from { transform: translateX(-50%) translateY(-100%); opacity: 0; }
                to { transform: translateX(-50%) translateY(0); opacity: 1; }
            }
            @keyframes slideUp {
                from { transform: translateX(-50%) translateY(0); opacity: 1; }
                to { transform: translateX(-50%) translateY(-100%); opacity: 0; }
            }
            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                25% { transform: translateX(-5px); }
                75% { transform: translateX(5px); }
            }
            .is-invalid {
                border-color: #dc3545 !important;
                box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25) !important;
            }
        `;
        document.head.appendChild(style);
    }
    
    // Lazy loading for images
    function initLazyLoading() {
        if ('IntersectionObserver' in window) {
            const imageObserver = new IntersectionObserver(function(entries, observer) {
                entries.forEach(function(entry) {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        img.src = img.dataset.src || img.src;
                        img.classList.add('loaded');
                        observer.unobserve(img);
                    }
                });
            });
            
            document.querySelectorAll('img[data-src]').forEach(function(img) {
                imageObserver.observe(img);
            });
        }
    }
    
    // Handle window resize
    let resizeTimer;
    function handleResize() {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(function() {
            initMobileMenu();
        }, 250);
    }
    
    // Initialize everything when DOM is ready
    function init() {
        addAnimationStyles();
        initMobileMenu();
        initResponsiveTables();
        initSmoothScroll();
        initFormValidation();
        initLazyLoading();
        
        window.addEventListener('resize', handleResize);
    }
    
    // Run on DOM ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
    
    // Expose showToast globally
    window.showToast = showToast;
})();
