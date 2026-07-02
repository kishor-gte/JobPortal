<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Upload Result | JobU - Assessment Management</title>
    
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
            --success: #10b981;
            --danger: #ef4444;
            --gradient: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
            --gradient-dark: linear-gradient(135deg, #1e2f32 0%, #2E3E41 100%);
            --shadow-sm: 0 10px 25px -5px rgba(0,0,0,0.05);
            --shadow-md: 0 20px 35px -12px rgba(25,167,123,0.15);
            --shadow-lg: 0 30px 50px -15px rgba(0,0,0,0.12);
            --radius: 32px;
            --transition: all 0.4s cubic-bezier(0.2, 0.95, 0.4, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #f8fafc 0%, #e6f4ef 100%);
            color: var(--text-dark);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #e6f4ef; border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: var(--primary-dark); }

        /* ========== RESULT CARD ========== */
        .result-card {
            max-width: 550px;
            width: 100%;
            background: var(--white);
            border-radius: var(--radius);
            padding: 50px 45px;
            text-align: center;
            box-shadow: var(--shadow-lg);
            border: 1px solid rgba(25,167,123,0.1);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }
        .result-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: var(--gradient);
        }
        .result-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 35px 50px -20px rgba(25,167,123,0.3);
            border-color: rgba(25,167,123,0.2);
        }

        /* Result Icon */
        .result-icon {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3.5rem;
            margin: 0 auto 28px;
            transition: var(--transition);
        }
        .result-card:hover .result-icon {
            transform: scale(1.05);
        }
        .result-icon.success {
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.08));
            color: var(--primary);
        }
        .result-icon.error {
            background: linear-gradient(135deg, rgba(239,68,68,0.12), rgba(239,68,68,0.08));
            color: var(--danger);
        }

        /* Title */
        .result-title {
            font-size: 2rem;
            font-weight: 800;
            margin-bottom: 16px;
            background: linear-gradient(135deg, var(--text-dark), var(--primary));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        /* Message */
        .result-message {
            font-size: 1rem;
            color: var(--text-muted);
            line-height: 1.7;
            margin-bottom: 32px;
        }

        /* Back Button */
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 60px;
            padding: 12px 32px;
            font-weight: 700;
            font-size: 0.9rem;
            text-decoration: none;
            transition: var(--transition);
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
        }
        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
            color: white;
        }

        /* Responsive */
        @media (max-width: 576px) {
            .result-card {
                padding: 35px 28px;
            }
            .result-title {
                font-size: 1.6rem;
            }
            .result-icon {
                width: 80px;
                height: 80px;
                font-size: 2.8rem;
            }
            .btn-back {
                padding: 10px 24px;
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>

    <div class="result-card" data-aos="fade-up" data-aos-duration="800">
        <c:choose>
            <c:when test="${not empty message && (fn:contains(message, 'Successfully') or fn:contains(message, 'success') or fn:contains(message, 'uploaded'))}">
                <div class="result-icon success">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h1 class="result-title">Upload Successful!</h1>
            </c:when>
            <c:otherwise>
                <div class="result-icon error">
                    <i class="fas fa-exclamation-circle"></i>
                </div>
                <h1 class="result-title">Upload Failed</h1>
            </c:otherwise>
        </c:choose>
        
        <p class="result-message">${message}</p>
        
        <a href="${pageContext.request.contextPath}/jobs/by-company/${companyId}" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Job Listings
        </a>
    </div>

    <!-- Scripts -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true, offset: 50 });
    </script>
</body>
</html>