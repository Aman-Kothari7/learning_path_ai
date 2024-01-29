import 'package:flutter/material.dart';
import 'package:learning_path_ai/Models/promt_details.dart';
import 'package:learning_path_ai/Models/user_details.dart';
import 'package:learning_path_ai/dashboard_pages/start_course.dart';
import 'package:learning_path_ai/intro_pages/education_page.dart';

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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.person_2_sharp),
            color: Colors.black,
            onPressed: () {
              // Navigate to the homepage dashboard when the home icon is pressed
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //   builder: (context) => DashboardPage(),
              // ));
            },
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'All Courses',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Spacer(),
            Text(
              user.name,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.black, // Change the icon color to black
        ),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey, // Specify the border color
            width: 1.0, // Specify the border width
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  CourseItem(
                    courseDetails: promptDetails,
                    userDetails: user,
                    promptDetails: promptDetails,
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
  final PromptDetails promptDetails;

  const CourseItem({
    Key? key,
    required this.courseDetails,
    required this.userDetails,
    required this.promptDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6, // Add elevation for a modern look
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Customize border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Topic',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(width: 8), // Add spacing between title and value
                Text(
                  courseDetails.topicToLearn,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Experience Level',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(width: 8),
                Text(
                  courseDetails.experienceLevel,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Similar field',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(width: 8),
                Text(
                  courseDetails.similarExpertise,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EducationPage(
                      user: userDetails,
                      promptDetails: promptDetails,
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Customize border radius
                ),
              ),
              child: Text('Start Now',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
