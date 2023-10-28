import 'package:flutter/material.dart';

class UtilsProvider extends ChangeNotifier {
  String? _selectedOption;
  String? get selectedOption => _selectedOption;

  setSelectedOption(String? option) {
    _selectedOption = option!;
    notifyListeners();
  }
}
