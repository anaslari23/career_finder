import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final bool isGenerating;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.isGenerating,
  });
}

class ChatWidget extends StatelessWidget {
  final List<ChatMessage> messages;

  ChatWidget({required this.messages});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Image.asset(
          'assets/images/ic.gif',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Column(
          children: messages.map((message) {
            return Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                message.isGenerating
                    ? "Generating..."
                    : message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
