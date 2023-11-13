import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InternshipSearchPage(),
  ));
}

class InternshipSearchPage extends StatefulWidget {
  @override
  _InternshipSearchPageState createState() => _InternshipSearchPageState();
}

class _InternshipSearchPageState extends State<InternshipSearchPage> {
  final apiKey = 'AIzaSyAdhxy2tSjDzlEMhsi_ufqNKYHvPEzDU7w'; // Replace with your Google API Key
  final cx = 'f5abaa9a91144426e'; // Replace with your Custom Search Engine ID
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  Future<void> _searchInternships(String query) async {
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
        title: Text('Internship Search'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/internship.gif'),
            fit: BoxFit. cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                style: TextStyle(
                  color: const Color.fromARGB(255, 250, 249, 249),
                  fontWeight: FontWeight.bold, // Make entered text bold
                ),
                decoration: InputDecoration(
                  filled: true, // Fill the box
                  fillColor: Colors.black, // Box fill color
                  labelText: 'Search for Internships',
                  labelStyle: TextStyle(
                    color: Colors.white, // Label color
                    fontWeight: FontWeight.bold, // Make label bold
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.white, // Icon color
                    onPressed: () {
                      _searchInternships(_searchController.text);
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Border color when not focused
                      width: 2.0, // Make border bold
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Border color when focused
                      width: 2.0, // Make border bold
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
                        final job = _searchResults[index];
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              job['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold, // Make title bold
                                color: Colors.blue, // Change title color
                              ),
                            ),
                            onTap: () {
                              _launchURL(job['link']);
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
