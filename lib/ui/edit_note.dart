import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/main.dart';
import '../../controller/note_controller.dart';
import '../../models/note_model.dart';

class EditNoteScreen extends StatelessWidget {
  final NoteController noteController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final int index;
  final Note note;

  EditNoteScreen({required this.note, required this.index}) {
    titleController.text = note.title;
    contentController.text = note.content;
    noteController.selectedCategories.value = note.categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text('Edit Note'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Title TextField
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Content TextField
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16),

            // Categories Section
            Text(
              'Select Categories:',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            Obx(() {
              return Column(
                children: noteController.categories.map((category) {
                  return CheckboxListTile(
                    title: Text(category),
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
            SizedBox(height: 16),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
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
                      final updatedNote = Note(
                        title: titleController.text,
                        content: contentController.text,
                        categories: noteController.selectedCategories.toList(),
                      );

                      noteController.notes[index] = updatedNote; // Update the note
                      noteController.saveNotes(); // Save notes after updating

                      titleController.clear();
                      contentController.clear();
                      noteController.selectedCategories.clear();

                      Get.to(MainScreen()); // Closes the current screen
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
