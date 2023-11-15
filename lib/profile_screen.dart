import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:login_page/TrendingCoursesScreen.dart';

class TokenStorage {
  static const String _tokenKey = 'auth_token';

  static Future<void> saveToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_tokenKey, accessToken);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}

void main() {
  runApp(
    MaterialApp(
      home: ProfileScreen(),
    ),
  );
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> profileData = {};
  String selectedAvatar = 'assets/images/default_avatar.jpg'; // Default avatar

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      String? accessToken = await TokenStorage.getToken();

      if (accessToken != null) {
        final response = await http.get(
          Uri.parse('http://192.168.29.71:8000/api/profile'),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        );

        print('API Response Code: ${response.statusCode}');
        print('API Response Body: ${response.body}');

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          setState(() {
            profileData = responseData;
          });
        } else {
          print('API Error: ${response.body}');
        }
      } else {
        print('No access token found.');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  void _chooseAvatar() {
    // Implement functionality to choose avatars here
    // This can involve showing a dialog, using an image picker library, etc.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/profiles_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AvatarGlow(
                endRadius: 90,
                glowColor: Colors.blue,
                duration: Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: Duration(milliseconds: 100),
                child: GestureDetector(
                  onTap: _chooseAvatar,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(selectedAvatar),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                child: Text(
                  'Welcome, ${profileData["name"] ?? "User"}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Displaying selected parameters
              ...[
                'Email',
                'Phone',
                'Stream',
                'Qualification', // Added Qualification
              ].map(
                (key) => FadeInUp(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$key: ${profileData[key.toLowerCase()] ?? "Not available"}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Displaying courses
              FadeInUp(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Enrolled Courses: ${profileData["courses"] ?? "No courses enrolled"}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ZoomIn(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrendingCourseSearchPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text(
                    'Start Learning',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
