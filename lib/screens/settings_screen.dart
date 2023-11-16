import 'package:flutter/material.dart';
import 'package:login_page/login_screen.dart';
import 'package:login_page/registration_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor1,
      ),
      body: Container(
        color: appBarColor2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSectionTitle('General Settings'),
              _buildSwitchTile('Notifications', true),
              Divider(),
              _buildSwitchTile('Dark Mode', false),
              Divider(),
              _buildSectionTitle('Account Settings'),
              Divider(),
              _buildListTile('Register', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              }),
              Divider(),
              _buildListTile('Sign Out', () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 27, 27, 27)),
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: (value) {
          // Handle the switch toggle here
        },
      ),
    );
  }

  Widget _buildListTile(String title, VoidCallback onTap) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 29, 28, 28)),
        ),
      ),
      onTap: onTap,
    );
  }
}

// Define the color constants
const Color appBarColor1 = Color.fromARGB(255, 10, 10, 10);
const Color appBarColor2 = Color.fromARGB(255, 255, 255, 255);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsScreen(),
    );
  }
}
