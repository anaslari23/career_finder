import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_page/registration_screen.dart';
import 'package:login_page/widgets/gradient_button.dart';
import 'package:login_page/widgets/login_field.dart';
import 'package:login_page/widgets/social_button.dart';
import 'package:http/http.dart' as http; // Added import for HTTP package

void main() 
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAREERAPP',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, // Change to your background color
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  // Add the loginUser function here
  Future<void> loginUser(String email, String password) async {
    final url = Uri.parse('http://localhost:8000/api/login'); // Replace with your API endpoint

    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Successful login, handle the response here
      // You can parse the JSON response using the `json.decode` method if the API returns JSON data.
      // Example: final responseData = json.decode(response.body);
      // You can perform actions like navigating to a new screen if login is successful.
    } else {
      // Handle error cases here
      print('Failed to login: ${response.statusCode}');
      // You can display an error message to the user, e.g., using a SnackBar or AlertDialog.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/log.jpg', // Change to your image path
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'CAREER FINDER',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                SocialButton(
                  onPressed: () async {
                    // Perform Google sign-in
                    final GoogleSignIn googleSignIn = GoogleSignIn();
                    try {
                      final GoogleSignInAccount? googleUser =
                          await googleSignIn.signIn();

                      if (googleUser != null) {
                        // Successfully signed in, handle further logic
                      } else {
                        // User canceled the sign-in process
                      }
                    } catch (error) {
                      // Handle errors
                    }
                  },
                  label: ' Continue with Google  ',
                  iconPath: 'assets/svg/google.svg', // Change to your SVG icon path
                  horizontalPadding: 20,
                ),
                const SizedBox(height: 10),
                const Text(
                  'or',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 15),
                const LoginField(hintText: 'Email'),
                const SizedBox(height: 15),
                const LoginField(hintText: 'Password'),
                const SizedBox(height: 20),
                const GradientButton(),
                const SizedBox(height: 20), // Add spacing between the login button and "Sign Up"
                ElevatedButton(
                  onPressed: () {
                    // Call loginUser function when the login button is pressed
                    loginUser('user@example.com', 'password'); // Replace with actual user input
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    // Handle the "Sign Up" action here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FacebookSignInScreen extends StatelessWidget {
  const FacebookSignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook Sign-In'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Facebook Sign-In Screen',
              style: TextStyle(fontSize: 20),
            ),
            // Add your Facebook sign-in UI components here
          ],
        ),
      ),
    );
  }
}
