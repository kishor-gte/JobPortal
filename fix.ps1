$file = "src\main\webapp\views\home.jsp"
$content = Get-Content -Path $file -Raw

# Replace href="/..." with href="${pageContext.request.contextPath}/..."
$content = [regex]::Replace($content, 'href="/([^"]*)"', 'href="${pageContext.request.contextPath}/$1"')

# Replace href="assets/..." with href="${pageContext.request.contextPath}/assets/..."
$content = [regex]::Replace($content, 'href="assets/([^"]*)"', 'href="${pageContext.request.contextPath}/assets/$1"')

# Replace src="assets/..." with src="${pageContext.request.contextPath}/assets/..."
$content = [regex]::Replace($content, 'src="assets/([^"]*)"', 'src="${pageContext.request.contextPath}/assets/$1"')

# Replace href="jobs/..." with href="${pageContext.request.contextPath}/jobs/..."
$content = [regex]::Replace($content, 'href="jobs/([^"]*)"', 'href="${pageContext.request.contextPath}/jobs/$1"')

# Replace href="jobSeekers/..." with href="${pageContext.request.contextPath}/jobSeekers/..."
$content = [regex]::Replace($content, 'href="jobSeekers/([^"]*)"', 'href="${pageContext.request.contextPath}/jobSeekers/$1"')

# Replace href="services.html" with href="${pageContext.request.contextPath}/services.html"
$content = [regex]::Replace($content, 'href="([a-zA-Z0-9-]+\.html)"', 'href="${pageContext.request.contextPath}/$1"')

Set-Content -Path $file -Value $content
