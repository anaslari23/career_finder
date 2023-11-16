// Add these dependencies to your pubspec.yaml file:
// pdf: ^3.6.0
// path_provider: ^2.0.5
// open_file: ^4.2.2
// file_picker: ^4.0.0
// Then run: flutter pub get

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(
    MaterialApp(
      home: ResumeBuilderScreen(),
    ),
  );
}

class ResumeBuilderScreen extends StatefulWidget {
  @override
  _ResumeBuilderScreenState createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _phone = '';
  String _education = '';
  String _experience = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, generate the resume
      generateResume();
    }
  }

  void generateResume() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Resume', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text('Name: $_name'),
            pw.Text('Email: $_email'),
            pw.Text('Phone: $_phone'),
            pw.Text('Education: $_education'),
            pw.Text('Experience: $_experience'),
          ],
        ),
      ),
    );

    // Get the temporary directory using the path_provider package
    final tempDir = await getTemporaryDirectory();

    // Save the PDF to the temporary directory
    final file = File('${tempDir.path}/resume.pdf');
    await file.writeAsBytes(await pdf.save());

    // Choose a file name and location before opening
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.paths.isNotEmpty) {
      // Handle the nullable value
      String selectedPath = result.paths.first!;

      // Copy the generated PDF to the selected location
      File newFile = File(selectedPath);
      await file.copy(newFile.path);

      // Open the PDF using the open_file package
      OpenFile.open(newFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume Builder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Education'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your education details';
                  }
                  return null;
                },
                onSaved: (value) {
                  _education = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Experience'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your experience details';
                  }
                  return null;
                },
                onSaved: (value) {
                  _experience = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Generate Resume'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
