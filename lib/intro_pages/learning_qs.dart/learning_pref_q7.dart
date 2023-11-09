import 'package:flutter/material.dart';
import 'package:learning_path_ai/Models/promt_details.dart';
import 'package:learning_path_ai/Models/user_details.dart';
import 'package:learning_path_ai/dashboard_pages/start_course.dart';
import 'package:learning_path_ai/intro_pages/age_page.dart';
import 'package:learning_path_ai/intro_pages/learning_qs.dart/hours_per_week_q3.dart';
import 'package:learning_path_ai/intro_pages/learning_qs.dart/similar_field_q8.dart';
import 'package:learning_path_ai/prompt_creation_pages/learning_form.dart';

class learningPrefQuestionSeven extends StatefulWidget {
  final UserDetails user;
  final PromptDetails promptDetails;

  const learningPrefQuestionSeven(
      {super.key, required this.user, required this.promptDetails});

  @override
  _learningPrefQuestionSevenState createState() =>
      _learningPrefQuestionSevenState();
}

class _learningPrefQuestionSevenState extends State<learningPrefQuestionSeven> {
  final TextEditingController nameController = TextEditingController();
  final List<String> learningModes = [
    'Recommended',
    'Theoretical',
    'Practical',
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      FocusScope.of(context)
          .requestFocus(nameFocusNode); // Request focus after the build
    });
  }

  final FocusNode nameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    String? selectedExperienceLevel;

    final maxWidth = 400.0;
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal:
                screenWidth > maxWidth ? (screenWidth - maxWidth) / 2 : 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '7/7',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'What is your learning preference? ',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.event, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedExperienceLevel,
                        items: learningModes.map((level) {
                          return DropdownMenuItem<String>(
                            value: level,
                            child: Text(level),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        hint: Text('Ex. Theoretical, Practical...'),
                        onChanged: (value) {
                          setState(() {
                            selectedExperienceLevel = value;
                            widget.promptDetails.learningPreference =
                                value!; // Update the promptDetails object
                          });
                          String customizedPrompt =
                              "Given the following user information:\n"
                              "Occupation: ${widget.user.profession}\n"
                              "Education Qualification: ${widget.user.education}\n"
                              "Learning Objective: ${widget.promptDetails.topicToLearn}\n"
                              "Experience Level: ${widget.promptDetails.experienceLevel}\n"
                              "Time Commitment: ${widget.promptDetails.hoursPerWeek} hours per week\n"
                              "Preferred Course Length: ${widget.promptDetails.preferredCourseLength} weeks\n"
                              "Learning Goal: ${widget.promptDetails.goal}\n"
                              "Learning Mode: ${widget.promptDetails.learningMode}\n"
                              "Learning Preference: ${widget.promptDetails.learningPreference}\n"
                              "Expertise in Similar Fields: ${widget.promptDetails.similarExpertise}\n\n"
                              "Please generate an index for a personalized course outline tailored to the user's needs and preferences. The course should be structured in chapters, and each chapter should have a brief description. I will request each chapter's content separately.\n\n"
                              "Here is the format I want you to follow for the index:\n"
                              "[I] Chapter 1 (Week 1): Short description\n"
                              "    [a] Subtopic 1: Short description\n"
                              "    [b] Subtopic 2: Short description\n"
                              "...\n"
                              "[II] Chapter 2 (Week 2): Short description\n"
                              "    [a] Subtopic 1: Short description\n"
                              "    [b] Subtopic 2: Short description\n"
                              "... and so on\n"
                              "Skip the introductory phrases.";

                          // Automatically navigate to the next page
                          Future.delayed(Duration.zero, () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  initialPrompt: customizedPrompt,
                                ),
                              ),
                            );
                          });
                        },
                      ),

                      // TextField(
                      //   controller: nameController,
                      //   focusNode: nameFocusNode,
                      //   decoration: InputDecoration(
                      //     hintText: 'Ex. Python, Java...',
                      //     //labelText: 'Name',
                      //     border: InputBorder.none, // Remove border
                      //   ),
                      //   onSubmitted: (value) {
                      //     widget.promptDetails.experienceLevel = value;
                      //     // Save the value and navigate to the AgePage
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => LearningForm(
                      //         user: widget.user,
                      //       ),
                      //     ));
                      //   },
                      // ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }
}
