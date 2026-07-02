package in.sp.main.Services;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.Job;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.Subscriber;
import in.sp.main.Repositories.JobSeekerRepository;
import in.sp.main.Repositories.SubscriberRepository;

@Service
public class SubscriberServices {

	 @Autowired
	    private SubscriberRepository subscriberRepository;
	 @Autowired
	    private JobSeekerRepository  jobSeekerRepository;

	    @Autowired
	    private EmailService emailService;
	    
	    public List<JobSeeker> getMatchingSubscribedJobSeekers(Job job) {
	        List<String> subscribedEmails = subscriberRepository.findAll().stream()
	            .map(Subscriber::getEmail)
	            .collect(Collectors.toList());

	        return jobSeekerRepository.findAll().stream()
	            .filter(js -> subscribedEmails.contains(js.getEmail()))
	            .filter(js -> {
	                // ✅ Split the string properly!
	                List<String> requiredSkills = Arrays.stream(job.getSkillRequirement().split(","))
	                                                    .map(String::trim)
	                                                    .map(String::toLowerCase)
	                                                    .collect(Collectors.toList());

	                List<String> seekerSkills = js.getSkills().stream()
	                                              .map(String::trim)
	                                              .map(String::toLowerCase)
	                                              .collect(Collectors.toList());

	                boolean match = !Collections.disjoint(seekerSkills, requiredSkills);

	                System.out.println("Checking " + js.getEmail() +
	                                   " | Skills: " + seekerSkills +
	                                   " | Required: " + requiredSkills +
	                                   " | Match: " + match);

	                return match;
	            })
	            .collect(Collectors.toList());
	    }




	    public void notifyMatchingSubscribers(Job job) {
	        List<JobSeeker> matched = getMatchingSubscribedJobSeekers(job);
	        System.out.println("Matched subscribers: " + matched.size());

	        for (JobSeeker js : matched) {
	            System.out.println("Sending email to: " + js.getEmail());  // 👈 Add this
	            String subject = "New Job Opportunity Just for You!";
	            String content = "Hi " + js.getName() + ",\n\nThe job '" + job.getTitle()
	                           + "' matches your skills. Check it out and apply now!";
	            emailService.sendEmail(js.getEmail(), subject, content);
	        }
	    }


	
}
