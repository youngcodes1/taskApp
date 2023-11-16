import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmasta/Utils/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  bool _isDarkModeEnabled = false;
  ThemeData get themeData => _themeData;
  bool get isDarkModeEnabled => _isDarkModeEnabled;

  ThemeProvider() {
    loadThemeData();
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkModeEnabled = !_isDarkModeEnabled;
    _themeData = _isDarkModeEnabled ? darkMode : lightMode;
    saveThemeData();
    notifyListeners();
  }

  saveThemeData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isDarkModeEnabled', _isDarkModeEnabled);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  loadThemeData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _isDarkModeEnabled = prefs.getBool('isDarkModeEnabled') ?? false;
      _themeData = _isDarkModeEnabled ? darkMode : lightMode;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
