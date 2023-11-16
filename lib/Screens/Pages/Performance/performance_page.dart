import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmasta/Widgets/custom_appbar.dart';

import '../../../Provider/theme_provider.dart';
import '../TabarPages/AllTasksPages/alltasks.dart';
import '../TabarPages/Report/report.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage({super.key});

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
            title: 'Performance',
            backgroundColor: themeprovider.isDarkModeEnabled
                ? Colors.grey[900] ?? Colors.black
                : Colors.purple,
            centerTitle: true,
            automaticallyImplyLeading: false,
            titleTextStyle: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        body: const Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TabBar(
              labelStyle: TextStyle(fontSize: 16),
              labelColor: Colors.purple,
              indicatorColor: Colors.purple,
              // unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: 'All Tasks',
                ),
                Tab(
                  text: 'Report',
                )
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                AllTasks(),
                ReportPage(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
