package in.sp.main.Config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.util.ContentCachingResponseWrapper;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;

/**
 * Injects JobU theme + responsive CSS into HTML pages project-wide.
 * Does not alter login/auth logic — CSS assets only.
 */
@Component
@Order(Ordered.LOWEST_PRECEDENCE)
public class JobuThemeFilter extends OncePerRequestFilter {

    private static final String MARKER = "jobu-theme.css";

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        String path = request.getRequestURI();
        String ctx = request.getContextPath();
        if (ctx != null && !ctx.isEmpty() && path.startsWith(ctx)) {
            path = path.substring(ctx.length());
        }
        if (path == null) path = "";
        // Skip static assets and APIs
        return path.startsWith("/css/")
                || path.startsWith("/js/")
                || path.startsWith("/images/")
                || path.startsWith("/assets/")
                || path.startsWith("/uploads/")
                || path.startsWith("/static/")
                || path.startsWith("/api/")
                || path.endsWith(".css")
                || path.endsWith(".js")
                || path.endsWith(".png")
                || path.endsWith(".jpg")
                || path.endsWith(".jpeg")
                || path.endsWith(".gif")
                || path.endsWith(".svg")
                || path.endsWith(".ico")
                || path.endsWith(".woff")
                || path.endsWith(".woff2")
                || path.endsWith(".map");
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        ContentCachingResponseWrapper wrapped = new ContentCachingResponseWrapper(response);
        filterChain.doFilter(request, wrapped);

        if (response.isCommitted()) {
            wrapped.copyBodyToResponse();
            return;
        }

        String contentType = wrapped.getContentType();
        byte[] body = wrapped.getContentAsByteArray();

        if (body.length == 0 || contentType == null || !contentType.toLowerCase().contains("text/html")) {
            wrapped.copyBodyToResponse();
            return;
        }

        Charset charset = StandardCharsets.UTF_8;
        try {
            String ct = contentType.toLowerCase();
            if (ct.contains("charset=")) {
                String cs = ct.substring(ct.indexOf("charset=") + 8).trim();
                if (cs.contains(";")) cs = cs.substring(0, cs.indexOf(';')).trim();
                charset = Charset.forName(cs.replace("\"", ""));
            }
        } catch (Exception ignored) {
            charset = StandardCharsets.UTF_8;
        }

        String html = new String(body, charset);
        if (html.contains(MARKER) || !html.toLowerCase().contains("</head>")) {
            wrapped.copyBodyToResponse();
            return;
        }

        String ctx = request.getContextPath() == null ? "" : request.getContextPath();
        String inject = "\n<link rel=\"stylesheet\" href=\"" + ctx + "/css/jobu-theme.css\" id=\"jobu-theme-css\">\n"
                + "<link rel=\"stylesheet\" href=\"" + ctx + "/css/mobile-responsive.css\" id=\"jobu-responsive-css\">\n";

        // case-insensitive </head> replace once
        String lower = html.toLowerCase();
        int idx = lower.lastIndexOf("</head>");
        if (idx < 0) {
            wrapped.copyBodyToResponse();
            return;
        }

        String updated = html.substring(0, idx) + inject + html.substring(idx);
        byte[] out = updated.getBytes(charset);
        response.setContentLength(out.length);
        response.getOutputStream().write(out);
        response.getOutputStream().flush();
    }
}
