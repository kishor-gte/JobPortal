package in.sp.main.Configuration;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import jakarta.servlet.http.HttpSession;

public class JwtRequestWrapper extends HttpServletRequestWrapper {

    private final JwtSession jwtSession;

    public JwtRequestWrapper(HttpServletRequest request, JwtSession jwtSession) {
        super(request);
        this.jwtSession = jwtSession;
    }

    @Override
    public HttpSession getSession() {
        return this.jwtSession;
    }

    @Override
    public HttpSession getSession(boolean create) {
        return this.jwtSession;
    }
}
