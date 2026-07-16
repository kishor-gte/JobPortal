<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="comp-card">
    <div class="comp-banner">
        <c:choose>
            <c:when test="${not empty comp.bannerImage}">
                <img src="${comp.bannerImage}" alt="Competition Banner for ${comp.title}">
            </c:when>
            <c:otherwise>
                <i class="fas fa-laptop-code" aria-hidden="true"></i>
            </c:otherwise>
        </c:choose>
        <!-- Logic for status badge -->
        <c:choose>
            <c:when test="${isCompleted == true || comp.examStartTime.plusMinutes(comp.examDurationMinutes).format(sortFormatter) lt now.format(sortFormatter)}">
                <div class="comp-status-badge status-completed">Completed</div>
            </c:when>
            <c:when test="${(comp.examStartTime.format(sortFormatter) le now.format(sortFormatter)) && comp.examStartTime.plusMinutes(comp.examDurationMinutes).format(sortFormatter) gt now.format(sortFormatter)}">
                <div class="comp-status-badge status-live">Live</div>
            </c:when>
            <c:otherwise>
                <div class="comp-status-badge status-upcoming">Upcoming</div>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="comp-body">
        <div style="display: flex; justify-content: space-between; align-items: flex-start;">
            <h2 class="comp-title">${comp.title}</h2>
            <span class="badge ${comp.difficulty eq 'Hard' ? 'bg-danger' : (comp.difficulty eq 'Medium' ? 'bg-warning' : 'bg-success')}" style="padding: 4px 8px; border-radius: 4px; font-size: 11px;">
                ${comp.difficulty}
            </span>
        </div>
        <p class="comp-desc">${comp.description}</p>
        
        <div class="comp-details">
            <div class="detail-item"><i class="fas fa-file-code"></i> ${comp.numberOfQuestions} Questions</div>
            <div class="detail-item"><i class="fas fa-language"></i> ${comp.allowedLanguages}</div>
            <div class="detail-item"><i class="fas fa-users"></i> ${comp.maxParticipants} Seats</div>
            <div class="detail-item"><i class="fas fa-stopwatch"></i> ${comp.examDurationMinutes} Mins</div>
        </div>

        <div class="comp-footer">
            <c:set var="isRegistered" value="false" />
            <c:forEach var="reg" items="${studentRegistrations}">
                <c:if test="${reg.competitionId == comp.id}">
                    <c:set var="isRegistered" value="true" />
                </c:if>
            </c:forEach>

            <c:choose>
                <c:when test="${isCompleted == true}">
                    <button class="btn-register" disabled>Completed</button>
                </c:when>
                <c:when test="${isRegistered}">
                    <c:choose>
                        <c:when test="${(comp.examStartTime.format(sortFormatter) le now.format(sortFormatter)) && comp.examStartTime.plusMinutes(comp.examDurationMinutes).format(sortFormatter) gt now.format(sortFormatter)}">
                            <a href="${pageContext.request.contextPath}/student/coding-competitions/${comp.id}/start" class="btn-register" role="button" style="background: #b45309; color: white; display: block; text-align: center; text-decoration: none;"><i class="fas fa-play" aria-hidden="true"></i> Start Exam</a>
                        </c:when>
                        <c:otherwise>
                            <button class="btn-register" style="background: var(--success);" disabled><i class="fas fa-check-circle"></i> Registered</button>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:when test="${comp.examStartTime.plusMinutes(comp.examDurationMinutes).format(sortFormatter) lt now.format(sortFormatter)}">
                    <button class="btn-register" disabled>Competition Closed</button>
                </c:when>
                <c:when test="${not empty comp.registrationStartTime and now.format(sortFormatter) lt comp.registrationStartTime.format(sortFormatter)}">
                    <button class="btn-register" disabled style="font-size: 0.8rem;">Opens: ${comp.registrationStartTime.format(shortFormatter)}</button>
                </c:when>
                <c:when test="${now.format(sortFormatter) gt comp.registrationEndTime.format(sortFormatter)}">
                    <button class="btn-register" disabled>Registration Closed</button>
                </c:when>
                <c:otherwise>
                    <!-- Registration Open -->
                    <button class="btn-register" id="regBtn_${comp.id}" onclick="registerForCompetition(${comp.id})">Register Now</button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
