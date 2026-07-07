import os

base_path = 'c:/Users/NEHA/git/JobPortal/src/main/webapp/views/techperson/'
dashboard = os.path.join(base_path, 'dashboard.jsp')

with open(dashboard, 'r', encoding='utf-8') as f:
    content = f.read()

start_marker = '<div class="dashboard-header">'
end_marker = '            </div>\n        </main>'

start_idx = content.find(start_marker)
end_idx = content.find(end_marker, start_idx)

if start_idx != -1 and end_idx != -1:
    top_part = content[:start_idx]
    bottom_part = '        </main>\n' + content[end_idx + len(end_marker):]

    manage = top_part + '''<div class="dashboard-header">
                <div class="header-content">
                    <h1>Manage Competitions</h1>
                    <p>View, edit, and publish your coding competitions.</p>
                </div>
            </div>
            
            <div class="competitions-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; margin-top: 24px;">
                <c:choose>
                    <c:when test="${not empty competitions}">
                        <c:forEach var="comp" items="${competitions}">
                            <div class="form-card" style="padding: 20px; background: rgba(255,255,255,0.02); border: 1px solid rgba(255,255,255,0.05); border-radius: 8px;">
                                <div style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom: 12px;">
                                    <h3 style="font-size:18px; margin:0; color:var(--text-primary);">${comp.title}</h3>
                                    <span class="badge ${comp.status eq 'PUBLISHED' ? 'bg-success' : 'bg-warning'}" style="padding: 4px 8px; border-radius: 4px; font-size: 11px;">${comp.status}</span>
                                </div>
                                <p style="color:var(--text-secondary); font-size:13px; margin-bottom: 16px;">
                                    Difficulty: <strong>${comp.difficulty}</strong> | Questions: <strong>${comp.numberOfQuestions}</strong>
                                </p>
                                <div style="font-size:13px; color:var(--text-secondary); margin-bottom: 8px;">
                                    <i class="fas fa-calendar-alt"></i> ${comp.examStartTime}
                                </div>
                                <div style="font-size:13px; color:var(--text-secondary); margin-bottom: 20px;">
                                    <i class="fas fa-users"></i> Max: ${comp.maxParticipants}
                                </div>
                                <div style="display:flex; gap: 10px;">
                                    <button class="btn-primary" style="background: var(--gradient-primary); color: white; border: none; padding: 6px 12px; border-radius: 6px; font-size: 13px; flex: 1; cursor: pointer;">Edit</button>
                                    <button class="btn-secondary" style="background: transparent; color: #ef4444; border: 1px solid #ef4444; padding: 6px 12px; border-radius: 6px; font-size: 13px; flex: 1; cursor: pointer;">Delete</button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info" style="grid-column: 1 / -1; background: rgba(59, 130, 246, 0.1); color: #3b82f6; padding: 20px; border-radius: 8px; border: 1px solid rgba(59, 130, 246, 0.2);">
                            <i class="fas fa-info-circle"></i> You haven't created any competitions yet. <a href="conduct-competition" style="color: #2563eb; font-weight: 600;">Create one now</a>.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
''' + bottom_part

    with open(os.path.join(base_path, 'manage-competitions.jsp'), 'w', encoding='utf-8') as f:
        f.write(manage)
        
    results = top_part + '''<div class="dashboard-header">
                <div class="header-content">
                    <h1>Competition Results</h1>
                    <p>View leaderboards and detailed results of past competitions.</p>
                </div>
            </div>
            
            <div class="form-card" style="margin-top: 24px; background: rgba(255,255,255,0.02); border: 1px solid rgba(255,255,255,0.05); padding: 20px; border-radius: 8px;">
                <div class="form-group" style="margin-bottom: 20px;">
                    <label class="form-label" style="display:block; margin-bottom:8px; font-weight:500; color:var(--text-primary);">Select Competition</label>
                    <select class="form-select" style="width:100%; padding: 12px; background: rgba(0,0,0,0.1); border: 1px solid rgba(255,255,255,0.1); border-radius: 8px; color: var(--text-primary);">
                        <option value="">-- Choose a competition --</option>
                        <c:forEach var="comp" items="${competitions}">
                            <option value="${comp.id}">${comp.title} (${comp.examStartTime})</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div style="text-align:center; padding: 40px; color: var(--text-secondary);">
                    <i class="fas fa-trophy" style="font-size: 48px; color: #cbd5e1; margin-bottom: 16px; display:block;"></i>
                    <p>Select a competition above to view its leaderboard and statistics.</p>
                </div>
            </div>
''' + bottom_part

    with open(os.path.join(base_path, 'competition-results.jsp'), 'w', encoding='utf-8') as f:
        f.write(results)
    
    print('JSP files generated successfully')
else:
    print('Markers not found')
