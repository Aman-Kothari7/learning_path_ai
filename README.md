# learning_path_ai

A new Flutter project.

User details: 
1) Name
2) Age
3) Profession
4) Education

Learning path questions
1) What do you want to learn? Hint text could be "Ex. Python, Java..."
2) What is your experience level with this topic? This will be a Dropdown with options: First Timer, Novice,  Intermediate, Advanced, Professional 
3) How many hours per week can you set aside to learn this topic? this will be a numerical Numerical dropdown from 1 to 20. 
4) What is your prefered course length? This will be Dropdown: Number of weeks with range 1 to 16. 
5) What is your goal? Why are you learning this topic? This will be a dropdown: freelance, interview prep, hobby, other
6) What is your preferred learning mode?This will be a Drop down: Texual. Visual, Audio
7) What is your learning preference? This will be a dropdown: Practical, theoretical 
8) Do you have expertise in any similar field? Hint text could be "Topic: Python, Similar: Java"

- Text box with more information about what subtopics to learn - parts of subpotics 


"Given the following user information:\n"
                    "Profession: ${userDetails.profession}\n"
                    "Education Qualification: ${userDetails.education}\n"
                    "Learning Objective: ${courseDetails.topicToLearn}\n"
                    "Experience Level: ${courseDetails.experienceLevel}\n"
                    "Time Commitment: ${courseDetails.hoursPerWeek} hours per week\n"
                    "Preferred Course Length: ${courseDetails.preferredCourseLength} weeks\n"
                    "Learning Goal: ${courseDetails.goal}\n"
                    "Learning Mode: ${courseDetails.learningMode}\n"
                    "Learning Preference: ${courseDetails.learningPreference}\n"
                    "Expertise in Similar Fields: ${courseDetails.similarExpertise}\n\n"
                    "Please generate an index for a personalized course outline tailored to the user's needs and preferences. The course should be structured in chapters, and each chapter should have a brief description. I will request each chapter's content separately.";


"You are my teacher. Give me a small introduction on this topic:${courseDetails.topicToLearn} considering my experience level with this topic: ${courseDetails.experienceLevel}\n"
                    "Skip the introductory phrases.";