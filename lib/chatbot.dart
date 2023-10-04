import 'package:flutter/material.dart';

class ChatbotWidget extends StatefulWidget {
  @override
  _ChatbotWidgetState createState() => _ChatbotWidgetState();
}

class _ChatbotWidgetState extends State<ChatbotWidget> {
  TextEditingController _controller = TextEditingController();
  List<String> chatMessages = [];

  void _handleSubmitted(String message) {
    // Here, you can implement your chatbot logic to respond to user messages.
    // For simplicity, we'll just echo the user's message back.
    setState(() {
      chatMessages.add("You: $message");
      chatMessages.add("Chatbot: $message"); // Echo back the message.
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: chatMessages.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(chatMessages[index]),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _controller,
                  onSubmitted: _handleSubmitted,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _handleSubmitted(_controller.text);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
