package in.sp.main.Entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;

@Entity
public class Post {
    @Id @GeneratedValue private Long id;

    @ManyToOne
    private QuestionThread questionThread;

    @ManyToOne
    private Post parentPost;

    private String content;
    private String displayName;
    private boolean anonymous;
    private boolean adminAnswer;
    private Long postedByUserId;
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "parentPost", cascade = CascadeType.ALL)
    private List<Post> replies = new ArrayList<>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public QuestionThread getQuestionThread() {
		return questionThread;
	}

	public void setQuestionThread(QuestionThread questionThread) {
		this.questionThread = questionThread;
	}

	public Post getParentPost() {
		return parentPost;
	}

	public void setParentPost(Post parentPost) {
		this.parentPost = parentPost;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public boolean isAnonymous() {
		return anonymous;
	}

	public void setAnonymous(boolean anonymous) {
		this.anonymous = anonymous;
	}

	public boolean isAdminAnswer() {
		return adminAnswer;
	}

	public void setAdminAnswer(boolean adminAnswer) {
		this.adminAnswer = adminAnswer;
	}

	public Long getPostedByUserId() {
		return postedByUserId;
	}

	public void setPostedByUserId(Long postedByUserId) {
		this.postedByUserId = postedByUserId;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public List<Post> getReplies() {
		return replies;
	}

	public void setReplies(List<Post> replies) {
		this.replies = replies;
	}

    // Getters and setters
    
}
