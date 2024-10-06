import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/note_controller.dart';
import 'ui/create_note/create_note.dart';
import 'ui/home/home_screen.dart';
import 'ui/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize GetStorage
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple[700]!,
          onPrimary: Colors.white,
          secondary: Colors.teal[700]!,
          onSecondary: Colors.white,
          background: Colors.black,
          onBackground: Colors.white,
          surface: Colors.grey[850]!,
          onSurface: Colors.white,
          error: Colors.red,
          onError: Colors.white,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark, // Use system theme mode
      home: MainScreen(),
    );
  }
}


class MainScreen extends StatelessWidget {
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: noteController.selectedTabhome.value,
          children: [
            HomeScreen(),
            ProfileScreen(),
          ],
        );
      }),
      bottomNavigationBar: Container(
        color: Colors.black, // Background color for the bottom navigation
        padding: EdgeInsets.only(top: 8, bottom: 16), // Add space from the bottom
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home Icon Button
            GestureDetector(
              onTap: () {
                noteController.selectedTabhome.value = 0; // Navigate to Home
              },
              child: Obx(() {
                return Container(
                  width: 50, // Set a fixed width
                  height: 50, // Set a fixed height equal to width
                  decoration: BoxDecoration(
                    color: noteController.selectedTabhome.value == 0
                        ? Colors.grey.withOpacity(0.2) // Background color for Home when selected
                        : Colors.transparent, // Default color
                    borderRadius: BorderRadius.circular(25), // Half of width/height for circular effect
                  ),
                  alignment: Alignment.center, // Center the icon within the container
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                );
              }),
            ),



            // Floating Action Button
            Container(
              width: 44, // Match the width of the FAB
              height: 44,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Get.to(NoteCreationScreen());
                },
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.2),
                elevation: 0, // Remove shadow
              ),
            ),

            GestureDetector(
              onTap: () {
                // Change the selected tab to Home
                noteController.selectedTabhome.value = 1; // Navigate to Home
                // Additional logic if you want to ensure the color is set immediately
                // You can use a simple delay if needed for animations
              },
              child: Obx(() {
                return Container(
                  width: 50, // Set a fixed width
                  height: 50, // Set a fixed height equal to width
                  decoration: BoxDecoration(
                    color: noteController.selectedTabhome.value == 1
                        ? Colors.grey.withOpacity(0.2)  // Background color for Home when selected
                        : Colors.transparent, // Default color
                    borderRadius: BorderRadius.circular(25), // Half of width/height for circular effect
                  ),
                  padding: EdgeInsets.all(10), // Optional: Add some padding
                  alignment: Alignment.center, // Center the icon within the container
                  child: Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                  ),
                );

              }),
            ),

            // Profile Icon Button
            // IconButton(
            //   icon: Icon(Icons.person, color: Colors.white),
            //   onPressed: () {
            //     noteController.selectedTabhome.value = 1;
            //     // Navigate to Profile
            //   },
            //   // Change the background color based on selection
            //   iconSize: 28,
            //   color: noteController.selectedTabhome.value == 1
            //       ? Colors.green // Selected color
            //       : Colors.white, // Default color
            // ),
          ],
        ),
      ),
      extendBody: true, // Allows the FAB to overlap with the bottom navigation
    );
  }
}
