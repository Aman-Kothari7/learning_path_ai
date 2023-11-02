import 'package:flutter/material.dart';
import 'package:learning_path_ai/Models/promt_details.dart';
import 'package:learning_path_ai/Models/user_details.dart';
import 'package:learning_path_ai/dashboard_pages/homepage.dart';
import 'package:learning_path_ai/intro_pages/name_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserDetails user = UserDetails(
      name: "Test Name",
      age: 0,
      profession: "",
      education: "",
      userId: 0,
    );

    PromptDetails promptDetails = PromptDetails(
      promptId: 0,
      userId: 0,
      topicToLearn: "testTopic",
      experienceLevel: "TestExpL",
      hoursPerWeek: 0,
      preferredCourseLength: 0,
      goal: "testGoal",
      learningMode: "testMode",
      learningPreference: "testPref",
      similarExpertise: "",
    );

    return MaterialApp(
      title: 'Learning Path AI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NamePage(
        user: user,
      ),
    );
  }
}
