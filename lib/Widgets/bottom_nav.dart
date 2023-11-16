import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/bottomnav_provider.dart';
import '../Provider/theme_provider.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    final bottomprovider = context.watch<BottomNavProvider>();
    final themeprovider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        body: bottomprovider.screens[bottomprovider.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor:
                themeprovider.isDarkModeEnabled ? Colors.black : Colors.white,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey,
            iconSize: 30,
            selectedFontSize: 18,
            unselectedFontSize: 16,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            currentIndex: bottomprovider.currentIndex,
            onTap: (index) {
              bottomprovider.updateIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_chart), label: "first"),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "second"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "third"),
            ]));
  }
}
