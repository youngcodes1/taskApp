import 'package:flutter/material.dart';

class UtilsProvider extends ChangeNotifier {
  String? _selectedOption;
  String? _greeting;
  String? get selectedOption => _selectedOption;
  String? get greeting => _greeting;

  UtilsProvider() {
    updateGreeting();
  }

  setSelectedOption(String? option) {
    _selectedOption = option!;
    notifyListeners();
  }

  getGreeting() {
    final int hour = DateTime.now().hour;
    if (hour < 12) {
      _greeting = 'Morning,';
    } else if (hour < 17) {
      _greeting = 'Afternoon,';
    }
    _greeting = 'Evening,';
  }

  updateGreeting() {
    getGreeting();
    notifyListeners();
  }
}
