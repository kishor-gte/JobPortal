<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${errorCode} - ${errorTitle} | JobU</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .error-page-wrapper {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #333;
            width: 100%;
        }

        .error-container {
            text-align: center;
            background: white;
            padding: 60px 50px;
            border-radius: 20px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            max-width: 600px;
            width: 90%;
            position: relative;
            overflow: hidden;
        }

        .error-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #ff6b6b, #ee5a24, #feca57, #48dbfb);
        }

        .error-icon {
            font-size: 80px;
            color: #ee5a24;
            margin-bottom: 20px;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.1);
                opacity: 0.8;
            }
        }

        .error-code {
            font-size: 100px;
            font-weight: 800;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1;
            margin-bottom: 10px;
        }

        .error-title {
            font-size: 28px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 15px;
        }

        .error-message {
            font-size: 16px;
            color: #718096;
            margin-bottom: 10px;
            line-height: 1.6;
        }

        .error-description {
            font-size: 14px;
            color: #a0aec0;
            margin-bottom: 30px;
        }

        .btn-home {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            color: white;
            text-decoration: none;
            padding: 15px 30px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-home:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(238, 90, 36, 0.4);
            color: white;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: transparent;
            color: #ee5a24;
            text-decoration: none;
            padding: 15px 30px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            border: 2px solid #ee5a24;
            margin-left: 15px;
            cursor: pointer;
        }

        .btn-back:hover {
            background: #ee5a24;
            color: white;
        }

        .support-section {
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #e2e8f0;
        }

        .support-text {
            font-size: 14px;
            color: #718096;
            margin-bottom: 15px;
        }

        .support-link {
            color: #ee5a24;
            text-decoration: none;
            font-weight: 600;
        }

        .support-link:hover {
            text-decoration: underline;
        }

        @media (max-width: 576px) {
            .error-container {
                padding: 40px 30px;
            }

            .error-code {
                font-size: 60px;
            }

            .error-title {
                font-size: 22px;
            }

            .btn-home, .btn-back {
                display: block;
                margin: 10px 0;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <div class="error-page-wrapper">
        <div class="error-container">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            
            <div class="error-code">${errorCode}</div>
            
            <h1 class="error-title">${errorTitle}</h1>
            
            <p class="error-message">
                ${errorMessage}
            </p>
            
            <p class="error-description">
                ${errorDescription}
            </p>
    
            <div class="d-flex justify-content-center flex-wrap">
                <a href="${pageContext.request.contextPath}/" class="btn-home">
                    <i class="fas fa-home"></i>
                    Go Home
                </a>
                <button onclick="history.back()" class="btn-back">
                    <i class="fas fa-arrow-left"></i>
                    Go Back
                </button>
            </div>
    
            <div class="support-section">
                <p class="support-text">
                    Need help? Contact our support team at 
                    <a href="mailto:support@jobu.com" class="support-link">support@jobu.com</a>
                </p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
