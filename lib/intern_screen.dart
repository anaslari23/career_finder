import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InternshipSearchPage extends StatefulWidget {
  @override
  _InternshipSearchPageState createState() => _InternshipSearchPageState();
}

class _InternshipSearchPageState extends State<InternshipSearchPage> {
  final apiKey = '84ffec0460743c55bc60bf704898ae1c5c210b7348843decf476d19d1ae53778'; // Replace with your SerpApi API Key
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

Future<void> _searchInternships(String query) async {
  try {
    final endpoint = 'https://serpapi.com/search?engine=google_jobs&q=$query';
    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _searchResults = data['jobs'] ?? [];
      });
    } else {
      // Handle non-200 response here
    }
  } catch (e) {
    // Handle network or parsing errors here
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internship Search'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for Internships',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchInternships(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final job = _searchResults[index];
                return ListTile(
                  title: Text(job['title']),
                  subtitle: Text(job['company']),
                  onTap: () {
                    // Add custom behavior when a job is tapped
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
