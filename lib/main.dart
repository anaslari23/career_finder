import 'package:flutter/material.dart';
import 'package:login_page/login_screen.dart';
import 'package:login_page/splash_screen.dart';
//11import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CARRER FINDER',
      theme: ThemeData.dark(),
      home: SplashScreen( ),
    );
  }
}

class BackgroundImageLoginScreen extends StatelessWidget {
  const BackgroundImageLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/log.jpg',
            fit: BoxFit.cover,
          ),
          const LoginScreen(),
        ],
      ),
    );
  }
}
