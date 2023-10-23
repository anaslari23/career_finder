import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'General Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Notifications'),
              trailing: Switch(
                value: true, // Replace with your logic to handle notifications
                onChanged: (value) {
                  // Handle the switch toggle here
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: false, // Replace with your logic to handle dark mode
                onChanged: (value) {
                  // Handle the switch toggle here
                },
              ),
            ),
            Divider(),
            Text(
              'Account Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Change Password'),
              onTap: () {
                // Navigate to the change password screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
              },
            ),
            Divider(),
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                // Handle sign out logic here
                // After signing out, navigate to the featured screen
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      // Your change password screen content goes here
    );
  }
}

