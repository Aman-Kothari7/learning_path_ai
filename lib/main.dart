import 'package:flutter/material.dart';
import 'package:learning_path_ai/Models/promt_details.dart';
import 'package:learning_path_ai/Models/user_details.dart';
import 'package:learning_path_ai/dashboard_pages/homepage.dart';
import 'package:learning_path_ai/intro_pages/learning_qs.dart/learning_pref_q7.dart';
import 'package:learning_path_ai/intro_pages/name_page.dart';
import 'package:learning_path_ai/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserDetails user = UserDetails(
      name: "Aman",
      age: 21,
      profession: "Student",
      education: "Computer Engineering",
      userId: 0,
    );

    PromptDetails promptDetails = PromptDetails(
      promptId: 0,
      userId: 0,
      topicToLearn: "Python",
      experienceLevel: "Novice",
      hoursPerWeek: 4,
      preferredCourseLength: 6,
      goal: "Interview preparation",
      learningMode: "Textual",
      learningPreference: "Theoretical",
      similarExpertise: "Java",
    );

    return MaterialApp(
      title: 'Learning Path AI',
      debugShowCheckedModeBanner: false,
      theme: customTheme,
      home: NamePage(
        user: user,
        //promptDetails: promptDetails,
      ),
    );
  }
}
