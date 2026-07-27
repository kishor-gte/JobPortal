<%@ page contentType="text/html;charset=UTF-8" %>
<style>
/* Sidebar — match Admin Dashboard (dark #2E3E41 + green accents) */
.sidebar, .nav-sidebar {
    background: linear-gradient(180deg, #2E3E41 0%, #1f2e30 100%) !important;
    border-right: 1px solid rgba(25, 167, 123, 0.12) !important;
    box-shadow: 4px 0 24px rgba(0, 0, 0, 0.12) !important;
}

.sidebar::-webkit-scrollbar-thumb,
.nav-sidebar::-webkit-scrollbar-thumb {
    background: #19A77B !important;
}

.sidebar-logo {
    border-bottom: 1px solid rgba(255, 255, 255, 0.08) !important;
    background: transparent !important;
}

.sidebar-logo .icon {
    background: linear-gradient(135deg, #19A77B, #3BC49A) !important;
    box-shadow: 0 4px 12px rgba(25, 167, 123, 0.25) !important;
}

.sidebar-logo .icon i {
    color: #ffffff !important;
}

.sidebar-logo h2 {
    color: white !important;
    -webkit-text-fill-color: white !important;
    background: none !important;
}

.nav-section h4 {
    color: rgba(255, 255, 255, 0.35) !important;
}

.nav-link {
    color: rgba(255, 255, 255, 0.7) !important;
    border-left: 3px solid transparent !important;
    transition: all 0.3s ease !important;
    border-radius: 10px !important;
}

.nav-link i {
    color: inherit !important;
}

.nav-link:hover {
    background: rgba(25, 167, 123, 0.15) !important;
    color: #3BC49A !important;
    border-left-color: transparent !important;
    transform: translateX(3px) !important;
}

.nav-link.active {
    background: linear-gradient(135deg, rgba(25,167,123,0.25), rgba(59,196,154,0.12)) !important;
    color: #3BC49A !important;
    border-left-color: #19A77B !important;
    box-shadow: none !important;
}

.nav-link::before {
    display: none !important;
}

.btn-logout {
    display: none !important;
}
</style>
