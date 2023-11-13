import 'package:flutter/material.dart';
import 'package:taskmasta/Widgets/custom_appbar.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
          title: 'Settings',
          backgroundColor: Colors.purple,
          centerTitle: true,
          automaticallyImplyLeading: false,
          titleTextStyle: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
