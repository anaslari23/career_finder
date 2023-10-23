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
    final apiUrl = 'YOUR_API_URL_HERE'; // Replace with your API endpoint
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        url = response.body; // Store the fetched URL in the state
      });
    } else {
      // Handle API request error
      print('Failed to fetch data. Status code: ${response.statusCode}');
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
