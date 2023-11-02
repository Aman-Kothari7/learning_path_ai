import 'package:flutter/material.dart';
import 'package:learning_path_ai/Models/promt_details.dart';
import 'package:learning_path_ai/Models/user_details.dart';

class SummaryPage extends StatelessWidget {
  final UserDetails user;
  final PromptDetails promptDetails;

  SummaryPage({super.key, required this.user, required this.promptDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('User Details:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Name: ${user.name}'),
          Text('Age: ${user.age}'),
          Text('Profession: ${user.profession}'),
          Text('Education: ${user.education}'),
          Divider(),
          Text('Prompt Details:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Topic to Learn: ${promptDetails.topicToLearn}'),
          Text('Experience Level: ${promptDetails.experienceLevel}'),
          Text('Hours Per Week: ${promptDetails.hoursPerWeek}'),
          Text(
              'Preferred Course Length: ${promptDetails.preferredCourseLength} weeks'),
          Text('Goal: ${promptDetails.goal}'),
          Text('Learning Mode: ${promptDetails.learningMode}'),
          Text('Learning Preference: ${promptDetails.learningPreference}'),
          Text('Similar Expertise: ${promptDetails.similarExpertise}'),
        ],
      ),
    );
  }
}
