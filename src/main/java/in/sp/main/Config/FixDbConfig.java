package in.sp.main.Config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import jakarta.annotation.PostConstruct;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.Statement;

@Configuration
public class FixDbConfig {

    @Autowired
    private DataSource dataSource;

    @PostConstruct
    public void fixDb() {
        try (Connection conn = dataSource.getConnection();
             Statement stmt = conn.createStatement()) {
            
            try {
                stmt.execute("ALTER TABLE job_application MODIFY status VARCHAR(50)");
                System.out.println("FIX: altered status column to VARCHAR(50)");
            } catch (Exception e) {
                System.out.println("FIX: status alter failed: " + e.getMessage());
            }

            try {
                stmt.execute("ALTER TABLE job_application MODIFY applied_date DATETIME");
                System.out.println("FIX: altered applied_date column to DATETIME");
            } catch (Exception e) {
                System.out.println("FIX: applied_date alter failed: " + e.getMessage());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
