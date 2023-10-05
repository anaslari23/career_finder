import 'package:flutter/material.dart';

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
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: wishlistItems.length,
        itemBuilder: (context, index, animation) {
          return buildWishlistItem(wishlistItems[index], animation, index);
        },
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
