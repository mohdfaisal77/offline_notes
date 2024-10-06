import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/note_controller.dart';
import '../../main.dart';
import '../../models/note_model.dart';
import '../home/home_screen.dart';

class NoteCreationScreen extends StatelessWidget {
  final NoteController noteController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; // Get screen width

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text(
          'Create Note',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: width * 0.05, // Responsive font size
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.05), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title TextField
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              style: TextStyle(fontSize: width * 0.045), // Responsive font size
            ),
            SizedBox(height: width * 0.04), // Responsive spacing

            // Content TextField
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              maxLines: 4,
              style: TextStyle(fontSize: width * 0.045), // Responsive font size
            ),
            SizedBox(height: width * 0.04), // Responsive spacing

            // Category Selection
            Text(
              'Select Categories:',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: width * 0.045), // Responsive font size
            ),
            Obx(() {
              return Column(
                children: noteController.categories.map((category) {
                  return CheckboxListTile(
                    title: Text(category, style: TextStyle(fontSize: width * 0.04)), // Responsive font size
                    value: noteController.selectedCategories.contains(category),
                    onChanged: (isSelected) {
                      if (isSelected == true) {
                        noteController.selectedCategories.add(category);
                      } else {
                        noteController.selectedCategories.remove(category);
                      }
                    },
                  );
                }).toList(),
              );
            }),
            SizedBox(height: width * 0.04), // Responsive spacing

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    // Validation checks
                    if (titleController.text.isEmpty ||
                        contentController.text.isEmpty ||
                        noteController.selectedCategories.isEmpty) {
                      Get.snackbar(
                        'Validation Error',
                        'Please fill in all fields before saving the note.',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red[300],
                        colorText: Colors.white,
                      );
                    } else {
                      final note = Note(
                        title: titleController.text,
                        content: contentController.text,
                        categories: noteController.selectedCategories.toList(),
                      );
                      noteController.addNote(note); // Add note after validation
                      titleController.clear();
                      contentController.clear();
                      noteController.selectedCategories.clear();

                      // Directly navigate back to the Home screen after saving
                      Get.to(MainScreen()); // Closes the current screen
                      noteController.selectedTabhome.value = 0; // Switch to Home tab
                    }
                  },
                  child: Text('Save Note'),
                ),
                TextButton(
                  onPressed: () {
                    titleController.clear();
                    contentController.clear();
                    noteController.selectedCategories.clear(); // Navigate back without saving
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
