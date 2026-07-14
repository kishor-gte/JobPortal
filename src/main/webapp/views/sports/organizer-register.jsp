<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<meta charset="UTF-8">
<title>Sports Organizer Registration</title>
</head>
<body>

<h2>Sports Organizer Registration</h2>

<form action="${pageContext.request.contextPath}/organizer/register"
      method="post"
      enctype="multipart/form-data">


<!-- ================= BASIC INFO ================= -->
<h3>Basic Information</h3>

<label>Organization Name</label><br/>
<input type="text" name="organizationName" required /><br/><br/>

<label>Contact Person Name</label><br/>
<input type="text" name="contactPersonName" required /><br/><br/>

<label>Email</label><br/>
<input type="email" name="email" required /><br/><br/>

<label>Password</label><br/>
<input type="password" name="password" required /><br/><br/>

<label>Phone Number</label><br/>
<input type="text" name="phone" required /><br/><br/>

<!-- ================= BUSINESS DETAILS ================= -->
<h3>Business & Credibility Details</h3>

<label>Company / Registration Number</label><br/>
<input type="text" name="registrationNumber" /><br/><br/>

<label>GST Number</label><br/>
<input type="text" name="gstNumber" /><br/><br/>

<label>Years of Experience</label><br/>
<input type="number" name="yearsOfExperience" min="0" /><br/><br/>

<label>Number of Events Conducted</label><br/>
<input type="number" name="eventsConducted" min="0" /><br/><br/>

<label>Corporate Clients (comma separated)</label><br/>
<input type="text" name="corporateClients" placeholder="Infosys, TCS, Accenture" /><br/><br/>

<label>About Your Organization</label><br/>
<textarea name="aboutOrganization" rows="4" cols="50"></textarea><br/><br/>

<h3>Upload Verification Documents</h3>

<label>GST / Company Registration Documents</label><br/>
<!-- Documents -->
<input type="file"
       name="documentFiles"
       multiple
       accept=".pdf,.jpg,.png" />
<br/><br/>


<!-- ================= SPORTS INFO ================= -->
<h3>Sports Information</h3>

<label>Sports Handled</label><br/>
<input type="text" name="sportsHandled" placeholder="Cricket, Football, Badminton" /><br/><br/>

<h3>Upload Past Event Photos</h3>


<input type="file" id="photoInput" accept="image/*" />
<button type="button" onclick="addPhoto()">Add Photo</button>

<ul id="photoList"></ul>

<!-- hidden input just for backend binding -->
<input type="file" name="eventPhotoFiles" id="finalPhotos" multiple hidden />






<!-- ================= ADDRESS ================= -->
<h3>Address Details</h3>

<label>Address</label><br/>
<input type="text" name="address" /><br/><br/>

<label>City</label><br/>
<input type="text" name="city" /><br/><br/>

<label>State</label><br/>
<input type="text" name="state" /><br/><br/>

<label>Country</label><br/>
<input type="text" name="country" value="India" /><br/><br/>

<label>Pincode</label><br/>
<input type="text" name="pincode" /><br/><br/>

<!-- ================= BANK DETAILS ================= -->
<h3>Bank / Payment Details</h3>

<label>Bank Name</label><br/>
<input type="text" name="bankName" /><br/><br/>

<label>Account Number</label><br/>
<input type="text" name="accountNumber" /><br/><br/>

<label>IFSC Code</label><br/>
<input type="text" name="ifscCode" /><br/><br/>

<label>UPI ID</label><br/>
<input type="text" name="upiId" /><br/><br/>

<!-- ================= SUBMIT ================= -->
<button type="submit">Register</button>

</form>
<script>
let selectedPhotos = [];

function addPhoto() {
    const input = document.getElementById("photoInput");

    if (input.files.length === 0) {
        alert("Please select a photo");
        return;
    }

    const file = input.files[0];
    selectedPhotos.push(file);

    // show preview list
    const li = document.createElement("li");
    li.innerText = file.name;
    document.getElementById("photoList").appendChild(li);

    // reset input so user can pick next photo
    input.value = "";
}

// before submit, attach all files
document.querySelector("form").addEventListener("submit", function (e) {
    const dataTransfer = new DataTransfer();
    selectedPhotos.forEach(f => dataTransfer.items.add(f));
    document.getElementById("finalPhotos").files = dataTransfer.files;
});
</script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    if (!document.getElementById('mobile-responsive-style')) {
        const style = document.createElement('style');
        style.id = 'mobile-responsive-style';
        style.innerHTML = `
            @media (max-width: 768px) {
                .sidebar, .nav-sidebar {
                    transform: translateX(-100%);
                    transition: transform 0.3s ease;
                    position: fixed !important;
                    z-index: 1001 !important;
                    height: 100vh;
                }
                .sidebar.active, .nav-sidebar.active {
                    transform: translateX(0);
                    box-shadow: 2px 0 20px rgba(0,0,0,0.2) !important;
                }
                .main-content {
                    margin-left: 0 !important;
                    padding: 16px !important;
                    width: 100% !important;
                    max-width: 100% !important;
                }
                .stats-grid, .content-grid, .grid, .hr-stats-grid, .hr-content-grid, .profile-grid, .dashboard-grid {
                    grid-template-columns: 1fr !important;
                    display: grid !important; 
                }
                .top-bar {
                    flex-direction: column !important;
                    align-items: flex-start !important;
                    gap: 16px;
                }
                .chat-header {
                    flex-wrap: wrap;
                    gap: 12px;
                }
                .top-bar h1, .chat-header h3 {
                    font-size: 22px !important;
                    display: flex;
                    align-items: center;
                }
                .mobile-menu-btn {
                    display: inline-block !important;
                    background: none;
                    border: none;
                    font-size: 24px;
                    color: inherit;
                    cursor: pointer;
                    margin-right: 12px;
                }
                .mobile-overlay {
                    display: none;
                    position: fixed;
                    top: 0; left: 0; right: 0; bottom: 0;
                    background: rgba(0,0,0,0.5);
                    z-index: 1000;
                }
                .mobile-overlay.active {
                    display: block;
                }
                .chat-sidebar {
                    position: fixed !important;
                    transform: translateX(-100%);
                    transition: transform 0.3s;
                    z-index: 1000;
                }
                .chat-sidebar.active {
                    transform: translateX(0);
                }
                /* Table responsiveness */
                table:not(.table-responsive), table:not(.table-responsive) thead, table:not(.table-responsive) tbody, table:not(.table-responsive) th, table:not(.table-responsive) td, table:not(.table-responsive) tr { 
                    display: block; 
                }
                table:not(.table-responsive) thead tr { 
                    position: absolute;
                    top: -9999px;
                    left: -9999px;
                }
                table:not(.table-responsive) tr { border: 1px solid #e2e8f0; margin-bottom: 12px; border-radius: 8px; overflow:hidden; }
                table:not(.table-responsive) td { 
                    border: none;
                    border-bottom: 1px solid #f1f5f9; 
                    position: relative;
                    padding-left: 50% !important; 
                    text-align: right;
                    font-size: 14px;
                }
                table:not(.table-responsive) td:last-child {
                    border-bottom: none;
                }
                table:not(.table-responsive) td:before { 
                    position: absolute;
                    top: 50%;
                    transform: translateY(-50%);
                    left: 12px;
                    width: 45%; 
                    padding-right: 10px; 
                    white-space: nowrap;
                    content: attr(data-label);
                    font-weight: 600;
                    text-align: left;
                    color: #64748b;
                }
            }
            .mobile-menu-btn { display: none; }
        `;
        document.head.appendChild(style);
    }
    
    const sidebar = document.querySelector('.sidebar') || document.querySelector('.nav-sidebar');
    if (sidebar) {
        const topBar = document.querySelector('.top-bar') || document.querySelector('.chat-header') || document.querySelector('.dashboard-header') || document.body;
        
        let heading = null;
        if (topBar && topBar !== document.body) {
            heading = topBar.querySelector('h1') || topBar.querySelector('.chat-header-info') || topBar.querySelector('h2');
            if (!heading) heading = topBar;
        } else if (!document.querySelector('.mobile-menu-btn')) {
            // Absolute fallback for simple pages
            heading = document.createElement('div');
            heading.style.padding = '10px';
            document.body.insertBefore(heading, document.body.firstChild);
        }
        
        if (heading && !document.querySelector('.mobile-menu-btn')) {
            heading.style.display = 'flex';
            heading.style.alignItems = 'center';

            const toggleBtn = document.createElement('button');
            toggleBtn.className = 'mobile-menu-btn';
            toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
            heading.insertBefore(toggleBtn, heading.firstChild);
            
            const overlay = document.createElement('div');
            overlay.className = 'mobile-overlay';
            document.body.appendChild(overlay);

            let touchstartX = 0;
            let touchendX = 0;
            document.body.addEventListener('touchstart', e => { touchstartX = e.changedTouches[0].screenX; }, {passive: true});
            document.body.addEventListener('touchend', e => { 
                touchendX = e.changedTouches[0].screenX; 
                if (touchendX < touchstartX - 50) closeSidebar(); 
                if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); 
            }, {passive: true});
            
            function openSidebar() {
                sidebar.classList.add('active');
                overlay.classList.add('active');
                document.body.style.overflow = 'hidden';
            }
            
            function closeSidebar() {
                sidebar.classList.remove('active');
                overlay.classList.remove('active');
                document.body.style.overflow = '';
            }
            
            toggleBtn.addEventListener('click', openSidebar);
            overlay.addEventListener('click', closeSidebar);
        }
    }
    
    // Add data-labels
    const tables = document.querySelectorAll('table:not(.table-responsive)');
    tables.forEach(table => {
        const headers = Array.from(table.querySelectorAll('th')).map(th => th.innerText);
        const rows = Array.from(table.querySelectorAll('tbody tr'));
        rows.forEach(row => {
            Array.from(row.querySelectorAll('td')).forEach((td, index) => {
                if(headers[index]) {
                    td.setAttribute('data-label', headers[index]);
                }
            });
        });
    });
});
</script>
</body>
</html>

