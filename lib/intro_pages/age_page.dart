import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_path_ai/Models/promt_details.dart';
import 'package:learning_path_ai/Models/user_details.dart';
import 'package:learning_path_ai/intro_pages/age_page.dart';
import 'package:learning_path_ai/intro_pages/profession_page.dart';

class AgePage extends StatefulWidget {
  final UserDetails user;
  final PromptDetails promptDetails;

  const AgePage({super.key, required this.user, required this.promptDetails});

  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
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
                ':)',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'This is just the beginning...',
                style: TextStyle(fontSize: 16, color: Colors.grey),
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
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter your age',
                          //labelText: 'Name',
                          border: InputBorder.none, // Remove border
                        ),
                        onSubmitted: (value) {
                          final age = int.tryParse(value);
                          if (age != null) {
                            widget.user.age = age; // Update the user object
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfessionPage(
                              user: widget.user,
                              promptDetails: widget.promptDetails,
                            ), // Pass user to the next page
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
