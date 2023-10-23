import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class InternScreen extends StatefulWidget {
  @override
  _InternScreenState createState() => _InternScreenState();
}

class _InternScreenState extends State<InternScreen> {
  String url = ''; // Initialize with an empty URL

  @override
  void initState() {
    super.initState();
    // Call the function to fetch the URL when the screen is first loaded
    fetchData();
  }
Future<void> fetchData() async {
  final apiUrl = 'https://indeed12.p.rapidapi.com/job/02eb3a9f080f10e7'; // Replace with your actual API endpoint
  final headers = {
    "X-RapidAPI-Key": "YOUR_RAPIDAPI_KEY", // Replace with your RapidAPI key
    "X-RapidAPI-Host": "indeed12.p.rapidapi.com",
  };

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      setState(() {
        url = response.body; // Store the fetched URL in the state
      });
    } else {
      // Handle API request error
      print('Failed to fetch data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongoing Internships'),
      ),
      body: url.isNotEmpty // Check if the URL is not empty
          ? WebView(
              initialUrl: url, // Display the fetched URL in the WebView
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
