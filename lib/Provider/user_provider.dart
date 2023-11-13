import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmasta/Services/user_databasehelper.dart';

import '../Models/user_model.dart';
import '../Screens/Auth/login.dart';
import '../Screens/Auth/signup.dart';
import '../Widgets/bottom_nav.dart';

class UserProvider extends ChangeNotifier {
  final UserDatabaseHelper _userDatabaseHelper = UserDatabaseHelper.instance;

  bool _loading = false;
  String? _user;
  bool get loading => _loading;
  String? get user => _user;

  signupUser(String username, String email, String password) async {
    try {
      _loading = true;
      notifyListeners();

      User? existingUser = await _userDatabaseHelper.queryUser(email, password);
      if (existingUser != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
              content: Text('An account with this email already exists')),
        );
        _loading = false;
        notifyListeners();
        return;
      }

      User newUser = User(username: username, email: email, password: password);
      await _userDatabaseHelper.createUser(newUser);
      final prefs = await SharedPreferences.getInstance();
      // prefs.setString('email', email);
      prefs.setString('username', username);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Signed up Successfully')),
      );
      Get.to(const LoginScreen());

      _loading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _loading = false;
      notifyListeners();
    }
  }

  loginUser(String email, String password) async {
    try {
      _loading = true;
      notifyListeners();
      User? user = await _userDatabaseHelper.queryUser(email, password);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);

      if (user != null) {
        Get.to(const BottomNav());
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Invalid username and password')),
        );
        _loading = false;
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());

      notifyListeners();
    }
  }

  isUserLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? storedEmail = prefs.getString('email');
      if (storedEmail != null) {
        Get.to(const BottomNav());
      } else {
        Get.to(const SignUpScreen());
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  logoutUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Get.offAll(const LoginScreen());
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('logged out successfully')),
      );
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? storedUser = prefs.getString('email');
      if (storedUser != null) {
        _user = storedUser;

        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
