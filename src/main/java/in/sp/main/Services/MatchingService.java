package in.sp.main.Services;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import in.sp.main.Entities.Job;
import in.sp.main.Entities.JobSeeker;

@Service
public class MatchingService {

    public int calculateMatch(Job job, JobSeeker seeker) {
        if (job == null || seeker == null) {
            return 0;
        }

        int score = 0;

        /* ===== SKILLS (50%) ===== */
        List<String> jobSkills = new java.util.ArrayList<>();
        if (job.getSkillRequirement() != null && !job.getSkillRequirement().trim().isEmpty()) {
            jobSkills = Arrays.stream(job.getSkillRequirement().split(","))
                    .map(String::trim)
                    .collect(Collectors.toList());
        }

        List<String> seekerSkills = seeker.getSkills();

        if (!jobSkills.isEmpty() && seekerSkills != null && !seekerSkills.isEmpty()) {

            long matched = jobSkills.stream()
                    .filter(js -> seekerSkills.stream()
                            .anyMatch(ss -> ss.equalsIgnoreCase(js)))
                    .count();

            score += (int) ((matched * 50.0) / jobSkills.size());
        }

        // ===== EXPERIENCE (30%) =====
        int seekerExp = seeker.getExperience() != null ? seeker.getExperience() : 0;
        int jobExpRequired = job.getExperienceRequired();
        if (seekerExp >= jobExpRequired) {
            score += 30;
        } else if (jobExpRequired > 0) {
            double ratio = (double) seekerExp / jobExpRequired;
            score += (int) (ratio * 30);
        }

        // ===== LOCATION (20%) =====
        if (job.getLocation() != null && seeker.getLocation() != null && job.getLocation().contains(seeker.getLocation().name())) {
            score += 20;
        }

        return Math.min(score, 100);
    }
}
