import 'package:flutter/material.dart';
import 'package:learning_path_ai/Models/promt_details.dart';
import 'package:learning_path_ai/Models/user_details.dart';
import 'package:learning_path_ai/intro_pages/age_page.dart';
import 'package:learning_path_ai/intro_pages/learning_qs.dart/hours_per_week_q3.dart';
import 'package:learning_path_ai/intro_pages/learning_qs.dart/learning_pref_q7.dart';
import 'package:learning_path_ai/prompt_creation_pages/learning_form.dart';

class learningModeQuestionSix extends StatefulWidget {
  final UserDetails user;
  final PromptDetails promptDetails;

  const learningModeQuestionSix(
      {super.key, required this.user, required this.promptDetails});

  @override
  _learningModeQuestionSixState createState() =>
      _learningModeQuestionSixState();
}

class _learningModeQuestionSixState extends State<learningModeQuestionSix> {
  final TextEditingController nameController = TextEditingController();
  final List<String> learningModes = [
    'Recommended',
    'Textual',
    'Visual',
    'Audio',
    'Video',
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
                '6/7',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'What is your preferred learning mode? ',
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
                        hint: Text('Ex. Textual, Visual...'),
                        onChanged: (value) {
                          setState(() {
                            selectedExperienceLevel = value;
                            widget.promptDetails.learningMode =
                                value!; // Update the promptDetails object
                          });

                          // Automatically navigate to the next page
                          Future.delayed(Duration.zero, () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => learningPrefQuestionSeven(
                                  promptDetails: widget.promptDetails,
                                  user: widget.user,
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
