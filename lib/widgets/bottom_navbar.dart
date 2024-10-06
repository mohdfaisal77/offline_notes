// import 'package:flutter/material.dart';
// import 'package:notes/ui/home/home_screen.dart';
//
// import '../ui/create_note/create_note.dart';
// import '../ui/profile/profile_screen.dart';
//
// class BottomNav extends StatelessWidget {
//   const BottomNav({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     final controller= Get.put(NavigationController());
//     return Scaffold(
//       bottomNavigationBar: Obx(
//             ()=> NavigationBar(
//           height: 80,
//           elevation: 0,
//           selectedIndex: controller.selectedIndex.value,
//           onDestinationSelected: (index) =>controller.selectedIndex.value = index,
//           destinations: [
//             NavigationDestination(icon: Icon(Icons.home), label: ""),
//             NavigationDestination(icon: Icon(Icons.add), label: ""),
//             NavigationDestination(icon: Icon(Icons.person_rounded), label: ""),
//           ],
//         ),
//       ),
//       body:Obx(()=> controller.screens[controller.selectedIndex.value],),
//     );
//   }
// }
// class NavigationController extends GetxController{
//   final Rx<int> selectedIndex = 0.obs;
//
//   final screens = [HomeScreen(),CreateNote(),ProfileScreen()];
// }