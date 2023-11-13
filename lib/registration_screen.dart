import'package:flutter/material.dart';
import'package:http/http.dart' as http;
import'package:login_page/login_screen.dart';
import'package:login_page/onboarding_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: RegistrationScreen(),
    ),
  );
}

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String selectedCourse = 'B.Tech';
  String selectedBranch = 'Computer Science';

  final List<String> courses = ['B.Tech', 'M.Tech', 'Diploma in Engg', 'BCA'];

  final Map<String, List<String>> branches = {
    'B.Tech': [
      'Computer Science',
      'Electronics',
      // Add more branches here
    ],
    'M.Tech': [
      'Mechanical Engineering',
      'Electrical Engineering',
      // Add more branches here
    ],
    'Diploma in Engg': [
      'Mechanical Engineering',
      'Electrical Engineering',
      // Add more branches here
    ],
    'BCA': [
      'Computer Engineering',
      // Add more branches here
    ],
  };

  String name = '';
  String email = '';
  String password = '';
  String mobile = '';
  String passwordError = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.gif'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // Registration Form
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey, // Set the form key
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Name Input
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Email Input
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Password Input
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  Text(
                    passwordError,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Mobile Number Input
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        mobile = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Mobile Number (Optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Course Selection
                  Text(
                    'Course',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedCourse,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCourse = newValue!;
                        selectedBranch = branches[selectedCourse]![0];
                      });
                    },
                    items: courses.map((String course) {
                      return DropdownMenuItem<String>(
                        value: course,
                        child: Text(course),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),

                  // Branch Selection
                  Text(
                    'Branch',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedBranch,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedBranch = newValue!;
                      });
                    },
                    items: branches[selectedCourse]!.map((String branch) {
                      return DropdownMenuItem<String>(
                        value: branch,
                        child: Text(branch),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Password validation
                        if (password.length < 6) {
                          setState(() {
                            passwordError = 'Password must be at least 6 characters';
                          });
                        } else {
                          passwordError = '';

                          try {
                            // Create a JSON payload with user registration data
                            final registrationData = {
                              "name": name,
                              "email": email,
                              "phone": mobile,
                              "password": password,
                              "qualification": selectedCourse,
                              "stream": selectedBranch,
                            };

                            // Make a POST request to the API
                            final apiUrl = 'http://192.168.29.71:8000/api/register';
                            final response = await http.post(
                              Uri.parse(apiUrl),
                              body: registrationData,
                            );

                            if (response.statusCode == 200) {
                              // Registration was successful, proceed to onboarding screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            } else {
                              // Handle registration error, e.g., display an error message
                              print('Registration error: ${response.body}');
                            }
                          } catch (e) {
                            // Handle exceptions here, e.g., connection issues
                            print('Exception: $e');
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                    ),
                    child: Text('Register'),
                  ),

                  // Option to navigate to login screen
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}