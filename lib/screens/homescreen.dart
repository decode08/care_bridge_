import 'package:care_bridge/res/color.dart';
import 'package:care_bridge/screens/community.dart';
import 'package:care_bridge/screens/home.dart';
import 'package:care_bridge/screens/mood.dart';
import 'package:care_bridge/screens/profile.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Home(),
    MoodPage(),
    Center(
      child: Text('yoga', style: TextStyle(fontSize: 20)),
    ),
    CommunityScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.selectedItem,
        unselectedItemColor: AppColors.mainColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.music_note), label: "Mood"),
        BottomNavigationBarItem(icon: Icon(Icons.sports_gymnastics), label: "Yoga"),
        BottomNavigationBarItem(icon: Icon(Icons.group),label: "Community"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label:"Profile")
      ]),
    );
  }
}
