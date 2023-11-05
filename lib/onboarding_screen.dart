import 'package:flutter/material.dart';
import 'basescreen.dart';
void main() {
  runApp(OnboardingApp());
}

class OnboardingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
    );
  }
}

class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingContent> contents = [
    OnboardingContent(
      image: 'assets/images/onboarding_image1.png',
      title: 'Welcome to MyApp',
      description: 'Discover the amazing features of our app.',
    ),
    OnboardingContent(
      image: 'assets/images/onboarding_image2.png',
      title: 'Easy to Use',
      description: 'Our app is user-friendly and intuitive.',
    ),
    OnboardingContent(
      image: 'assets/images/onboarding_image3.png',
      title: 'Get Started',
      description: 'Start your journey with us today!',
    ),
  ];

  int currentIndex = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: contents.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingPage(
                  content: contents[index],
                );
              },
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (index) => buildDot(index),
            ),
          ),
          SizedBox(height: 20.0),
     ElevatedButton(
  onPressed: () {
    if (currentIndex == contents.length - 1) {
      // Navigate to the HomeScreen when the last slide is reached
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => BaseScreen()),
);

    } else {
      // Move to the next slide
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  },
  child: Text(
    currentIndex == contents.length - 1 ? 'Get Started' : 'Next',
    style: TextStyle(fontSize: 18.0),
  ),
),

        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      height: 8.0,
      width: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingContent content;

  OnboardingPage({required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Image.asset(
            content.image,
            fit: BoxFit.cover, // Add this line
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          content.title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          content.description,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
