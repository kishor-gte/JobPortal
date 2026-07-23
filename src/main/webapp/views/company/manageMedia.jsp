<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Culture Videos | JobU - Showcase Your Company Culture</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --primary-light: #3BC49A;
            --primary-glow: rgba(25,167,123,0.15);
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-light: #f4fbf9;
            --text-dark: #1a2c2f;
            --text-muted: #5a6e66;
            --white: #ffffff;
            --border: #e2e8f0;
            --danger: #ef4444;
            --success: #19A77B;
            --gradient: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
            --gradient-dark: linear-gradient(135deg, #1e2f32 0%, #2E3E41 100%);
            --shadow-sm: 0 10px 25px -5px rgba(0,0,0,0.05);
            --shadow-md: 0 20px 35px -12px rgba(25,167,123,0.15);
            --shadow-lg: 0 30px 50px -15px rgba(0,0,0,0.12);
            --radius: 24px;
            --radius-sm: 16px;
            --transition: all 0.4s cubic-bezier(0.2, 0.95, 0.4, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
            color: var(--text-dark);
            min-height: 100vh;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #e6f4ef; border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: var(--primary-dark); }

        /* ========== PAGE HEADER ========== */
		.page-header {
		    background: #2EB38A; /* Solid Green */
		    color: #fff;
		    padding: 60px 0 50px;
		    position: relative;
		    overflow: hidden;
		    margin-bottom: 40px;
		    border-radius: 10px; /* Optional */
		}

		/* Remove decorative glow effects */
		.page-header::before,
		.page-header::after {
		    display: none;
		}

		/* Heading */
		.page-header h1 {
		    font-size: 2rem;
		    font-weight: 800;
		    color: #fff;
		    background: none;
		    -webkit-background-clip: initial;
		    background-clip: initial;
		    margin-bottom: 12px;
		    animation: none;
		}

		/* Paragraph */
		.page-header p {
		    font-size: 1rem;
		    color: #fff;
		    opacity: 1;
		    margin: 0;
		}

		/* Disable old animations */
		@keyframes floatGlow {
		    from {}
		    to {}
		}

		@keyframes floatGlow2 {
		    from {}
		    to {}
		}

		@keyframes textShine {
		    from {}
		    to {}
		}

        /* ========== ACTION BAR ========== */
        .action-bar {
            background: var(--white);
            border-radius: var(--radius-sm);
            padding: 20px 24px;
            box-shadow: var(--shadow-sm);
            margin-bottom: 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            border: 1px solid rgba(25,167,123,0.1);
            transition: var(--transition);
        }
        .action-bar:hover {
            box-shadow: var(--shadow-md);
        }
        .btn-add-video {
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 12px 28px;
            font-weight: 700;
            font-size: 0.9rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            box-shadow: 0 4px 12px rgba(25,167,123,0.25);
        }
        .btn-add-video:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.35);
            color: white;
        }
        .video-count {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: var(--bg-light);
            color: var(--primary);
            padding: 8px 20px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.85rem;
            border: 1px solid rgba(25,167,123,0.2);
        }

        /* ========== VIDEO GRID ========== */
        .video-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 28px;
        }
        .video-card {
            background: var(--white);
            border-radius: var(--radius);
            overflow: hidden;
            transition: var(--transition);
            border: 1px solid rgba(25,167,123,0.1);
            box-shadow: var(--shadow-sm);
            animation: fadeInUp 0.6s ease backwards;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .video-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg);
            border-color: rgba(25,167,123,0.2);
        }
        .video-thumbnail-container {
            position: relative;
            width: 100%;
            height: 220px;
            background: var(--bg-dark);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            cursor: pointer;
        }
        .video-thumbnail-container video {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .video-play-icon {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(25,167,123,0.9);
            color: white;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            opacity: 0.85;
            transition: var(--transition);
        }
        .video-thumbnail-container:hover .video-play-icon {
            opacity: 1;
            transform: translate(-50%, -50%) scale(1.1);
            background: var(--primary);
        }
        .video-card-body {
            padding: 24px;
        }
        .video-title {
            font-size: 1.1rem;
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 10px;
        }
        .video-description {
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-bottom: 20px;
            line-height: 1.6;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .video-actions {
            display: flex;
            gap: 12px;
            padding-top: 16px;
            border-top: 1px solid var(--border);
        }
        .btn-action {
            flex: 1;
            padding: 10px 16px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.8rem;
            transition: var(--transition);
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            border: none;
            cursor: pointer;
        }
        .btn-view {
            background: rgba(25,167,123,0.1);
            color: var(--primary);
            border: 1px solid rgba(25,167,123,0.2);
        }
        .btn-view:hover {
            background: var(--gradient);
            color: white;
            transform: translateY(-2px);
        }
        .btn-delete {
            background: rgba(239,68,68,0.1);
            color: var(--danger);
            border: 1px solid rgba(239,68,68,0.2);
        }
        .btn-delete:hover {
            background: var(--danger);
            color: white;
            transform: translateY(-2px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 40px;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(25,167,123,0.1);
        }
        .empty-state > i {
            font-size: 4rem;
            color: var(--primary-light);
            margin-bottom: 20px;
            opacity: 0.6;
        }
        .empty-state h3 {
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 10px;
        }

        /* Alert Messages */
        .alert-custom {
            border-radius: var(--radius-sm);
            padding: 16px 20px;
            margin-bottom: 24px;
            border: none;
            font-weight: 500;
        }
        .alert-success-custom {
            background: linear-gradient(135deg, rgba(25,167,123,0.1), rgba(59,196,154,0.05));
            color: var(--primary-dark);
            border-left: 4px solid var(--primary);
        }
        .alert-danger-custom {
            background: linear-gradient(135deg, rgba(239,68,68,0.1), rgba(239,68,68,0.05));
            color: var(--danger);
            border-left: 4px solid var(--danger);
        }

        /* Modal Styles */
        .video-modal video {
            width: 100%;
            border-radius: 16px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 40px 0 30px; }
            .page-header h1 { font-size: 1.5rem; }
            .action-bar { flex-direction: column; align-items: stretch; }
            .btn-add-video { justify-content: center; }
            .video-count { justify-content: center; }
            .video-grid { grid-template-columns: 1fr; gap: 20px; }
            .video-thumbnail-container { height: 200px; }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header" data-aos="fade-down">
        <div class="container">
            <h1><i class="fas fa-video me-2"></i>Culture Videos</h1>
            <p>${company.name}</p>
        </div>
    </div>

    <div class="container">
        <a href="javascript:history.back()" class="btn-back-custom" style="display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.6rem 1.5rem; background: #ffffff; color: var(--primary); border: 1px solid rgba(25, 167, 123, 0.2); border-radius: 50px; font-weight: 600; text-decoration: none; transition: all 0.3s ease; margin-bottom: 1.5rem; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);" onmouseover="this.style.background='var(--primary)'; this.style.color='white';" onmouseout="this.style.background='#ffffff'; this.style.color='var(--primary)';">
            <i class="fas fa-arrow-left"></i> Back
        </a>
        <!-- Alert Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success-custom alert-custom" data-aos="fade-up">
                <i class="fas fa-check-circle me-2"></i>${message}
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger-custom alert-custom" data-aos="fade-up">
                <i class="fas fa-exclamation-circle me-2"></i>
                <c:choose>
                    <c:when test="${param.error == 'empty'}">Please select a video file to upload.</c:when>
                    <c:when test="${param.error == 'io'}">An error occurred while saving the video file.</c:when>
                    <c:when test="${param.error == 'invalid'}">The file type is invalid or the size exceeds the maximum limit (50MB).</c:when>
                    <c:otherwise>An unexpected error occurred while uploading. Please try again.</c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <!-- Action Bar -->
        <div class="action-bar" data-aos="fade-up" data-aos-delay="100">
            <a href="${pageContext.request.contextPath}/company/media/upload/${company.id}" class="btn-add-video">
                <i class="fas fa-plus"></i> Add New Video
            </a>
            <div class="video-count">
                <i class="fas fa-video"></i>
                <span>${fn:length(mediaList)} Video${fn:length(mediaList) != 1 ? 's' : ''}</span>
            </div>
        </div>

        <!-- Videos Grid -->
        <c:choose>
            <c:when test="${empty mediaList}">
                <div class="empty-state" data-aos="fade-up" data-aos-delay="200">
                    <i class="fas fa-video-slash"></i>
                    <h3>No Videos Found</h3>
                    <p>Start showcasing your company culture by uploading your first video.</p>
                    <a href="${pageContext.request.contextPath}/company/media/upload/${company.id}" class="btn-add-video" style="margin-top: 20px;">
                        <i class="fas fa-plus"></i> Upload First Video
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="video-grid">
                    <c:forEach items="${mediaList}" var="media" varStatus="status">
                        <div class="video-card" data-aos="fade-up" data-aos-delay="${150 + status.index * 30}">
                            <div class="video-thumbnail-container" data-bs-toggle="modal" data-bs-target="#videoModal${media.id}">
                                <c:choose>
                                    <c:when test="${not empty media.url}">
                                        <video muted>
                                            <source src="${pageContext.request.contextPath}${media.url}" type="video/mp4">
                                        </video>
                                        <div class="video-play-icon">
                                            <i class="fas fa-play"></i>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="d-flex align-items-center justify-content-center h-100">
                                            <i class="fas fa-video-slash" style="font-size: 3rem; color: rgba(255,255,255,0.3);"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="video-card-body">
                                <h3 class="video-title">${media.title}</h3>
                                <p class="video-description">${media.description}</p>
                                <div class="video-actions">
                                    <c:if test="${not empty media.url}">
                                        <button type="button" class="btn-action btn-view" data-bs-toggle="modal" data-bs-target="#videoModal${media.id}">
                                            <i class="fas fa-play"></i> Play
                                        </button>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/company/media/delete/${media.id}/${company.id}" 
                                       class="btn-action btn-delete"
                                       onclick="return confirm('Are you sure you want to delete this video? This action cannot be undone.');">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Video Modal -->
                        <c:if test="${not empty media.url}">
                            <div class="modal fade" id="videoModal${media.id}" tabindex="-1" aria-labelledby="videoModalLabel${media.id}" aria-hidden="true">
                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="videoModalLabel${media.id}">${media.title}</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body video-modal">
                                            <video controls style="width: 100%;">
                                                <source src="${pageContext.request.contextPath}${media.url}" type="video/mp4">
                                                Your browser does not support the video tag.
                                            </video>
                                            <c:if test="${not empty media.description}">
                                                <div class="mt-3">
                                                    <p class="text-muted">${media.description}</p>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true, offset: 50 });

        // Video thumbnail hover play preview
        document.addEventListener('DOMContentLoaded', function() {
            const videoCards = document.querySelectorAll('.video-card');
            videoCards.forEach(card => {
                const video = card.querySelector('video');
                if (video) {
                    card.addEventListener('mouseenter', function() {
                        video.play().catch(e => {});
                    });
                    card.addEventListener('mouseleave', function() {
                        video.pause();
                        video.currentTime = 0;
                    });
                }
            });
        });
    </script>
</body>
</html>