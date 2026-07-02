package in.sp.main.Services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.Answer;
import in.sp.main.Entities.Comment;
import in.sp.main.Entities.Question;
import in.sp.main.Exceptions.ResourceNotFoundException;
import in.sp.main.Repositories.AnswerRepository;
import in.sp.main.Repositories.CommentRepository;
import in.sp.main.Repositories.QuestionRepository;
import in.sp.main.dto.AnswerSubmissionDTO;
import in.sp.main.dto.CommentSubmissionDTO;
import in.sp.main.dto.QuestionSubmissionDTO;
import jakarta.transaction.Transactional;

@Service
public class QnAService {

    @Autowired
    private QuestionRepository questionRepo;

    @Autowired
    private AnswerRepository answerRepo;

    @Autowired
    private CommentRepository commentRepo;

    @Autowired
    private XssSanitizationService xssSanitizationService;

    // Create a new question
    public void createQuestion(QuestionSubmissionDTO dto, String displayName) {
        Question q = new Question();
        q.setContent(xssSanitizationService.sanitize(dto.getContent()));
        q.setDisplayName(xssSanitizationService.sanitize(displayName));
        q.setPostedAt(LocalDateTime.now());
        questionRepo.save(q);
    }

    // Admin posts an answer
    @Transactional
    public void answerQuestion(AnswerSubmissionDTO dto) {
        Question question = questionRepo.findById(dto.getQuestionId())
                .orElseThrow(() -> new ResourceNotFoundException("Question not found with id: " + xssSanitizationService.sanitize(dto.getQuestionId().toString())));

        Answer existing = answerRepo.findByQuestion_Id(dto.getQuestionId());

        if (existing != null) {
            // Update the existing answer
            existing.setContent(xssSanitizationService.sanitize(dto.getContent()));
            existing.setAnsweredAt(LocalDateTime.now());
            answerRepo.save(existing);
        } else {
            // Create a new answer
            Answer newAnswer = new Answer();
            newAnswer.setContent(xssSanitizationService.sanitize(dto.getContent()));
            newAnswer.setAnsweredAt(LocalDateTime.now());
            newAnswer.setQuestion(question);

            answerRepo.save(newAnswer);
        }
    }

    // Add a comment to thread (question, answer, or comment)
    public void addCommentToThread(Long questionId, CommentSubmissionDTO dto, String displayName) {
        Comment c = new Comment();
        c.setQuestion(questionRepo.findById(questionId)
                .orElseThrow(() -> new ResourceNotFoundException("Question not found with id: " + questionId)));
        c.setContent(xssSanitizationService.sanitize(dto.getContent()));
        c.setParentId(dto.getParentId());
        c.setParentType(xssSanitizationService.sanitize(dto.getParentType()));
        c.setDisplayName(xssSanitizationService.sanitize(displayName));
        c.setCommentedAt(LocalDateTime.now());
        commentRepo.save(c);
    }

    // List all questions (most recent first)
    public List<Question> getAllThreads() {
        return questionRepo.findAll(Sort.by(Sort.Direction.DESC, "postedAt"));
    }

    // View full thread by question ID
    public Question getFullThread(Long id) {
        return questionRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Question not found with id: " + id));
    }
    public void saveQuestion(Question question) {
        questionRepo.save(question);
    }
    public void deleteQuestionById(Long questionId) {
        questionRepo.deleteById(questionId);
    }

}
