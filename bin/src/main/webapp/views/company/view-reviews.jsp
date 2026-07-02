<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Company Reviews | JobU - What Job Seekers Say</title>
    
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
            --star: #f59e0b;
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
            background: var(--gradient-dark);
            color: white;
            padding: 60px 0 50px;
            position: relative;
            overflow: hidden;
            margin-bottom: 40px;
        }
        .page-header::before {
            content: '';
            position: absolute;
            top: -30%;
            right: -10%;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(59,196,154,0.15) 0%, transparent 70%);
            border-radius: 50%;
            animation: floatGlow 20s infinite alternate;
        }
        .page-header::after {
            content: '';
            position: absolute;
            bottom: -20%;
            left: -5%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(25,167,123,0.1) 0%, transparent 70%);
            border-radius: 50%;
            animation: floatGlow2 18s infinite alternate;
        }
        @keyframes floatGlow {
            0% { transform: translate(0,0) scale(1); opacity: 0.3; }
            100% { transform: translate(-60px, 50px) scale(1.3); opacity: 0.6; }
        }
        @keyframes floatGlow2 {
            0% { transform: translate(0,0) scale(1); opacity: 0.2; }
            100% { transform: translate(60px, -40px) scale(1.2); opacity: 0.5; }
        }
        .page-header h1 {
            font-size: 2rem;
            font-weight: 800;
            background: linear-gradient(135deg, #ffffff, #3BC49A);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            animation: textShine 3s infinite;
        }
        @keyframes textShine {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }
        .page-header p {
            font-size: 1rem;
            opacity: 0.9;
        }

        /* ========== REVIEW COUNT BADGE ========== */
        .review-count-badge {
            background: var(--white);
            border-radius: var(--radius-sm);
            padding: 20px;
            box-shadow: var(--shadow-sm);
            margin-bottom: 32px;
            text-align: center;
            border: 1px solid rgba(25,167,123,0.1);
        }
        .review-count {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.08));
            color: var(--primary);
            padding: 10px 24px;
            border-radius: 60px;
            font-weight: 700;
            font-size: 0.9rem;
        }

        /* ========== REVIEW CARDS ========== */
        .reviews-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 24px;
        }
        .review-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 24px;
            transition: var(--transition);
            border: 1px solid rgba(25,167,123,0.1);
            box-shadow: var(--shadow-sm);
            animation: fadeInUp 0.6s ease backwards;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .review-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-md);
            border-color: rgba(25,167,123,0.2);
        }
        .review-header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 16px;
        }
        .reviewer-avatar {
            width: 55px;
            height: 55px;
            background: var(--gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 1.3rem;
        }
        .reviewer-info h4 {
            font-size: 1rem;
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 4px;
        }
        .review-date {
            font-size: 0.7rem;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .rating-stars {
            display: flex;
            align-items: center;
            gap: 4px;
            margin-bottom: 16px;
        }
        .rating-stars i {
            font-size: 1.1rem;
        }
        .rating-stars .rated {
            color: var(--star);
        }
        .rating-stars .unrated {
            color: var(--border);
        }
        .rating-number {
            margin-left: 8px;
            font-weight: 700;
            font-size: 0.85rem;
            color: var(--text-dark);
        }
        .review-comment {
            color: var(--text-muted);
            font-size: 0.85rem;
            line-height: 1.6;
            padding-top: 16px;
            border-top: 1px solid var(--border);
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
        .empty-state i {
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

        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 40px 0 30px; }
            .page-header h1 { font-size: 1.5rem; }
            .reviews-grid { grid-template-columns: 1fr; gap: 20px; }
            .review-card { padding: 20px; }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header" data-aos="fade-down">
        <div class="container text-center">
            <h1><i class="fas fa-star me-2"></i>Company Reviews</h1>
            <p>Reviews from Job Seekers</p>
        </div>
    </div>

    <div class="container pb-5">
        <!-- Review Count Badge -->
        <div class="review-count-badge" data-aos="fade-up">
            <div class="review-count">
                <i class="fas fa-comments"></i>
                <span>${fn:length(reviews)} Review${fn:length(reviews) != 1 ? 's' : ''}</span>
            </div>
        </div>

        <!-- Reviews List -->
        <c:choose>
            <c:when test="${not empty reviews}">
                <div class="reviews-grid">
                    <c:forEach var="review" items="${reviews}" varStatus="status">
                        <div class="review-card" data-aos="fade-up" data-aos-delay="${50 + status.index * 30}">
                            <div class="review-header">
                                <div class="reviewer-avatar">
                                    ${fn:substring(review.jobSeeker.name, 0, 1)}
                                </div>
                                <div class="reviewer-info">
                                    <h4>${review.jobSeeker.name}</h4>
                                    <div class="review-date" data-date="${review.createdAt}">
                                        <i class="far fa-clock"></i>
                                        <span class="relative-date">Loading...</span>
                                    </div>
                                </div>
                            </div>
                            <div class="rating-stars">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="fas fa-star ${i <= review.rating ? 'rated' : 'unrated'}"></i>
                                </c:forEach>
                                <span class="rating-number">${review.rating}.0</span>
                            </div>
                            <div class="review-comment">
                                <i class="fas fa-quote-left" style="color: var(--primary-light); margin-right: 8px; opacity: 0.5;"></i>
                                ${review.comment}
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state" data-aos="fade-up">
                    <i class="fas fa-comment-slash"></i>
                    <h3>No Reviews Yet</h3>
                    <p>Be the first to receive reviews from job seekers.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true, offset: 50 });

        // Format relative dates
        function formatRelativeDate(dateString) {
            try {
                const reviewDate = new Date(dateString);
                const now = new Date();
                const diffInMs = now - reviewDate;
                const diffInMins = Math.floor(diffInMs / 60000);
                const diffInHours = Math.floor(diffInMs / 3600000);
                const diffInDays = Math.floor(diffInMs / 86400000);
                const diffInWeeks = Math.floor(diffInMs / 604800000);

                if (diffInMins < 1) {
                    return 'Just now';
                } else if (diffInMins < 60) {
                    return diffInMins + ' minute' + (diffInMins !== 1 ? 's' : '') + ' ago';
                } else if (diffInHours < 24) {
                    return diffInHours + ' hour' + (diffInHours !== 1 ? 's' : '') + ' ago';
                } else if (diffInDays < 7) {
                    return diffInDays + ' day' + (diffInDays !== 1 ? 's' : '') + ' ago';
                } else if (diffInWeeks < 4) {
                    return diffInWeeks + ' week' + (diffInWeeks !== 1 ? 's' : '') + ' ago';
                } else {
                    const options = { year: 'numeric', month: 'short', day: 'numeric' };
                    return reviewDate.toLocaleDateString('en-US', options);
                }
            } catch (e) {
                return 'Unknown date';
            }
        }

        // Apply relative date formatting
        document.addEventListener('DOMContentLoaded', function() {
            const dateElements = document.querySelectorAll('.review-date[data-date]');
            dateElements.forEach(function(element) {
                const dateString = element.getAttribute('data-date');
                const relativeDateSpan = element.querySelector('.relative-date');
                if (relativeDateSpan && dateString) {
                    relativeDateSpan.textContent = formatRelativeDate(dateString);
                }
            });
        });
    </script>
</body>
</html>