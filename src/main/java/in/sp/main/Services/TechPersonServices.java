package in.sp.main.Services;

import in.sp.main.Entities.TechPerson;
import in.sp.main.Repositories.TechPersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.mindrot.jbcrypt.BCrypt;
import java.util.List;

@Service
public class TechPersonServices {
    @Autowired
    private TechPersonRepository techPersonRepository;

    public TechPerson createTechPerson(TechPerson techPerson) {
        techPerson.setPassword(BCrypt.hashpw(techPerson.getPassword(), BCrypt.gensalt()));
        return techPersonRepository.save(techPerson);
    }

    public List<TechPerson> getTechPersonsByCompany(Long companyId) {
        return techPersonRepository.findByCompanyId(companyId);
    }

    public TechPerson findTechPersonById(Long id) {
        return techPersonRepository.findById(id).orElse(null);
    }

    public void deleteTechPerson(Long id) {
        techPersonRepository.deleteById(id);
    }

    public TechPerson updateTechPerson(TechPerson techPerson) {
        return techPersonRepository.save(techPerson);
    }

    public TechPerson authenticateTechPerson(String email, String password) {
        TechPerson techPerson = techPersonRepository.findByEmail(email);
        if (techPerson != null && BCrypt.checkpw(password, techPerson.getPassword())) {
            return techPerson;
        }
        return null;
    }
}
