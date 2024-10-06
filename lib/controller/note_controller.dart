import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/note_model.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;
  var categories = ['Work', 'Home', 'Technology', 'WorkOut'].obs;
  var selectedCategories = <String>[].obs;
  var selectedTabhome = 0.obs;
  var selectedTab = 0.obs;
  final box = GetStorage();
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotes(); // Load notes from storage on init
  }
  void clearNoteFields() {

    selectedCategories.clear();
  }

  void loadNotes() {
    List<dynamic> storedNotes = box.read('notes') ?? [];
    notes.value = storedNotes.map((note) => Note.fromJson(note)).toList();
  }

  void saveNotes() {
    box.write('notes', notes.map((note) => note.toJson()).toList());
  }

  void addNote(Note note) {
    if (note.title.isEmpty || note.content.isEmpty || note.categories.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please fill in all fields before saving the note.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[300],
        colorText: Colors.white,
      );
    } else {
      notes.add(note);
      saveNotes(); // Save notes after adding
    }
  }

  void deleteNote(int index) {
    notes.removeAt(index);
    saveNotes(); // Save notes after deleting
  }

  // List<Note> filteredNotes() {
  //   if (selectedTab.value == 0) {
  //     return notes; // Return all notes if "All Notes" tab is selected
  //   }
  //
  //   String selectedCategory = '';
  //   switch (selectedTab.value) {
  //     case 1:
  //       selectedCategory = 'Work';
  //       break;
  //     case 2:
  //       selectedCategory = 'Technology';
  //       break;
  //     case 3:
  //       selectedCategory = 'Home';
  //       break;
  //     case 4:
  //       selectedCategory = 'WorkOut';
  //       break;
  //   }
  //
  //   // Filter notes by selected category
  //   return notes.where((note) => note.categories.contains(selectedCategory)).toList();
  // }


  List<Note> get filteredNotes {
    List<Note> filteredByCategory;

    // Apply category filtering based on the selected tab
    if (selectedTab.value == 0) {
      filteredByCategory = notes.toList(); // All Notes
    } else {
      String selectedCategory = '';
      switch (selectedTab.value) {
        case 1:
          selectedCategory = 'Work';
          break;
        case 2:
          selectedCategory = 'Home';
          break;
        case 3:
          selectedCategory = 'Technology';
          break;
        case 4:
          selectedCategory = 'WorkOut';
          break;
      }
      filteredByCategory = notes.where((note) => note.categories.contains(selectedCategory)).toList();
    }

    // Apply search filtering
    if (searchQuery.value.isNotEmpty) {
      return filteredByCategory.where((note) {
        return note.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            note.content.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }

    return filteredByCategory; // Return the filtered category notes
  }


  List<Note> get filteredSearchNotes {
    if (searchQuery.value.isEmpty) {
      return notes.toList(); // Return a copy of the notes
    }

    return notes.where((note) {
      return note.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          note.content.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();
  }
}



