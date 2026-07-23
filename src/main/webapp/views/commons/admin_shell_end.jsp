<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Shared Admin Shell — end (closes main content + footer + scripts) --%>
  </div><!-- /.admin-main-content -->

  <footer class="admin-footer">
    <p>&copy; 2026 JobU. All rights reserved.</p>
    <div class="admin-footer-links">
      <a href="#">Privacy Policy</a>
      <a href="#">Terms of Service</a>
      <a href="#">Support</a>
    </div>
  </footer>
</div><!-- /.admin-main-wrapper -->

<script>
(function () {
  function toggleAdminSidebar() {
    var sidebar = document.getElementById('adminSidebar');
    var overlay = document.getElementById('adminShellOverlay');
    if (!sidebar) return;
    sidebar.classList.toggle('open');
    if (overlay) overlay.classList.toggle('show');
    document.body.style.overflow = sidebar.classList.contains('open') ? 'hidden' : '';
  }

  function closeAdminSidebar() {
    var sidebar = document.getElementById('adminSidebar');
    var overlay = document.getElementById('adminShellOverlay');
    if (sidebar) sidebar.classList.remove('open');
    if (overlay) overlay.classList.remove('show');
    document.body.style.overflow = '';
  }

  window.toggleAdminSidebar = toggleAdminSidebar;
  window.closeAdminSidebar = closeAdminSidebar;

  window.addEventListener('resize', function () {
    if (window.innerWidth > 992) closeAdminSidebar();
  });

  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') closeAdminSidebar();
  });
})();
</script>
