import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WishlistScreen(),
    );
  }
}

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<String> wishlistItems = ["Item 1", "Item 2", "Item 3", "Item 4"]; // Replace with your wishlist items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        backgroundColor: appBarColor1, // Set the background color of the AppBar
      ),
      body: Container(
        color: appBarColor2, // Set the background color of the screen
        child: AnimatedList(
          key: _listKey,
          initialItemCount: wishlistItems.length,
          itemBuilder: (context, index, animation) {
            return buildWishlistItem(wishlistItems[index], animation, index);
          },
        ),
      ),
    );
  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _removeItem(int index) {
    setState(() {
      wishlistItems.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => buildWishlistItem(wishlistItems[index], animation, index),
        duration: Duration(milliseconds: 500),
      );
    });
  }

  Widget buildWishlistItem(String item, Animation<double> animation, int index) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(item),
          trailing: IconButton(
            icon: Icon(Icons.remove_circle),
            onPressed: () => _removeItem(index),
          ),
        ),
      ),
    );
  }
}

// Define the color constants
const Color appBarColor1 = Color.fromARGB(255, 10, 10, 10);
const Color appBarColor2 = Color.fromARGB(255, 255, 255, 255);
