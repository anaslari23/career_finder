import 'package:flutter/material.dart';
import 'package:login_page/courseListingScreen.dart'; // Import the CourseListingScreen or replace it with your actual screen file

class MyLearningScreen extends StatefulWidget {
  const MyLearningScreen({Key? key}) : super(key: key);

  @override
  _MyLearningScreenState createState() => _MyLearningScreenState();
}

class _MyLearningScreenState extends State<MyLearningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Learning'),
        backgroundColor: appBarColor,
      ),
      body: Container(
        color: bodyBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'My Learning Content Goes Here',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to CourseListingScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CourseListingScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Set the background color of the button to black
                ),
                child: Text('Start Learning', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Define the color constants
  static const Color appBarColor = Color.fromARGB(255, 10, 10, 10);
  static const Color bodyBackgroundColor = Color.fromARGB(255, 255, 255, 255);
}
