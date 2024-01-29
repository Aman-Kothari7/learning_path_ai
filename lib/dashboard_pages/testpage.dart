import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_path_ai/secret_key.dart';

class TestPage extends StatefulWidget {
  final String testPrompt;

  TestPage({required this.testPrompt});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String testResponse = "";
  bool isLoading = true;
  static const String OpenAiKey = apiKey;

  @override
  void initState() {
    super.initState();
    _fetchTestResponse(widget.testPrompt);
  }

  Future<void> _fetchTestResponse(String prompt) async {
    try {
      // Fetch the response for the test prompt
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $OpenAiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              'role': 'user',
              'content': prompt,
            },
          ],
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        setState(() {
          testResponse = content;
          isLoading = false;
        });
        print('Test Response: $content');
      } else {
        setState(() {
          isLoading = false;
        });
        print('An internal error occurred');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Practice MCQs',
          style: TextStyle(color: Colors.black),
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
                                    'MCQ Questionnaire',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                                SizedBox(height: 16),
                                SelectableText(
                                  testResponse,
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
    );
  }
}
