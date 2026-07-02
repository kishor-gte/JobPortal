<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>${service.serviceTitle} - Book Now | JobU Corporate Sports</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <!-- Razorpay -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>

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
            padding: 50px 0 40px;
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
        .page-header h2 {
            font-size: 1.8rem;
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

        /* Back Button */
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(8px);
            color: white;
            border: 1px solid rgba(255,255,255,0.3);
            border-radius: 50px;
            padding: 8px 20px;
            font-weight: 600;
            font-size: 0.85rem;
            text-decoration: none;
            transition: var(--transition);
        }
        .back-btn:hover {
            background: var(--white);
            color: var(--primary);
            transform: translateX(-4px);
        }

        /* Service Image */
        .service-image {
            width: 100%;
            height: 320px;
            object-fit: cover;
            border-radius: 20px;
            transition: var(--transition);
        }
        .service-image:hover {
            transform: scale(1.02);
        }

        /* Info Cards */
        .info-card {
            background: var(--white);
            border-radius: var(--radius-sm);
            padding: 24px;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(25,167,123,0.1);
            transition: var(--transition);
            margin-bottom: 24px;
        }
        .info-card:hover {
            box-shadow: var(--shadow-md);
        }

        /* Price Box */
        .price-box {
            background: var(--gradient);
            border-radius: var(--radius-sm);
            padding: 28px;
            text-align: center;
            color: white;
            margin-bottom: 24px;
        }
        .price-amount {
            font-size: 2.8rem;
            font-weight: 800;
        }
        .price-unit {
            font-size: 0.9rem;
            opacity: 0.8;
        }

        /* Feature List */
        .feature-list {
            list-style: none;
            padding: 0;
        }
        .feature-list li {
            padding: 10px 0;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .feature-list li:last-child {
            border-bottom: none;
        }
        .feature-list i {
            color: var(--primary);
            width: 22px;
        }

        /* Form Controls */
        .form-control, .form-select {
            border: 2px solid var(--border);
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 0.9rem;
            transition: var(--transition);
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.1);
            outline: none;
        }
        .btn-primary {
            background: var(--gradient);
            border: none;
            padding: 14px;
            font-weight: 700;
            border-radius: 60px;
            transition: var(--transition);
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }
        .btn-outline-secondary {
            border-radius: 60px;
            padding: 12px;
            font-weight: 600;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 35px 0 25px; }
            .page-header h2 { font-size: 1.3rem; }
            .service-image { height: 220px; }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header" data-aos="fade-down">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <div>
                    <h2><i class="fas fa-futbol me-2"></i>${service.serviceTitle}</h2>
                    <p class="mb-0 opacity-75">Book this sports service for your company</p>
                </div>
                <a href="${pageContext.request.contextPath}/company/sports/explore" class="back-btn">
                    <i class="fas fa-arrow-left"></i> Back to Explore
                </a>
            </div>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row">
            <!-- Service Details Column -->
            <div class="col-lg-8" data-aos="fade-right" data-aos-delay="100">
                <div class="info-card">
                    <c:choose>
                        <c:when test="${not empty service.coverImageUrl}">
                            <img src="${pageContext.request.contextPath}${service.coverImageUrl}"
                                 class="service-image mb-4" alt="${service.serviceTitle}"
                                 onerror="this.src='https://placehold.co/800x400/e2e8f0/5a6e66?text=Sports+Event'">
                        </c:when>
                        <c:otherwise>
                            <div class="service-image d-flex align-items-center justify-content-center bg-light text-muted mb-4">
                                <i class="fas fa-image fa-5x"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <h4 class="fw-bold mb-3" style="color: var(--text-dark);">About This Service</h4>
                    <p class="lead" style="color: var(--text-muted);">${service.description}</p>

                    <div class="row mt-4">
                        <div class="col-md-6">
                            <p><i class="fas fa-map-marker-alt" style="color: var(--primary); width: 24px;"></i> <strong>City:</strong> ${not empty service.city ? service.city : 'N/A'}</p>
                            <p><i class="fas fa-users" style="color: var(--primary); width: 24px;"></i> <strong>Max Capacity:</strong> ${not empty service.maxParticipants ? service.maxParticipants : 'N/A'} people</p>
                        </div>
                        <div class="col-md-6">
                            <p><i class="fas fa-clock" style="color: var(--primary); width: 24px;"></i> <strong>Duration:</strong> ${not empty service.durationInHours ? service.durationInHours : 'N/A'} hours</p>
                            <p><i class="fas fa-tag" style="color: var(--primary); width: 24px;"></i> <strong>Pricing Unit:</strong> ${service.pricingUnit}</p>
                        </div>
                    </div>

                    <h5 class="fw-bold mt-4 mb-3" style="color: var(--text-dark);">What's Included</h5>
                    <ul class="feature-list">
                        <c:if test="${service.refereeIncluded}">
                            <li><i class="fas fa-check-circle"></i> Referee / Umpire</li>
                        </c:if>
                        <c:if test="${service.equipmentIncluded}">
                            <li><i class="fas fa-check-circle"></i> Equipment Provided</li>
                        </c:if>
                        <c:if test="${service.groundIncluded}">
                            <li><i class="fas fa-check-circle"></i> Ground / Court</li>
                        </c:if>
                        <c:if test="${service.medicalSupport}">
                            <li><i class="fas fa-check-circle"></i> Medical Support</li>
                        </c:if>
                        <c:if test="${not empty service.otherInclusions}">
                            <li><i class="fas fa-check-circle"></i> ${service.otherInclusions}</li>
                        </c:if>
                    </ul>
                </div>
            </div>

            <!-- Booking Panel Column -->
            <div class="col-lg-4" data-aos="fade-left" data-aos-delay="200">
                <div class="price-box">
                    <div class="text-muted mb-2" style="opacity: 0.8;">Starting at</div>
                    <div class="price-amount">₹${service.basePrice}</div>
                    <div class="price-unit">per ${service.pricingUnit}</div>
                </div>

                <div class="info-card">
                    <h5 class="fw-bold mb-3" style="color: var(--text-dark);">
                        <i class="fas fa-calendar-check" style="color: var(--primary);"></i> Book Now
                    </h5>
                    
                    <form id="bookingForm">
                        <div class="mb-3">
                            <label for="eventDate" class="form-label fw-semibold">Event Date</label>
                            <input type="date" class="form-control" id="eventDate" name="eventDate" required>
                        </div>

                        <div class="mb-3">
                            <label for="participants" class="form-label fw-semibold">Expected Participants</label>
                            <input type="number" class="form-control" id="participants" name="participants" 
                                   min="1" max="${service.maxParticipants}" 
                                   placeholder="Number of participants" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Company</label>
                            <input type="text" class="form-control" value="${company.name}" readonly disabled style="background: var(--bg-light);">
                        </div>

                        <div class="d-grid gap-3">
                            <button type="button" id="payButton" class="btn btn-primary btn-lg">
                                <i class="fas fa-credit-card me-2"></i>Pay & Book Now
                            </button>
                            <a href="${pageContext.request.contextPath}/company/sports/explore" class="btn btn-outline-secondary">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>

                <div class="info-card">
                    <h6 class="fw-bold mb-3" style="color: var(--text-dark);">
                        <i class="fas fa-shield-alt" style="color: var(--primary);"></i> Booking Protection
                    </h6>
                    <ul class="list-unstyled mb-0 small" style="color: var(--text-muted);">
                        <li class="mb-2"><i class="fas fa-check-circle" style="color: var(--primary);"></i> Secure payment</li>
                        <li class="mb-2"><i class="fas fa-check-circle" style="color: var(--primary);"></i> Instant confirmation</li>
                        <li><i class="fas fa-check-circle" style="color: var(--primary);"></i> 24/7 support</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true, offset: 50 });

        // Store JSP values in JavaScript variables
        const serviceId = '${service.id}';
        const serviceTitle = '${service.serviceTitle}';
        const servicePrice = parseFloat('${service.basePrice}');
        const companyName = '${company.name}';
        const companyEmail = '${company.email}';
        const companyPhone = '${not empty company.phone ? company.phone : ''}';
        const contextPath = '${pageContext.request.contextPath}';

        document.getElementById('payButton').addEventListener('click', function(e) {
            e.preventDefault();
            
            const eventDate = document.getElementById('eventDate').value;
            const participants = document.getElementById('participants').value;
            
            if (!eventDate || !participants) {
                alert('Please fill in all required fields');
                return;
            }
            
            // Create order via AJAX
            fetch(contextPath + '/createOrder', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'amount=' + servicePrice
            })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                const options = {
                    key: "rzp_test_RIlD5bEKRjyn3h",
                    amount: data.amount,
                    currency: "INR",
                    name: "Corporate Sports Booking",
                    description: serviceTitle,
                    order_id: data.id,
                    handler: function (response) {
                        const form = document.createElement('form');
                        form.method = 'POST';
                        form.action = contextPath + '/company/sports/booking/confirm';
                        
                        const fields = [
                            { name: 'serviceId', value: serviceId },
                            { name: 'razorpayPaymentId', value: response.razorpay_payment_id },
                            { name: 'razorpayOrderId', value: response.razorpay_order_id },
                            { name: 'razorpaySignature', value: response.razorpay_signature },
                            { name: 'amount', value: servicePrice },
                            { name: 'participants', value: participants },
                            { name: 'eventDate', value: eventDate }
                        ];
                        
                        for (let i = 0; i < fields.length; i++) {
                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = fields[i].name;
                            input.value = fields[i].value;
                            form.appendChild(input);
                        }
                        
                        document.body.appendChild(form);
                        form.submit();
                    },
                    prefill: {
                        name: companyName,
                        email: companyEmail,
                        contact: companyPhone
                    },
                    theme: {
                        color: "#19A77B"
                    }
                };
                
                const rzp = new Razorpay(options);
                rzp.open();
            })
            .catch(function(error) {
                console.error('Error:', error);
                alert('Failed to initiate payment. Please try again.');
            });
        });

        // Set minimum date to today
        document.getElementById('eventDate').min = new Date().toISOString().split('T')[0];
    </script>
</body>
</html>