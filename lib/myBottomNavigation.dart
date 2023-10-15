import 'package:flutter/material.dart';
import 'package:sihapp/AnnouncementPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sihapp/LostFound.dart';
import 'package:sihapp/ProfilePage.dart';
import 'package:sihapp/menu.dart';

PageTransition customPageTransition(Widget page) {
  return PageTransition(
    type: PageTransitionType.rightToLeft,
    child: page,
  );
}
class MyBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  MyBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: (int index) {
        if (index == 1) {
          Navigator.of(context).push(customPageTransition(AnnouncementPage()));
        } else if (index == 2) {
          // Navigate to the Profile page
          Navigator.of(context).push(customPageTransition(ProfilePage()));
        } else if (index == 3) {
          // Navigate to the Help page
          Navigator.of(context).push(customPageTransition(LostAndFoundPage()));
        } else if (index == 4) {
          // Navigate to the Menu page
          Navigator.of(context).push(customPageTransition(MenuScreen()));
        }
        // Execute other logic based on index as needed

        // Call the provided callback function to update the selected index
        onItemTapped(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Announcements',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help),
          label: 'Help',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Menu',
        ),
      ],
    );
  }
}
