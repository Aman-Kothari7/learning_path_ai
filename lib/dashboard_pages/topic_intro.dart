import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_path_ai/Models/promt_details.dart';
import 'package:learning_path_ai/Models/user_details.dart';
import 'package:learning_path_ai/dashboard_pages/homepage.dart';
import 'package:learning_path_ai/secret_key.dart';

class topicIntroPage extends StatefulWidget {
  final UserDetails user;
  final PromptDetails promptDetails;
  final String initialPrompt;

  topicIntroPage(
      {Key? key,
      required this.initialPrompt,
      required this.user,
      required this.promptDetails})
      : super(key: key);

  @override
  _topicIntroPageState createState() => _topicIntroPageState();
}

class _topicIntroPageState extends State<topicIntroPage> {
  String chatResponse = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchChatResponse(widget.initialPrompt);
  }

  final List<Map<String, String>> messages = [];
  static const String OpenAiKey = apiKey;

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
          chatResponse = content;
          isLoading = false;
        });
        print("API Response:$content");

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isLoading,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Loading your introduction"),
                ],
              ),
            ),
            if (!isLoading)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        chatResponse,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (!isLoading)
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => homePageDashboard(
                            promptDetails: widget.promptDetails,
                            user: widget.user,
                          ),
                        ),
                      );
                    },
                    label: Text(
                      "My dashboard",
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(
                      Icons.arrow_right_alt,
                      color: Colors.black,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 6,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
