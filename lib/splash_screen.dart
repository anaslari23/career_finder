import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_page/registration_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double fontSize = 34.0;
  Color textColor = Colors.black38;
  FontWeight fontWeight = FontWeight.w400;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RegistrationScreen(),
        ),
      );
    });
    _startTextAnimation();
  }

  void _startTextAnimation() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        fontSize = 48.0;
        textColor = Colors.black;
        fontWeight = FontWeight.bold;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/splash.jpg'), // Your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 20.0, // Adjust the bottom position as needed
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.easeInOutCubicEmphasized,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                padding: EdgeInsets.all(10.0),
                child: AnimatedDefaultTextStyle(
                  duration: Duration(seconds: 1),
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: Colors.black45,
                  ),
                  child: Text('Career Finder'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
