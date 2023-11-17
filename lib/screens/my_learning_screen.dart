import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:login_page/courseListingScreen.dart';

class MyLearningScreen extends StatefulWidget {
  const MyLearningScreen({Key? key}) : super(key: key);

  @override
  _MyLearningScreenState createState() => _MyLearningScreenState();
}

class _MyLearningScreenState extends State<MyLearningScreen> {
  List<dynamic> enrolledCourses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEnrollCourses();
  }

  Future<void> fetchEnrollCourses() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.4:8000/api/get-enroll-courses'), // Replace with your actual API endpoint
        // Add headers if needed
      );

      print('Enroll Courses Response: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('enrolled_courses')) {
          final List<dynamic>? coursesList = responseData['enrolled_courses'];

          setState(() {
            enrolledCourses = coursesList ?? [];
            isLoading = false;
          });
        } else {
          print('API Error - Unexpected response structure');
        }
      } else {
        print('API Error - Status Code: ${response.statusCode}');
        print('API Error - Response Body: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Learning'),
        backgroundColor: appBarColor,
      ),
      body: Container(
        color: bodyBackgroundColor,
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : enrolledCourses.isNotEmpty
            ? Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: enrolledCourses.length,
                itemBuilder: (context, index) {
                  final course = enrolledCourses[index];
                  return ListTile(
                    title: Text(course['course_name'] ?? 'Not available'),
                    subtitle: Text(course['duration'] ?? 'Not available'),
                    onTap: () {
                      // Navigate to CourseListingScreen with qualificationId
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseListingScreen(
                            qualificationId: course['qualification_id'] ?? 0,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to CourseListingScreen with qualificationId
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseListingScreen(qualificationId: 0),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // Set the background color of the button to black
              ),
              child: Text('Start Learning', style: TextStyle(color: Colors.white)),
            ),
          ],
        )
            : Center(
          child: Text(
            'No enrolled courses available.',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  // Define the color constants
  static const Color appBarColor = Color.fromARGB(255, 10, 10, 10);
  static const Color bodyBackgroundColor = Color.fromARGB(255, 255, 255, 255);
}