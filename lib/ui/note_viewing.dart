import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/main.dart';
import 'package:notes/ui/edit_note.dart';
import '../controller/note_controller.dart';
import '../models/note_model.dart';

class NoteViewingScreen extends StatelessWidget {
  final Note note;
  final int index;
  final NoteController noteController = Get.find();

  NoteViewingScreen({super.key, required this.note, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Get.to(EditNoteScreen(note: note, index: index));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              noteController.deleteNote(index);
              Get.to(MainScreen());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Keep padding constant for all devices
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title TextField
              TextField(
                maxLines: null,
                controller: TextEditingController(text: note.title),
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Category TextField
              TextField(
                controller: TextEditingController(text: note.categories.isNotEmpty ? note.categories.first : 'No category'),
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Content TextField
              TextField(
                maxLines: null,
                controller: TextEditingController(text: note.content),
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
