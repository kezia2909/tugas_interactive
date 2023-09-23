import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/gallery_page.dart';
import 'package:flutter_application_1/pages/notes_page.dart';
import 'package:flutter_application_1/utils/color_utils.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  List pages = [GalleryPage(), NotesPage()];
  int _selectedIndex = 0;
  String title = "My Gallery";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        title = "My Gallery";
      } else if (_selectedIndex == 1) {
        title = "My Notes";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          foregroundColor: colorTheme(colorWhite),
          backgroundColor: colorTheme(colorBlack),
        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_album),
              label: 'Gallery',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_add),
              label: 'Notes',
            )
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: colorTheme(colorWhite),
          unselectedItemColor: colorTheme(colorAccent, opacity: 0.75),
          selectedItemColor: colorTheme(colorBlack),
        ));
  }
}
