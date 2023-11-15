import 'package:flutter/material.dart';
import 'package:login_page/login_screen.dart';
import 'package:login_page/registration_screen.dart';
import 'package:animate_do/animate_do.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/settings.gif'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FadeInUp(
            duration: Duration(milliseconds: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'General Settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                ListTile(
                  title: Text(
                    'Notifications',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // Handle the switch toggle here
                    },
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {
                      // Handle the switch toggle here
                    },
                  ),
                ),
                Divider(),
                Text(
                  'Account Settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationScreen()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Sign Out',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
