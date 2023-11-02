// import 'package:flutter/material.dart';
// import 'package:learning_path_ai/Models/promt_details.dart';
// import 'package:learning_path_ai/Models/user_details.dart';
// import 'package:learning_path_ai/summary.dart';

// class LearningForm extends StatefulWidget {
//   final UserDetails user;

//   const LearningForm(
//       {Key? key, required this.user, required PromptDetails promptDetails})
//       : super(key: key);

//   @override
//   _LearningFormState createState() => _LearningFormState();
// }

// class _LearningFormState extends State<LearningForm> {
//   final _formKey = GlobalKey<FormState>();
//   final PromptDetails promptDetails = PromptDetails(
//       topicToLearn: "",
//       experienceLevel: "",
//       hoursPerWeek: 0,
//       preferredCourseLength: 0,
//       goal: "",
//       learningMode: "",
//       learningPreference: "",
//       similarExpertise: "");

//   final List<String> experienceLevels = [
//     'First Timer',
//     'Novice',
//     'Intermediate',
//     'Advanced',
//     'Professional',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final maxWidth = 400.0;
//     return Scaffold(
//       body: Form(
//         key: _formKey,
//         child: Container(
//           margin: EdgeInsets.symmetric(
//             horizontal:
//                 screenWidth > maxWidth ? (screenWidth - maxWidth) / 2 : 16.0,
//           ),
//           child: ListView(
//             children: [
//               Text(
//                 'Just a few more details to generate your customized learning path...',
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 40),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextFormField(
//                   autofocus: true,
//                   decoration: InputDecoration(
//                     labelText:
//                         'What do you want to learn? (e.g. Python, Java...)',
//                     border: InputBorder.none,
//                   ),
//                   onSaved: (value) {
//                     promptDetails.topicToLearn = value!;
//                   },
//                 ),
//               ),
//               SizedBox(height: 30),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: DropdownButtonFormField(
//                   borderRadius: BorderRadius.zero,
//                   value: null,
//                   items: experienceLevels.map((level) {
//                     return DropdownMenuItem(
//                       value: level,
//                       child: Text(level),
//                     );
//                   }).toList(),
//                   hint: Text('Select your experience level'),
//                   onChanged: (value) {
//                     setState(() {
//                       promptDetails.experienceLevel = value!;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 30),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     labelText:
//                         'How many hours per week can you set aside to learn this topic?',
//                   ),
//                   keyboardType: TextInputType.number,
//                   onSaved: (value) {
//                     promptDetails.hoursPerWeek = int.tryParse(value!)!;
//                   },
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: DropdownButtonFormField(
//                   value: null,
//                   items: List.generate(16, (index) {
//                     return DropdownMenuItem(
//                       value: index + 1,
//                       child: Text((index + 1).toString()),
//                     );
//                   }).toList(),
//                   hint: Text('Select your preferred course length (in weeks)'),
//                   onChanged: (value) {
//                     setState(() {
//                       promptDetails.preferredCourseLength = value!;
//                     });
//                   },
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     labelText:
//                         'What is your goal? Why are you learning this topic?',
//                     hintText: "Interview Prep/Freelancing/Hobby...",
//                   ),
//                   onSaved: (value) {
//                     promptDetails.goal = value!;
//                   },
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: DropdownButtonFormField(
//                   value: null,
//                   items: ['Textual', 'Visual', 'Audio'].map((mode) {
//                     return DropdownMenuItem(
//                       value: mode,
//                       child: Text(mode),
//                     );
//                   }).toList(),
//                   hint: Text('Select your preferred learning mode'),
//                   onChanged: (value) {
//                     setState(() {
//                       promptDetails.learningMode = value!;
//                     });
//                   },
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: DropdownButtonFormField(
//                   value: null,
//                   items: ['Practical', 'Theoretical'].map((preference) {
//                     return DropdownMenuItem(
//                       value: preference,
//                       child: Text(preference),
//                     );
//                   }).toList(),
//                   hint: Text('Select your learning preference'),
//                   onChanged: (value) {
//                     setState(() {
//                       promptDetails.learningPreference = value!;
//                     });
//                   },
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     labelText:
//                         'Do you have expertise in any similar field? (e.g., Python; Similar: Java)',
//                   ),
//                   onSaved: (value) {
//                     promptDetails.similarExpertise = value!;
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     // At this point, promptDetails contains the user's responses.
//                     // You can use or save this data as needed.
//                     // For example, you could pass it to the next page.

//                     // Replace NextPage with the actual next page in your app.

//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => SummaryPage(
//                           promptDetails: promptDetails,
//                           user: widget.user,
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
