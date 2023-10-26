import 'package:flutter/material.dart';

import '../Screens/Pages/pages_exports.dart';

class BottomNavProvider extends ChangeNotifier {
  int currentIndex = 1;

  final screens = const [
    PerformancePage(),
    HomePage(),
    Settings(),
  ];

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
