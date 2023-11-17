import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    home: BookFinderScreen(),
  ));
}

class BookFinderScreen extends StatefulWidget {
  @override
  _BookFinderScreenState createState() => _BookFinderScreenState();
}

class _BookFinderScreenState extends State<BookFinderScreen> {
  List<dynamic> books = [];

  Future<void> fetchBooks(String query) async {
    final response = await http.get(
      Uri.parse("https://www.googleapis.com/books/v1/volumes?q=$query"),
    );

    if (response.statusCode == 200) {
      setState(() {
        books = json.decode(response.body)['items'];
      });
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/book.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                title: Text('Book Finder'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    fetchBooks(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for books...',
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index]['volumeInfo'];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailsScreen(book),
                          ),
                        );
                      },
                      child: BookTile(book: book),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BookTile extends StatelessWidget {
  final dynamic book;

  BookTile({required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          book['title'] ?? 'No Title',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          book['authors'] != null
              ? book['authors'].join(', ')
              : 'Unknown Author',
          style: TextStyle(color: Colors.white),
        ),
        leading: Hero(
          tag: book['id'] ?? UniqueKey(),
          child: _buildThumbnail(),
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    final thumbnailUrl = book['imageLinks']?['thumbnail'];
    return thumbnailUrl != null
        ? Image.network(
            thumbnailUrl,
            height: 60,
            width: 40,
            fit: BoxFit.cover,
          )
        : SizedBox.shrink();
  }
}

class BookDetailsScreen extends StatelessWidget {
  final dynamic book;

  BookDetailsScreen(this.book);

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title'] ?? 'No Title'),
        actions: [
          if (book['infoLink'] != null)
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                _launchURL(book['infoLink']);
              },
            ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: book['id'] ?? UniqueKey(),
              child: _buildThumbnail(),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: ${book['title'] ?? 'No Title'}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Authors: ${book['authors'] != null ? book['authors'].join(', ') : 'Unknown Author'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Description: ${book['description'] ?? 'No description available.'}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    final thumbnailUrl = book['imageLinks']?['thumbnail'];
    return thumbnailUrl != null
        ? Image.network(
            thumbnailUrl,
            height: 200,
            fit: BoxFit.cover,
          )
        : SizedBox.shrink();
  }
}
