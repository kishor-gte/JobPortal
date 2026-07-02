package in.sp.main.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.AssessmentQuestion;
import in.sp.main.Repositories.AssessmentQuestionRepository;

@Service
public class AssessmentService {

    @Autowired
    private AssessmentQuestionRepository repository;

    public void saveAll(List<AssessmentQuestion> questions) {
        repository.saveAll(questions);
    }

    public void deleteBySkill(String skill) {
        repository.deleteBySkill(skill);
    }

    public List<AssessmentQuestion> getBySkill(String skill) {
        return repository.findBySkill(skill);
    }
}
