package in.sp.main.Config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import in.sp.main.Interceptors.PremiumFeatureInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Serve uploaded files from external directory safely cross-platform
        java.nio.file.Path uploadPath = java.nio.file.Paths.get(System.getProperty("user.home"), "jobportal-uploads");
        String uploadDirUri = uploadPath.toUri().toString();
        
        // Handle all uploads under /uploads/** (new structure: /logo/, /document/, /video/, etc.)
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations(uploadDirUri)
                .setCachePeriod(3600);
    }

    @Autowired
    private PremiumFeatureInterceptor premiumFeatureInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // Define paths that require a premium subscription
        registry.addInterceptor(premiumFeatureInterceptor)
                .addPathPatterns(
                    "/jobseeker/videos",
                    "/jobseeker/premium/**"
                );
    }
}
