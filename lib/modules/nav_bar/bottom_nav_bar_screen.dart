import 'package:dog_breeds/modules/favorites/favorites_breeds_page.dart';
import 'package:dog_breeds/modules/home/home_page.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int selectedPageIndex = 0;
  List<Widget> pages = const [
    HomePage(),
    FavoriteBreedsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPageIndex,
          onTap: (selectedIndex) {
            selectedPageIndex = selectedIndex;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorites")
          ]),
    );
  }
}
