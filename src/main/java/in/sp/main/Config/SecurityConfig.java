package in.sp.main.Config;

import in.sp.main.Configuration.JwtAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private JwtAuthenticationFilter jwtAuthenticationFilter;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable()) // Disable CSRF since we are using JWT in cookies (though ideally we should keep it for cookies, but for this migration we disable to prevent form submission issues)
            .authorizeHttpRequests(authz -> authz
                // Static resources and public pages
                .requestMatchers("/", "/home.html", "/userdashboard.html", "/index.html", "/about-us.html", "/contact.html", "/services.html", "/policy.html", "/faq.html", "/legal-info.html").permitAll()
                .requestMatchers("/css/**", "/js/**", "/images/**", "/views/**", "/static/**").permitAll()
                
                // Login, Register, Forgot Password
                .requestMatchers("/loginAdmin", "/admin/login", "/PostloginAdmin", "/admin/adminRegister", "/admin/registerAdmin").permitAll()
                .requestMatchers("/company/login", "/company/login1", "/company/company_register", "/company/register", "/company/verify-otp").permitAll()
                .requestMatchers("/jobSeekers/login", "/jobSeekers/login1", "/jobSeekers/job_seeker_register", "/jobSeekers/register", "/jobSeekers/register1", "/jobSeekers/signup", "/jobSeekers/authenticate", "/jobSeekers/verify-otp").permitAll()
                .requestMatchers("/recruiter/login", "/recruiter/login1", "/recruiter/register","tech/add-category", "/recruiter/verify-otp").permitAll()
                .requestMatchers("/tech/login", "/tech/login1").permitAll()
                .requestMatchers("/forgot-password", "/reset-password", "/api/password/**").permitAll()
                
                // Secure Tech Person Routes
                .requestMatchers("/tech/**").hasRole("TECHPERSON")
                
                // Let existing controller logic handle authorization for any other request
                .anyRequest().permitAll()
            )
            .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
            .logout(logout -> logout
                .logoutUrl("/logout") // Let controllers handle logout explicitly if they want, but Spring Security can also handle it
                .deleteCookies("JWT_SESSION")
                .logoutSuccessUrl("/home.html")
            );

        return http.build();
    }
}
