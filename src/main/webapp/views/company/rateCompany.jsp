<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Rate & Review - ${company.name} | JobU</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
            --gradient: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
            --gradient-dark: linear-gradient(135deg, #1e2f32 0%, #2E3E41 100%);
            --shadow-sm: 0 10px 25px -5px rgba(0,0,0,0.05);
            --shadow-md: 0 20px 35px -12px rgba(25,167,123,0.15);
            --shadow-lg: 0 30px 50px -15px rgba(0,0,0,0.12);
            --radius: 24px;
            --radius-sm: 16px;
            --transition: all 0.4s cubic-bezier(0.2, 0.95, 0.4, 1);
            --star-1: #f97316;
            --star-2: #f59e0b;
            --star-3: #eab308;
            --star-4: #fbbf24;
            --star-5: #fcd34d;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            height: 100vh;
            position: relative;
            overflow: hidden; /* Fix page moving while scrolling */
        }

        /* Premium Background with Overlay */
        body::before {
            content: "";
            position: fixed;
            inset: 0;
            background: radial-gradient(circle at top right, rgba(25,167,123,0.1), transparent 40%),
                        radial-gradient(circle at bottom left, rgba(59,196,154,0.1), transparent 40%),
                        var(--bg-light);
            z-index: -2;
        }

        /* ========== REVIEW CARD ========== */
        .review-container {
            height: 100%;
            width: 100%;
            display: flex;
            align-items: center; 
            justify-content: center;
            padding: 80px 20px;
            overflow-y: auto; /* Fix page moving while scrolling */
        }
        .review-box {
            background: var(--white);
            border-radius: var(--radius);
            padding: 40px 45px;
            max-width: 580px;
            width: 100%;
            box-shadow: var(--shadow-lg);
            border: 1px solid rgba(25,167,123,0.1);
            transition: var(--transition);
            margin: auto; /* Centering */
        }
        .review-box:hover {
            box-shadow: 0 30px 50px -20px rgba(25,167,123,0.3);
            border-color: rgba(25,167,123,0.2);
        }

        /* Header */
        .review-header {
            text-align: center;
            margin-bottom: 32px;
        }

        .company-icon {
            width: 70px;
            height: 70px;
            background: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            box-shadow: 0 8px 16px var(--primary-glow);
        }

        .company-icon i {
            font-size: 32px;
            color: var(--white);
        }

        .review-header h2 {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--primary-dark);
            margin-bottom: 8px;
        }

        .review-header p {
            font-size: 0.95rem;
            color: var(--text-muted);
            font-weight: 500;
        }

        /* Form Labels */
        .form-group {
            margin-bottom: 24px;
        }
        label {
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--text-dark);
            display: block;
            margin-bottom: 10px;
        }
        label i {
            color: var(--primary);
            margin-right: 8px;
        }

        /* ===== STAR RATING SYSTEM ===== */
        .star-rating {
            display: inline-flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
            gap: 10px;
            font-size: 2.2rem;
        }
        .star-rating input[type="radio"] {
            display: none;
        }
        .star-rating label {
            color: #d1d5db;
            cursor: pointer;
            transition: transform 0.2s ease, color 0.2s ease;
            margin-bottom: 0;
            font-size: 2rem;
        }
        .star-rating label:hover {
            transform: scale(1.15);
        }
        #star1:checked ~ label,
        label[for="star1"]:hover,
        label[for="star1"]:hover ~ label { color: var(--star-1); }
        #star2:checked ~ label,
        label[for="star2"]:hover,
        label[for="star2"]:hover ~ label { color: var(--star-2); }
        #star3:checked ~ label,
        label[for="star3"]:hover,
        label[for="star3"]:hover ~ label { color: var(--star-3); }
        #star4:checked ~ label,
        label[for="star4"]:hover,
        label[for="star4"]:hover ~ label { color: var(--star-4); }
        #star5:checked ~ label,
        label[for="star5"]:hover,
        label[for="star5"]:hover ~ label { color: var(--star-5); }

        /* Textarea */
        textarea {
            width: 100%;
            min-height: 130px;
            padding: 14px 16px;
            border: 2px solid var(--border);
            border-radius: 16px;
            font-size: 0.9rem;
            font-family: inherit;
            resize: vertical;
            transition: var(--transition);
            background: var(--bg-light);
            color: var(--text-dark);
        }
        textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.1);
            background: var(--white);
        }
        textarea::placeholder {
            color: var(--text-muted);
        }

        /* Submit Button */
        .submit-btn {
            width: 100%;
            background: var(--gradient);
            color: white;
            border: none;
            padding: 14px 28px;
            font-size: 1rem;
            font-weight: 700;
            border-radius: 60px;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
            position: relative;
            overflow: hidden;
            margin-top: 10px;
        }
        .submit-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255,255,255,0.3);
            transform: translate(-50%, -50%);
            transition: width 0.5s, height 0.5s;
        }
        .submit-btn:hover::before {
            width: 300px;
            height: 300px;
        }
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
        }

        /* Responsive */
        @media (max-width: 576px) {
            .review-box { padding: 28px 24px; margin: 10px; width: 100%; }
            .review-header h2 { font-size: 1.4rem; }
            .star-rating { font-size: 1.8rem; gap: 6px; }
            .star-rating label { font-size: 1.6rem; }
            .review-container { padding: 60px 15px 20px; }
        }
        .btn-back {
            position: fixed;
            top: 20px;
            left: 20px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            background: var(--white);
            color: var(--text-dark);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: var(--transition);
            z-index: 10;
        }
        .btn-back:hover {
            background: var(--bg-light);
            border-color: var(--primary);
            color: var(--primary);
        }
    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}/company/details/${company.id}" class="btn-back"><i class="fas fa-arrow-left"></i> Back to Company</a>

<div class="review-container">
    <div class="review-box" data-aos="fade-up" data-aos-duration="800">
        <div class="review-header">
            <div class="company-icon">
                <i class="fas fa-building"></i>
            </div>
            <h2>Rate & Review</h2>
            <p>${company.name}</p>
        </div>

        <form action="${pageContext.request.contextPath}/company/review/save" method="post">
            <input type="hidden" name="companyId" value="${company.id}" />

            <div class="form-group">
                <label><i class="fas fa-star"></i> Your Rating</label>
                <div class="star-rating">
                    <input type="radio" id="star5" name="rating" value="5" required /><label for="star5">★</label>
                    <input type="radio" id="star4" name="rating" value="4" /><label for="star4">★</label>
                    <input type="radio" id="star3" name="rating" value="3" /><label for="star3">★</label>
                    <input type="radio" id="star2" name="rating" value="2" /><label for="star2">★</label>
                    <input type="radio" id="star1" name="rating" value="1" /><label for="star1">★</label>
                </div>
            </div>

            <div class="form-group">
                <label><i class="fas fa-pen-fancy"></i> Your Review (Max 500 characters)</label>
                <textarea name="comment" placeholder="Share your experience working with this company... What did you like? What could be improved?" maxlength="500" required></textarea>
                <div style="text-align: right; font-size: 0.8rem; color: var(--text-muted); margin-top: 5px;" id="charCount">0 / 500</div>
            </div>

            <button type="submit" class="submit-btn">
                <i class="fas fa-paper-plane me-2"></i> Submit Review
            </button>
        </form>
    </div>
</div>

<!-- Scripts -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({ duration: 800, once: true, offset: 50 });
    
    const textarea = document.querySelector('textarea[name="comment"]');
    const charCount = document.getElementById('charCount');
    const form = document.querySelector('form');
    
    textarea.addEventListener('input', function() {
        charCount.textContent = this.value.length + " / 500";
    });
    
    form.addEventListener('submit', function(e) {
        if (textarea.value.trim().length === 0) {
            e.preventDefault();
            alert("Your review cannot be empty or consist only of spaces.");
            textarea.focus();
        } else if (textarea.value.length > 500) {
            e.preventDefault();
            alert("Your review exceeds the 500 character limit.");
            textarea.focus();
        }
    });
</script>
<jsp:include page="/views/commons/chatbot.jsp" />
</body>
</html>