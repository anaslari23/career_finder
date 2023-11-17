import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(JobPortalApp());

class JobPortalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JobSearchScreen(),
    );
  }
}

class JobSearchScreen extends StatefulWidget {
  @override
  _JobSearchScreenState createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _keywordsController = TextEditingController(text: "");
  final TextEditingController _locationController = TextEditingController(text: "");
  List<dynamic> jobList = [];
  bool isLoading = false;
  bool noJobsPosted = false;

  Future<void> _searchJobs() async {
    final apiKey = "6026e5d3-c363-483e-b36e-90bf9d700490"; // Replace with your actual API key
    final url = Uri.parse("https://jooble.org/api/$apiKey");
    final params = {
      "keywords": _keywordsController.text,
      "location": _locationController.text,
    };

    setState(() {
      isLoading = true;
      jobList.clear();
      noJobsPosted = false;
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(params),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey("jobs") && jsonResponse["jobs"] is List) {
          setState(() {
            jobList = jsonResponse["jobs"];
            noJobsPosted = jobList.isEmpty;
          });
        } else {
          // Handle the response structure appropriately
          print("Invalid or missing 'jobs' field in the response.");
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recruitment Section"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/giphy.gif', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _keywordsController,
                        decoration: InputDecoration(
                          hintText: 'Enter Job Title',
                          filled: true,
                          fillColor: Color.fromARGB(255, 253, 233, 233),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a job title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          hintText: 'Enter Location',
                          filled: true,
                          fillColor: Color.fromARGB(255, 253, 233, 233),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a location';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _searchJobs();
                  }
                },
                child: Text('Search'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 7, 7, 7),
                  ),
                ),
              ),
              Expanded(
                child: isLoading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : noJobsPosted
                    ? Center(
                  child: AnimatedDefaultTextStyle(
                    child: Text("No new jobs posted"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.red, // You can set your preferred color
                    ),
                    duration: Duration(milliseconds: 300),
                  ),
                )
                    : ListView.builder(
                  itemCount: jobList.length,
                  itemBuilder: (context, index) {
                    final job = jobList[index];
                    final title = job['title'] ?? 'No Title';
                    final company = job['company'] ?? 'No Company';
                    final jobLink = job['link'] ?? '';

                    return JobBox(title: title, company: company, jobLink: jobLink);
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

class JobBox extends StatelessWidget {
  final String title;
  final String company;
  final String jobLink;

  JobBox({required this.title, required this.company, required this.jobLink});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchJobLink(),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromARGB(223, 33, 88, 143),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 117, 117, 117).withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 233, 233, 235),
              ),
            ),
            Text(
              company,
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 148, 147, 147),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchJobLink() async {
    if (await canLaunch(jobLink)) {
      await launch(jobLink);
    } else {
      print('Could not launch $jobLink');
    }
  }
}