<%@ page session="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Service Details | SmartInterview</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Razorpay & jQuery -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- ENHANCED THEME -->
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --border-color: #e0e6ed;
            --white: #ffffff;
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: var(--text-primary);
            min-height: 100vh;
            position: relative;
        }

        /* Animated background pattern */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.03) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.03) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: backgroundPulse 15s ease-in-out infinite;
        }

        @keyframes backgroundPulse {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }

        .container {
            position: relative;
            z-index: 1;
        }

        h1, h2, h3, h4, h5, h6 {
            color: var(--text-primary);
            font-weight: 600;
        }

        .details-card {
            background: var(--white);
            border-radius: 24px;
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            border: 1px solid rgba(25, 167, 123, 0.1);
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .carousel-item img {
            height: 400px;
            object-fit: cover;
            border-bottom: 3px solid var(--primary);
        }

        .carousel-item.bg-secondary {
            background: linear-gradient(135deg, rgba(25, 167, 123, 0.1), rgba(59, 196, 154, 0.1)) !important;
            color: var(--primary) !important;
        }

        .price {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 800;
        }

        .btn-primary {
            background: var(--gradient-primary);
            border: none;
            font-weight: 600;
            padding: 12px 24px;
            border-radius: 12px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 16px rgba(25, 167, 123, 0.3);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .btn-outline-secondary {
            border: 2px solid var(--primary);
            color: var(--primary);
            font-weight: 600;
            padding: 10px 24px;
            border-radius: 30px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-outline-secondary:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--glow-primary);
        }

        .icon-primary {
            color: var(--primary);
        }

        .booking-card {
            background: var(--white);
            border-radius: 18px;
            box-shadow: var(--shadow-md);
            border: 1px solid rgba(25, 167, 123, 0.1);
        }

        .booking-card h6 {
            color: var(--primary);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 16px;
        }

        .alert-info {
            background: rgba(25, 167, 123, 0.08);
            border: 1px solid rgba(25, 167, 123, 0.2);
            color: var(--primary);
            border-radius: 12px;
        }

        hr {
            border-color: var(--border-color);
            opacity: 0.5;
        }

        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            background-color: var(--primary);
            border-radius: 50%;
            padding: 20px;
        }

        .btn-sm {
            padding: 6px 14px;
            border-radius: 20px;
        }

        .fw-bold.fs-5 span:first-child {
            color: var(--text-primary);
        }

        .fw-bold.fs-5 span:last-child {
            color: var(--primary);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .carousel-item img {
                height: 250px;
            }

            .details-card .p-5 {
                padding: 24px !important;
            }

            h1 {
                font-size: 1.75rem;
            }

            .price {
                font-size: 1.5rem;
            }
        }
    </style>
</head>

<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">

            <a href="${pageContext.request.contextPath}/recruiter/explore"
               class="btn-outline-secondary mb-4">
                <i class="fas fa-arrow-left"></i> Back to Explore
            </a>

            <div class="details-card">

                <!-- Image Carousel -->
                <div id="serviceCarousel" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <c:choose>
                            <c:when test="${not empty service.coverImageUrl}">
                                <c:set var="imgUrl" value="${service.coverImageUrl}" />
                                <c:if test="${not imgUrl.startsWith('/')}">
                                    <c:set var="imgUrl" value="/${imgUrl}" />
                                </c:if>
                                <div class="carousel-item active">
                                    <img src="${pageContext.request.contextPath}${imgUrl}"
                                         class="d-block w-100" alt="${service.serviceTitle}"
                                         onerror="this.src='https://placehold.co/800x400/e2e8f0/5a6e66?text=Sports+Event'">
                                </div>
                                <c:forEach items="${service.galleryImageUrls}" var="galUrl">
                                    <c:set var="fmtGalUrl" value="${galUrl}" />
                                    <c:if test="${not fmtGalUrl.startsWith('/')}">
                                        <c:set var="fmtGalUrl" value="/${fmtGalUrl}" />
                                    </c:if>
                                    <div class="carousel-item">
                                        <img src="${pageContext.request.contextPath}${fmtGalUrl}"
                                             class="d-block w-100" alt="${service.serviceTitle}">
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="carousel-item active bg-secondary text-white d-flex align-items-center justify-content-center"
                                     style="height: 300px;">
                                    <h3><i class="fas fa-image me-2"></i>No Images Available</h3>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <button class="carousel-control-prev" type="button"
                            data-bs-target="#serviceCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon"></span>
                    </button>
                    <button class="carousel-control-next" type="button"
                            data-bs-target="#serviceCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon"></span>
                    </button>
                </div>

                <div class="p-5">

                    <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
                        <div>
                            <h1 class="mb-2">
                                <i class="fas fa-tag icon-primary me-2"></i>${service.serviceTitle}
                            </h1>
                            <p class="text-muted">
                                <i class="fas fa-map-marker-alt me-2 icon-primary"></i>
                                ${service.venueName}, ${service.city}
                            </p>
                        </div>
                        <div class="text-end">
                            <h2 class="price">₹${service.basePrice}</h2>
                            <span class="text-muted">per ${service.pricingUnit}</span>
                        </div>
                    </div>

                    <hr class="my-4">

                    <div class="row">
                        <!-- LEFT -->
                        <div class="col-md-8">

                            <h5><i class="fas fa-align-left icon-primary me-2"></i>Description</h5>
                            <p>${service.description}</p>

                            <h5 class="mt-4"><i class="fas fa-calendar-check icon-primary me-2"></i>Availability & Capacity</h5>
                            <div class="row small">
                                <div class="col-6"><b>Max Participants:</b> ${service.maxParticipants}</div>
                                <div class="col-6"><b>Duration:</b> ${service.durationInHours} Hours</div>
                                <div class="col-6"><b>Weekdays:</b> ${service.availableOnWeekdays ? 'Yes' : 'No'}</div>
                                <div class="col-6"><b>Weekends:</b> ${service.availableOnWeekends ? 'Yes' : 'No'}</div>
                                <div class="col-12"><b>Time:</b> ${service.availableFrom} - ${service.availableTo}</div>
                            </div>

                            <h5 class="mt-4"><i class="fas fa-check-circle icon-primary me-2"></i>Inclusions</h5>
                            <div class="row small">
                                <div class="col-6"><i class="fas fa-check-circle icon-primary me-2"></i>Referee</div>
                                <div class="col-6"><i class="fas fa-check-circle icon-primary me-2"></i>Equipment</div>
                                <div class="col-6"><i class="fas fa-check-circle icon-primary me-2"></i>Ground</div>
                                <div class="col-6"><i class="fas fa-check-circle icon-primary me-2"></i>Medical</div>
                            </div>

                            <c:if test="${not empty service.otherInclusions}">
                                <p class="mt-2 small"><b>Others:</b> ${service.otherInclusions}</p>
                            </c:if>

                            <c:if test="${service.customizable}">
                                <div class="alert alert-info mt-3">
                                    <i class="fas fa-sliders-h me-2"></i><b>Customizable Package</b><br>
                                    ${service.customizationOptions}
                                </div>
                            </c:if>

                            <h5 class="mt-4"><i class="fas fa-map-pin icon-primary me-2"></i>Location</h5>
                            <p>${service.venueAddress}</p>

                            <c:if test="${not empty service.googleMapUrl}">
                                <a href="${service.googleMapUrl}" target="_blank"
                                   class="btn btn-sm btn-outline-secondary">
                                    <i class="fas fa-map-marked-alt"></i> View on Map
                                </a>
                            </c:if>

                            <h5 class="mt-4"><i class="fas fa-clipboard-list icon-primary me-2"></i>Rules</h5>
                            <ul class="small">
                                <li>${service.rulesAndGuidelines}</li>
                            </ul>

                        </div>

                        <!-- RIGHT -->
                        <div class="col-md-4">
                            <div class="booking-card p-4">

                                <h6><i class="fas fa-shopping-cart me-2"></i>Booking Summary</h6>

                                <p class="d-flex justify-content-between">
                                    <span>Base Price</span>
                                    <strong>₹${service.basePrice}</strong>
                                </p>

                                <c:set var="taxVal" value="${service.taxPercent != null ? service.taxPercent : 0}" />
                                <c:set var="taxAmount" value="${service.basePrice * taxVal / 100.0}" />
                                <c:set var="depositVal" value="${service.refundableDeposit != null ? service.refundableDeposit : 0}" />
                                <c:set var="totalAmount" value="${service.basePrice + taxAmount + depositVal}" />

                                <c:if test="${taxVal > 0}">
                                    <p class="d-flex justify-content-between">
                                        <span>Tax (${taxVal}%)</span>
                                        <strong>₹<fmt:formatNumber value="${taxAmount}" pattern="#,##0.00"/></strong>
                                    </p>
                                </c:if>

                                <c:if test="${depositVal > 0}">
                                    <p class="d-flex justify-content-between" style="color: var(--warning);">
                                        <span>Deposit (Refundable)</span>
                                        <strong>₹${depositVal}</strong>
                                    </p>
                                </c:if>

                                <hr>

                                <p class="d-flex justify-content-between fw-bold fs-5">
                                    <span>Total</span>
                                    <span>₹<fmt:formatNumber value="${totalAmount}" pattern="#,##0.00"/></span>
                                </p>

                                <button id="rzp-button1"
                                        class="btn btn-primary w-100 fw-bold">
                                    <i class="fas fa-credit-card me-2"></i> Book Now
                                </button>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Hidden Form -->
<form id="bookingForm"
      action="${pageContext.request.contextPath}/recruiter/booking/confirm"
      method="post">
    <input type="hidden" name="serviceId" value="${service.id}">
    <input type="hidden" name="amount" value="${totalAmount}">
    <input type="hidden" id="razorpayPaymentId" name="razorpayPaymentId">
    <input type="hidden" id="razorpayOrderId" name="razorpayOrderId">
    <input type="hidden" id="razorpaySignature" name="razorpaySignature">
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.getElementById('rzp-button1').onclick = function(e){
    e.preventDefault();
    var amountRaw = ${totalAmount};

    // Show loading state on button
    var btn = this;
    var originalText = btn.innerHTML;
    btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Processing...';
    btn.disabled = true;

    $.ajax({
        url: "${pageContext.request.contextPath}/createOrder",
        data: { amount: amountRaw },
        type: "POST",
        dataType: "json",
          success: function (response) {
              // Reset button
              btn.innerHTML = originalText;
              btn.disabled = false;
              
              if (response.id && response.id.startsWith("order_mock_")) {
                  document.getElementById('razorpayPaymentId').value = "mock_payment_id";
                  document.getElementById('razorpayOrderId').value = response.id;
                  document.getElementById('razorpaySignature').value = "mock_signature";
                  document.getElementById('bookingForm').submit();
                  return;
              }
              
              var options = {
                key: "rzp_test_RIlD5bEKRjyn3h",
                amount: response.amount,
                currency: "INR",
                name: "Sports Booking",
                description: "Booking for ${service.serviceTitle}",
                order_id: response.id,
                handler: function (response) {
                    document.getElementById('razorpayPaymentId').value = response.razorpay_payment_id;
                    document.getElementById('razorpayOrderId').value = response.razorpay_order_id;
                    document.getElementById('razorpaySignature').value = response.razorpay_signature;
                    document.getElementById('bookingForm').submit();
                },
                theme: { color: "#19A77B" }
            };
            new Razorpay(options).open();
        },
        error: function () {
            btn.innerHTML = originalText;
            btn.disabled = false;
            alert("Could not start payment. Try again.");
        }
    });
};
</script>

</body>
</html>
