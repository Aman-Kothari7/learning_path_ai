import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_path_ai/secret_key.dart';

class ChatPage extends StatefulWidget {
  final String initialPrompt;

  ChatPage({Key? key, required this.initialPrompt}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: isLoading
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text("Generating your learning path..."),
                      ],
                    ),
                  )
                : SingleChildScrollView(
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
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  label: Text("Start First Chapter"),
                  icon: Icon(Icons.arrow_right_alt),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
