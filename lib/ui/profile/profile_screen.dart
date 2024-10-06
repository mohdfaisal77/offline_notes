import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController(text: 'Mohd Faisal');
  final TextEditingController descriptionController = TextEditingController(
    text: "I'm Mohd Faisal, I have developed multiple mobile applications using Flutter and Firebase",
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsets.all(width * 0.04), // 4% of screen width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name TextField
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: width * 0.05), // Responsive font size
            ),
            SizedBox(height: width * 0.04), // 4% of screen width

            // Description TextField
            TextField(
              maxLines: null,
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: width * 0.05), // Responsive font size
            ),
          ],
        ),
      ),
    );
  }
}
