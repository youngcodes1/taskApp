import 'package:flutter/material.dart';

class UtilsProvider extends ChangeNotifier {
  String? _selectedOption;
  String? get selectedOption => _selectedOption;

  setSelectedOption(String? option) {
    _selectedOption = option!;
    notifyListeners();
  }

  getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good morning';
    } else if (hour < 17) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }
    return greeting;
  }
}
