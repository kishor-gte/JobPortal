package in.sp.main.Repositories;

import in.sp.main.Entities.TechPerson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TechPersonRepository extends JpaRepository<TechPerson, Long> {
    List<TechPerson> findByCompanyId(Long companyId);
    TechPerson findByEmail(String email);
}
