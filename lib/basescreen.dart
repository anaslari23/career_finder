
import 'package:login_page/featuerd_screen.dart';
import 'package:flutter/material.dart';

import 'package:login_page/screens/my_learning_screen.dart';
import 'package:login_page/screens/wishlist_screen.dart';
import 'package:login_page/screens/settings_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    FeaturedScreen(),
    MyLearningScreen(),
    WishlistScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue, // Change this color
        unselectedItemColor: Colors.grey, // Add this line to set unselected color
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list),
            label: "Featured",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: "My Learning",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
       BottomNavigationBarItem(
  icon: Icon(Icons.settings),
  label: 'Settings', // Provide the label text
)


        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
