import 'package:flutter/material.dart';
import 'package:learning_path_ai/Models/promt_details.dart';
import 'package:learning_path_ai/Models/user_details.dart';
import 'package:learning_path_ai/intro_pages/age_page.dart';
import 'package:learning_path_ai/intro_pages/learning_qs.dart/exp_level_q2.dart';
import 'package:learning_path_ai/prompt_creation_pages/learning_form.dart';

class topicQuestionOne extends StatefulWidget {
  final UserDetails user;

  const topicQuestionOne({
    super.key,
    required this.user,
  });

  @override
  _topicQuestionOneState createState() => _topicQuestionOneState();
}

class _topicQuestionOneState extends State<topicQuestionOne> {
  final PromptDetails promptDetails = PromptDetails(
      topicToLearn: "",
      experienceLevel: "",
      hoursPerWeek: 0,
      preferredCourseLength: 0,
      goal: "",
      learningMode: "",
      learningPreference: "",
      similarExpertise: "",
      promptId: 0,
      userId: 0);

  final TextEditingController nameController = TextEditingController();

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
                '>',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'What do you want to learn? Enter topic name.',
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
                      child: TextField(
                        controller: nameController,
                        focusNode: nameFocusNode,
                        decoration: InputDecoration(
                          hintText: 'Ex. Python, Java...',
                          //labelText: 'Name',
                          border: InputBorder.none, // Remove border
                        ),
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            promptDetails.topicToLearn = value;
                            // Save the value and navigate to the next page
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => expLevelQuestionTwo(
                                  user: widget.user,
                                  promptDetails: promptDetails,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter a topic name.'),
                              ),
                            );
                          }
                        },
                      ),
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
