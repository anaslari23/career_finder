import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: FeedbackScreen(),
    ),
  );
}

class FeedbackScreen extends StatelessWidget {
  final TextEditingController feedbackController = TextEditingController();

  void submitFeedback() {
    // You can implement the logic to save or send the feedback here
    String feedback = feedbackController.text;
    print('Feedback submitted: $feedback');
    // You can also send the feedback to a server or database if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Provide Feedback',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter your feedback here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                submitFeedback();
                // You can also navigate back to the previous screen or perform other actions here
                Navigator.pop(context);
              },
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
