import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_path_ai/Models/promt_details.dart';
import 'package:learning_path_ai/Models/user_details.dart';
import 'package:learning_path_ai/dashboard_pages/testpage.dart';
import 'package:learning_path_ai/secret_key.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';

class ChatPage extends StatefulWidget {
  final String initialPrompt;
  final PromptDetails promptDetails;
  final UserDetails userDetails;

  ChatPage(
      {Key? key,
      required this.initialPrompt,
      required this.promptDetails,
      required this.userDetails})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String chatResponse = "";
  bool isLoading = true;
  String selectedSubtopic = "";
  String learningPathResponse = "";
  Map<String, List<String>> highlightsMap = {};

  @override
  void initState() {
    super.initState();
    _fetchChatResponse(widget.initialPrompt);
  }

  final List<Map<String, String>> messages = [];
  static const String OpenAiKey = apiKey;

  Future<void> _showRegenerateOptionsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Regenerate Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Handle 'Use simpler language' option
                  _regenerateChatResponse('in much simpler language');
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Reduce language difficulty',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle 'Include more examples' option
                  _regenerateChatResponse('with many examples');
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Include more examples',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle 'Include more theory' option
                  _regenerateChatResponse('with more theory based explanation');
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Include more theory',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _regenerateChatResponse(String selectedOption) async {
    setState(() {
      isLoading = true;
    });

    // Add the selected option to the current chat response
    String promptWithOption =
        'Explain this $selectedSubtopic  $selectedOption'; //under ${widget.promptDetails.topicToLearn} add this?

    print("Updated Prompt: $promptWithOption");

    // Send the new prompt to generate a response
    await _fetchChatResponse(promptWithOption);
  }

  void _startTest() {
    if (chatResponse.isNotEmpty) {
      // Create a test prompt that includes the current chat response
      String testPrompt =
          'Create multiple choice questions for this subtopic:$selectedSubtopic under this topic:${widget.promptDetails.topicToLearn} for someone who has only this level of experiecen: ${widget.promptDetails.experienceLevel} and give the right answer below each multiple choice question with a small disccription.';

      print("Test prompt: $testPrompt");

      // Navigate to the TestPage with the test prompt
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TestPage(testPrompt: testPrompt),
        ),
      );
    } else {
      // Handle the case where there's no chat response to include
      // You can show an error message or take appropriate action here.
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $OpenAiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });

        setState(() {
          if (selectedSubtopic.isEmpty) {
            // Learning path response
            learningPathResponse = content;
            isLoading = false;
          } else {
            // Personalized lesson response
            chatResponse = content;
            isLoading = false;
          }
        });
        print('API Response: $content');
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      return e.toString();
    }
  }

  Future<void> _fetchChatResponse(String prompt) async {
    try {
      await chatGPTAPI(prompt);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _fetchPersonalizedLesson(
      String subtopic, String chapterName) async {
    // Use the selected subtopic to create the personalized lesson prompt
    String personalizedLessonPrompt = "You are my teacher\n"
        "Given the following user information:\n"
        "Learning Topic: ${widget.promptDetails.topicToLearn}\n"
        "Experience Level: ${widget.promptDetails.experienceLevel}\n"
        "Learning Goal: ${widget.promptDetails.goal}\n"
        "Learning Mode: ${widget.promptDetails.learningMode}\n"
        "Learning Preference: ${widget.promptDetails.learningPreference}\n"
        "Expertise in Similar Fields: ${widget.promptDetails.similarExpertise}\n\n"
        "Give me a personalized document for the subtopic: $subtopic from the $chapterName\n\n"
        "Begin the lesson with the exact same title as the chapter name and subtopic and skip the introductory phrases and do not mention any next steps.\n"
        "I am '${widget.userDetails.profession}', with '${widget.userDetails.education}' qualification whose goal is to learn '${widget.promptDetails.topicToLearn}' for '${widget.promptDetails.goal}'. Give me a detailed explanation of this subtopic in a lengthy format to become an expert on this topic for my goal. This lesson should contain at least 500 words. ";

    // Fetch the response for the personalized lesson
    await _fetchChatResponse(personalizedLessonPrompt);
  }

  @override
  Widget build(BuildContext context) {
    var chaptersMap = _parseChaptersAndSubtopics(learningPathResponse);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.home),
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
          children: [
            Text(
              'Topics',
              style: TextStyle(color: Colors.black),
            ),
            Spacer(),
            Text('Your learning path',
                style: TextStyle(color: Colors.black)), // Your existing title
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

        backgroundColor: Colors.white, // Customize the background color
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      margin: EdgeInsets.all(50),
                      elevation: 6,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    selectedSubtopic.isNotEmpty
                                        ? 'Personalized Lesson for $selectedSubtopic'
                                        : 'Click on a subtopic to start learning!',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                                SizedBox(height: 16),
                                SelectableText(
                                  chatResponse,
                                  //contextMenuBuilder: ,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.thumb_up),
                                  onPressed: () {
                                    // Handle thumbs up feedback
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.thumb_down),
                                  onPressed: () {
                                    // Handle thumbs down feedback
                                  },
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
            ),
      drawer: Drawer(
        child: ListView(
          children: chaptersMap.entries.map((entry) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ExpansionTile(
                tilePadding: EdgeInsets.all(10),
                title: Text(
                  entry.key,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                children: entry.value.map((subtopic) {
                  return Card(
                    elevation: 4, // Add shadow
                    margin: EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8), // Adjust margins
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      title: Text(
                        subtopic,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      onTap: () {
                        // Handle subtopic tap from the drawer
                        Navigator.pop(context); // Close the drawer
                        setState(() {
                          selectedSubtopic = subtopic;
                          isLoading = true;
                        });
                        _fetchPersonalizedLesson(subtopic, entry.key);
                      },
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: SpeedDial(
        iconTheme: IconThemeData(
          color: Colors.black, // Change the icon color to black
        ),
        icon: Icons.more_vert,
        backgroundColor: Colors.white,
        activeIcon: Icons.close,
        buttonSize: Size(56.0, 56.0),
        visible: true,
        closeManually: false,
        renderOverlay: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.white,
        overlayOpacity: 0.5,
        onOpen: () => print('Opening...'),
        onClose: () => print('Closing...'),
        children: [
          SpeedDialChild(
            child: Icon(Icons.replay),
            backgroundColor: Colors.white,
            label: 'Regenerate SubTopic Content',
            onTap: () {
              _showRegenerateOptionsDialog();
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.help),
            backgroundColor: Colors.white,
            label: 'Ask a doubt',
            onTap: () {
              // Handle "Ask a doubt" action
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.star),
            backgroundColor: Colors.white,
            label: 'Change difficulty level',
            onTap: () {
              // Handle "Change difficulty level" action
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.assignment),
            backgroundColor: Colors.white,
            label: 'Take a test',
            onTap: () {
              _startTest();
            },
          ),
        ],
      ),
    );
  }

  Map<String, List<String>> _parseChaptersAndSubtopics(String text) {
    Map<String, List<String>> chaptersMap = {};
    String currentChapter = '';
    var lines = text.split('\n');
    RegExp chapterPattern = RegExp(r'\[\w+\]\s*Chapter');
    RegExp subtopicPattern = RegExp(r'\[\w\]');
    for (var line in lines) {
      if (chapterPattern.hasMatch(line)) {
        int titleStartIndex = line.indexOf(':') + 2;
        currentChapter = line.substring(titleStartIndex).trim();
        chaptersMap[currentChapter] = [];
      } else if (subtopicPattern.hasMatch(line)) {
        int titleStartIndex = line.indexOf(']') + 2;
        var subtopic = line.substring(titleStartIndex).trim();

        // Split the line using the colon and take the first part
        if (subtopic.contains(':')) {
          subtopic = subtopic.split(':')[0].trim();
        }

        chaptersMap[currentChapter]?.add(subtopic);
      }
    }
    print('Chapters Map: $chaptersMap');
    return chaptersMap;
  }
}
