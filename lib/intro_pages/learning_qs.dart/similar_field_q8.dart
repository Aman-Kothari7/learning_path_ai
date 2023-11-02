import 'package:flutter/material.dart';
import 'package:learning_path_ai/Models/promt_details.dart';
import 'package:learning_path_ai/Models/user_details.dart';
import 'package:learning_path_ai/dashboard_pages/homepage.dart';
import 'package:learning_path_ai/intro_pages/age_page.dart';
import 'package:learning_path_ai/intro_pages/learning_qs.dart/course_length_q4.dart';
import 'package:learning_path_ai/intro_pages/learning_qs.dart/exp_level_q2.dart';
import 'package:learning_path_ai/intro_pages/learning_qs.dart/learning_mode_q6.dart';
import 'package:learning_path_ai/prompt_creation_pages/learning_form.dart';
import 'package:learning_path_ai/summary.dart';

class similarFieldQuestionEight extends StatefulWidget {
  final UserDetails user;
  final PromptDetails promptDetails;

  const similarFieldQuestionEight({
    super.key,
    required this.user,
    required this.promptDetails,
  });

  @override
  _similarFieldQuestionEightState createState() =>
      _similarFieldQuestionEightState();
}

class _similarFieldQuestionEightState extends State<similarFieldQuestionEight> {
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
                '8/8',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Do you have expertise in any simlar field?',
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
                          hintText: 'Ex. Enter topic name',
                          //labelText: 'Name',
                          border: InputBorder.none, // Remove border
                        ),
                        keyboardType: TextInputType.number,
                        onSubmitted: (value) {
                          widget.promptDetails.similarExpertise = value;
                          // Save the value and navigate to the AgePage
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => homePageDashboard(
                              user: widget.user,
                              promptDetails: widget.promptDetails,
                            ),
                          ));
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
