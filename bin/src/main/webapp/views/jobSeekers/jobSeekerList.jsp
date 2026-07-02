<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Job Seekers List</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
:root{
--primary:#19A77B;
--dark:#148F69;
--bg:#f8fafc;
--text:#1e293b;
--border:#e2e8f0;
}

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Inter',sans-serif;
}

body{
background:var(--bg);
padding:30px;
}

.container{
max-width:1400px;
margin:auto;
}

.header{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:25px;
flex-wrap:wrap;
gap:15px;
}

.header h2{
font-size:30px;
color:var(--primary);
}

.badge{
background:white;
padding:10px 18px;
border-radius:30px;
box-shadow:0 2px 8px rgba(0,0,0,.05);
font-weight:600;
}

.table-box{
background:white;
border-radius:18px;
overflow:auto;
box-shadow:0 4px 20px rgba(0,0,0,.05);
}

table{
width:100%;
border-collapse:collapse;
min-width:1100px;
}

th{
background:#ecfdf5;
padding:16px;
text-align:left;
color:var(--primary);
font-size:13px;
}

td{
padding:15px;
border-bottom:1px solid var(--border);
font-size:14px;
}

tr:hover{
background:#f0fdf4;
}

.avatar{
width:40px;
height:40px;
border-radius:50%;
background:var(--primary);
color:white;
display:flex;
align-items:center;
justify-content:center;
font-weight:700;
}

.user-flex{
display:flex;
align-items:center;
gap:12px;
}

.tag{
padding:5px 10px;
border-radius:20px;
font-size:12px;
font-weight:600;
}

.green{background:#dcfce7;color:#166534;}
.red{background:#fee2e2;color:#991b1b;}
.yellow{background:#fef3c7;color:#92400e;}

.skills{
display:flex;
flex-wrap:wrap;
gap:6px;
}

.skill{
padding:4px 10px;
background:#ecfdf5;
border-radius:20px;
font-size:11px;
color:var(--primary);
}

a{
text-decoration:none;
color:var(--primary);
font-weight:600;
}

.back-btn{
display:inline-block;
margin-top:25px;
padding:12px 24px;
background:var(--primary);
color:white;
border-radius:30px;
}

@media(max-width:768px){
body{padding:15px;}
.header h2{font-size:24px;}
}
</style>
</head>

<body>

<div class="container">

<div class="header">
<h2><i class="fas fa-users"></i> Job Seekers List</h2>

<div class="badge">
${fn:length(jobSeekers)} Job Seekers
</div>
</div>

<c:if test="${not empty message}">
<p style="color:green;margin-bottom:15px;">${message}</p>
</c:if>

<c:if test="${not empty error}">
<p style="color:red;margin-bottom:15px;">${error}</p>
</c:if>

<div class="table-box">

<table>
<thead>
<tr>
<th>Name</th>
<th>Email</th>
<th>Phone</th>
<th>Location</th>
<th>Anonymous</th>
<th>Availability</th>
<th>Status</th>
<th>Skills</th>
<th>Action</th>
</tr>
</thead>

<tbody>

<c:forEach var="jobSeeker" items="${jobSeekers}">
<tr>

<td>
<div class="user-flex">

<div class="avatar">
<c:choose>
<c:when test="${not empty jobSeeker.name}">
${fn:substring(jobSeeker.name,0,1)}
</c:when>
<c:otherwise>U</c:otherwise>
</c:choose>
</div>

<div>${jobSeeker.name}</div>

</div>
</td>

<td>${jobSeeker.email}</td>
<td>${jobSeeker.phone}</td>
<td>${jobSeeker.location}</td>

<td>
<c:choose>
<c:when test="${jobSeeker.profileAnonymous}">
<span class="tag green">Yes</span>
</c:when>
<c:otherwise>
<span class="tag red">No</span>
</c:otherwise>
</c:choose>
</td>

<td>${jobSeeker.workAvailability}</td>

<td>
<c:choose>
<c:when test="${jobSeeker.accountStatus=='ACTIVE'}">
<span class="tag green">Active</span>
</c:when>

<c:when test="${jobSeeker.accountStatus=='INACTIVE'}">
<span class="tag red">Inactive</span>
</c:when>

<c:otherwise>
<span class="tag yellow">Pending</span>
</c:otherwise>
</c:choose>
</td>

<td>
<div class="skills">

<c:forEach var="skill" items="${jobSeeker.skills}" begin="0" end="2">
<span class="skill">${skill}</span>
</c:forEach>

</div>
</td>

<td>
<a href="${pageContext.request.contextPath}/jobSeekers/profile/${jobSeeker.id}">View</a>
|
<a href="${pageContext.request.contextPath}/jobSeekers/update/${jobSeeker.id}">Update</a>
</td>

</tr>
</c:forEach>

</tbody>
</table>

</div>

<a href="${pageContext.request.contextPath}/jobSeekers/dashboard" class="back-btn">
<i class="fas fa-arrow-left"></i> Back
</a>

</div>

</body>
</html>