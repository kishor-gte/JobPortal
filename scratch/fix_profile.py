import sys
import os

file_path = r'c:\Users\NEHA\OneDrive\Desktop\jp\JobPortal\src\main\webapp\views\techperson\profile.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Make Profile link active and Dashboard inactive
content = content.replace(
    '<a href="${pageContext.request.contextPath}/tech/dashboard" class="nav-link active">',
    '<a href="${pageContext.request.contextPath}/tech/dashboard" class="nav-link">'
)
content = content.replace(
    '<a href="${pageContext.request.contextPath}/tech/profile" class="nav-link">',
    '<a href="${pageContext.request.contextPath}/tech/profile" class="nav-link active">'
)

# Replace Title
content = content.replace(
    '<h1><i class="fas fa-shield-halved"></i> Tech Person Dashboard</h1>',
    '<h1><i class="fas fa-user"></i> Profile</h1>'
)

# Extract the area to replace (from Stats Row 1 to the end of main-content)
start_str = '<!-- Stats Row 1 -->'
end_str = '    <script>'
start_idx = content.find(start_str)
end_idx = content.find(end_str, start_idx)

if start_idx != -1 and end_idx != -1:
    # New Form Content
    profile_content = '''
        <div class="profile-card" style="background: rgba(255, 255, 255, 0.95); border: 1px solid var(--border-color); border-radius: var(--radius-lg); padding: 30px; backdrop-filter: blur(20px); max-width: 800px; margin: 0 auto;">
            <div class="profile-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; border-bottom: 1px solid rgba(0,0,0,0.1); padding-bottom: 20px;">
                <div class="profile-title" style="font-size: 20px; font-weight: 700; color: #1e293b; display: flex; align-items: center; gap: 12px;">
                    <i class="fas fa-user-circle" style="color: var(--primary); font-size: 32px;"></i>
                    Tech Person Profile
                </div>
                <button type="button" class="btn-edit" id="editBtn" onclick="enableEdit()" style="background: var(--primary); color: white; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 8px;">
                    <i class="fas fa-edit"></i> Edit Profile
                </button>
            </div>

            <c:if test="${not empty message}">
                <div style="background: rgba(16, 185, 129, 0.1); color: #10b981; padding: 12px; border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(16, 185, 129, 0.3);">
                    ${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div style="background: rgba(239, 68, 68, 0.1); color: #ef4444; padding: 12px; border-radius: 8px; margin-bottom: 20px; border: 1px solid rgba(239, 68, 68, 0.3);">
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/tech/profile/update" method="POST" id="profileForm">
                <div style="margin-bottom: 20px;">
                    <label style="display: block; margin-bottom: 8px; font-weight: 500; color: #64748b;">Full Name</label>
                    <input type="text" name="name" value="${techPerson.name}" disabled required style="width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;">
                </div>
                <div style="margin-bottom: 20px;">
                    <label style="display: block; margin-bottom: 8px; font-weight: 500; color: #64748b;">Email Address</label>
                    <input type="email" name="email" value="${techPerson.email}" disabled required style="width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;">
                </div>
                <div style="margin-bottom: 20px;">
                    <label style="display: block; margin-bottom: 8px; font-weight: 500; color: #64748b;">New Password (leave blank to keep current)</label>
                    <input type="password" name="password" placeholder="Enter new password" disabled style="width: 100%; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0; background: #f8fafc; color: #1e293b;">
                </div>
                
                <div style="text-align: right; margin-top: 30px;">
                    <button type="button" id="cancelBtn" onclick="cancelEdit()" style="display: none; background: transparent; color: #64748b; border: 1px solid #cbd5e1; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer; margin-right: 12px;">
                        Cancel
                    </button>
                    <button type="submit" id="saveBtn" style="display: none; background: var(--primary); color: white; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer;">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>

'''
    
    js_content = '''    <script>
        function enableEdit() {
            const inputs = document.querySelectorAll('#profileForm input');
            inputs.forEach(input => {
                input.disabled = false;
                input.style.background = '#ffffff';
                input.style.border = '1px solid var(--primary)';
            });
            document.getElementById('editBtn').style.display = 'none';
            document.getElementById('saveBtn').style.display = 'inline-block';
            document.getElementById('cancelBtn').style.display = 'inline-block';
        }

        function cancelEdit() {
            const inputs = document.querySelectorAll('#profileForm input');
            inputs.forEach(input => {
                input.disabled = true;
                input.style.background = '#f8fafc';
                input.style.border = '1px solid #e2e8f0';
            });
            document.getElementById('editBtn').style.display = 'inline-flex';
            document.getElementById('saveBtn').style.display = 'none';
            document.getElementById('cancelBtn').style.display = 'none';
            document.getElementById('profileForm').reset();
        }
    </script>
    <script>'''
    
    content = content[:start_idx] + profile_content + js_content + content[end_idx + 12:]

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print('Success')
