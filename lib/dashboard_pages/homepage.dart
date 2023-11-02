import 'package:flutter/material.dart';
import 'package:learning_path_ai/Models/promt_details.dart';
import 'package:learning_path_ai/Models/user_details.dart';
import 'package:learning_path_ai/dashboard_pages/start_course.dart';

class homePageDashboard extends StatelessWidget {
  final UserDetails user;
  final PromptDetails promptDetails;

  const homePageDashboard({
    super.key,
    required this.user,
    required this.promptDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'All Courses',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  user.name,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  CourseItem(
                    courseDetails: promptDetails,
                    userDetails: user,
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   colors: [Colors.grey, Colors.white],
                      // ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey,
                      //     offset: Offset(0, 2),
                      //     blurRadius: 6,
                      //   ),
                      // ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Generate New Course',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Icon(
                          Icons.add,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseItem extends StatelessWidget {
  final PromptDetails courseDetails;
  final UserDetails userDetails;

  const CourseItem(
      {super.key, required this.courseDetails, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [Colors.grey, Colors.white],
        // ),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Topic: ${courseDetails.topicToLearn}'),
              Text('Learning Mode: ${courseDetails.learningMode}'),
              Text('Duration: ${courseDetails.preferredCourseLength} weeks'),
              Text('Learning Preference: ${courseDetails.learningPreference}'),
              Text('Goal: ${courseDetails.goal}'),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                String customizedPrompt =
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

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatPage(initialPrompt: customizedPrompt),
                  ),
                );
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.grey,
              ),
              child: Text('Start Course', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
