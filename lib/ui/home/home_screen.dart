import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/note_controller.dart';
import '../note_viewing.dart';

class HomeScreen extends StatelessWidget {
  final NoteController noteController = Get.find();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Good Morning,', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Faisal !', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/images/user_img.png',
                height: height * 0.06, // 6% of screen height
                width: height * 0.06, // 6% of screen height
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04), // 4% of screen width
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.02), // 2% of screen height
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    noteController.searchQuery.value = value; // Update search query
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    labelText: 'Search',
                    filled: true,
                    fillColor: Colors.grey.shade900,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: height * 0.01), // 1% of screen height
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              DefaultTabController(
                length: 5,
                child: Column(
                  children: [
                    CustomTabBar(noteController: noteController),
                    SizedBox(height: height * 0.02), // 2% of screen height
                    SizedBox(
                      height: height * 0.6, // 60% of screen height
                      child: Obx(() {
                        final notes = noteController.filteredNotes;
                        if (notes.isEmpty) {
                          return Center(child: Text("No notes found", style: TextStyle(color: Colors.white)));
                        }
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            final note = notes[index];
                            Color backgroundColor = Colors.primaries[index % Colors.primaries.length].withOpacity(0.3);
                            return GestureDetector(
                              onTap: () {
                                Get.to(NoteViewingScreen(note: note, index: index));
                              },
                              child: Container(
                                padding: EdgeInsets.all(width * 0.04), // 4% of screen width
                                margin: EdgeInsets.all(width * 0.02), // 2% of screen width
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: height * 0.04), // 4% of screen height
                                    Text(
                                      _getShortContent(note.content),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.w400), // Responsive font size
                                    ),
                                    SizedBox(height: height * 0.01), // 1% of screen height
                                    Text(
                                      ' ${_formatDate(note.dateCreated)}',
                                      style: TextStyle(fontSize: width * 0.03, color: Colors.white70), // Responsive font size
                                    ),
                                    SizedBox(height: height * 0.01), // 1% of screen height
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.asset(
                                        'assets/images/user_img.png',
                                        height: height * 0.03, // 3% of screen height
                                        width: height * 0.03, // 3% of screen height
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// _getShortContent and _formatDate functions remain unchanged
}




String _getShortContent(String content) {
  List<String> words = content.split(' ');
  return words.take(6).join(' ') + (words.length > 6 ? '...' : '');
}

String _formatDate(DateTime date) {
  return "${date.day} ${_getMonth(date.month)} ${date.year}";
}

String _getMonth(int month) {
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  return months[month - 1];
}

class CustomTabBar extends StatelessWidget {
  final NoteController noteController;

  CustomTabBar({Key? key, required this.noteController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero, // No padding to eliminate gaps
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: TabBar(
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.yellow,
              indicatorWeight: 3, // Adjust thickness of the indicator line
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              onTap: (index) {
                noteController.selectedTab.value = index;
              },
              tabs: [
                Tab(
                  child: Text(
                    "All Notes",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Work",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Home",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Technology",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "WorkOut",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}














