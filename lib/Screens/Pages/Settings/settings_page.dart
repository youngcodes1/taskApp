import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmasta/Widgets/custom_appbar.dart';

import '../../../Provider/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? user;

  getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? storedUser = prefs.getString('email');
      if (storedUser != null) {
        setState(() {
          user = storedUser;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Settings',
          backgroundColor: themeprovider.isDarkModeEnabled
              ? Colors.grey[900] ?? Colors.black
              : Colors.purple,
          centerTitle: true,
          automaticallyImplyLeading: false,
          titleTextStyle: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
        child: ListView(
          children: [
            Card(
              elevation: 10,
              shadowColor: themeprovider.isDarkModeEnabled
                  ? Colors.black
                  : Colors.purple,
              child: Container(
                decoration: BoxDecoration(
                  color: themeprovider.isDarkModeEnabled
                      ? Colors.black
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.person),
                            Text(
                              // 'Silas@gmail.com',
                              ' $user',
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Preferences',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 10,
              shadowColor: themeprovider.isDarkModeEnabled
                  ? Colors.black
                  : Colors.purple,
              child: Container(
                decoration: BoxDecoration(
                  color: themeprovider.isDarkModeEnabled
                      ? Colors.black
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        themeprovider.isDarkModeEnabled
                            ? 'DarkMode'
                            : 'LightMode',
                        style: const TextStyle(fontSize: 16),
                      ),
                      DayNightSwitcher(
                        isDarkModeEnabled: themeprovider.isDarkModeEnabled,
                        onStateChanged: (isDarkModeEnabled) {
                          themeprovider.toggleTheme();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
