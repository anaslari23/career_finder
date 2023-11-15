import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TrendingCourseSearchPage(),
  ));
}

class TrendingCourseSearchPage extends StatefulWidget {
  @override
  _TrendingCourseSearchPageState createState() =>
      _TrendingCourseSearchPageState();
}

class _TrendingCourseSearchPageState extends State<TrendingCourseSearchPage> {
  final apiKey = 'AIzaSyAdhxy2tSjDzlEMhsi_ufqNKYHvPEzDU7w'; // Replace with your Google API Key
  final cx = 'a6c69b09e7f1c4dac'; // Replace with your Custom Search Engine ID
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  Future<void> _searchCourses(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final endpoint =
          'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$cx&q=$query';
      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('items')) {
          final items = data['items'];
          setState(() {
            _searchResults = List<Map<String, dynamic>>.from(items);
          });
        }
      } else {
        // Handle non-200 response here
      }
    } catch (e) {
      // Handle network or parsing errors here
    } finally {
      setState(() {
        _isLoading = false;
      });
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
      appBar: AppBar(
        title: Text('Trending Course Search'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/internship.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  labelText: 'Search for Trending Courses',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.white,
                    onPressed: () {
                      _searchCourses(_searchController.text);
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final course = _searchResults[index];
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              course['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              _launchURL(course['link']);
                            },
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
