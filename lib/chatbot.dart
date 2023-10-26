import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: Chatbot(),
    ));

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final List<Message> _messages = [];
  final TextEditingController _textEditingController = TextEditingController();

  void onSendMessage() async {
    String userMessage = _textEditingController.text;
    _textEditingController.clear();

    setState(() {
      _messages.add(Message(text: userMessage, isUser: true));
    });

    // Show a "generating" message
    setState(() {
      _messages.add(Message(text: "Generating...", isUser: false));
    });

    String response = await sendMessageToChatGpt(userMessage);

    // Remove the "generating" message and show the actual response
    _messages.removeWhere((message) => message.text == "Generating...");
    setState(() {
      _messages.add(Message(text: response, isUser: false));
    });
  }

  Future<String> sendMessageToChatGpt(String message) async {
    Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");

    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": message}
      ],
      "max_tokens": 500,
    };

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer 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",
      },
      body: json.encode(body),
    );

    Map<String, dynamic> parsedResponse = json.decode(response.body);
    String reply = parsedResponse['choices'][0]['message']['content'];

    return reply;
  }

  Widget _buildMessage(Message message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment:
              message.isUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.grey[300] : Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message.text,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/ic.gif',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildMessage(_messages[index]);
                  },
                ),
              ),
              Divider(height: 1.0),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: onSendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}
