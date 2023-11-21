import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui' as ui;


class CourseListingScreen extends StatefulWidget {
  final int qualificationId;

  CourseListingScreen({required this.qualificationId});

  @override
  _CourseListingScreenState createState() => _CourseListingScreenState();
}

class _CourseListingScreenState extends State<CourseListingScreen> {
  Map<String, dynamic> qualificationDetails = {};
  List<dynamic> courses = [];
  bool isLoading = true;
  bool showQualificationDetails = false;

  @override
  void initState() {
    super.initState();
    fetchQualificationDetails();
    fetchAllCourses();
  }

  Future<void> fetchQualificationDetails() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.4:8000/api/get-qualification?id=2'),
        // Add headers if needed
      );

      print('Qualification Details Response: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('status') &&
              responseData['status'] == false) {
            print('API Error: ${responseData['message']}');
          } else {
            setState(() {
              qualificationDetails = responseData['data'];
            });
          }
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

  Future<void> fetchAllCourses() async {
    try {
      int id = 14;
//int id =15 // electronics
//int id =16 //computer
//int id =17 // Mechanical
//int id=18//Civil;
      final response = await http.get(
        Uri.parse('http://192.168.1.4:8000/api/get-allcourses?$id=14'),
        // Add headers if needed
      );

      print('All Courses Response: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('category_name')) {
          final List<dynamic>? coursesList = responseData.values
              .whereType<Map<String, dynamic>>() // Include only map values
              .where((course) =>
          course['course_name'] !=
              null) // Exclude entries without 'course_name'
              .toList();

          setState(() {
            courses = coursesList ?? [];
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
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Course Listing',
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 252, 252),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                setState(() {
                  showQualificationDetails = !showQualificationDetails;
                });
              },
            ),
          ],
        ),
        backgroundColor: appBarColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/imag.png'), // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.black.withOpacity(0.3),
            child: isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showQualificationDetails)
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 213, 213, 214),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Qualification Name:',
                          style: infoTextStyle,
                        ),
                        Text(
                          '${qualificationDetails['name'] ?? 'Not available'}',
                          style: boldTextStyle,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Category Name:',
                          style: infoTextStyle,
                        ),
                        Text(
                          '${qualificationDetails['category_name'] ?? 'Not available'}',
                          style: boldTextStyle,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Duration:',
                          style: infoTextStyle,
                        ),
                        Text(
                          '${qualificationDetails['duration'] ?? 'Not available'}',
                          style: boldTextStyle,
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 16.0),
                /*     Text(
                        'Courses:',
                        style: headingTextStyle,

                      ),
                   */
                for (var course in courses)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 224, 221, 221)),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color.fromARGB(197, 179, 179, 196),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${course['course_name'] ?? 'Not available'}',
                          style: boldTextStyle,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Duration: ${course['duration'] ?? 'Not available'}',
                          style: regularTextStyle,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Description: ${course['desc'] ?? 'Not available'}',
                          style: descriptionTextStyle,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Define the color constants
const Color appBarColor = Color.fromARGB(255, 0, 0, 0);

// Define the text styles
const TextStyle boldTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(146, 3, 0, 3),
);

const TextStyle infoTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 26, 25, 25),
);

const TextStyle regularTextStyle = TextStyle(
  fontSize: 16.0,
  color: Color.fromARGB(255, 233, 235, 234),
);

const TextStyle descriptionTextStyle = TextStyle(
  fontSize: 16.0,
  color: Color.fromARGB(255, 225, 231, 231),
  fontWeight: FontWeight.bold,
);

const TextStyle headingTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 14, 13, 13),
);