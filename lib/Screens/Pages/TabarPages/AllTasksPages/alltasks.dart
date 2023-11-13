import 'package:flutter/material.dart';
import 'package:taskmasta/Screens/Pages/TabarPages/AllTasksPages/completedpage.dart';
import 'package:taskmasta/Screens/Pages/TabarPages/AllTasksPages/ongoingpage.dart';
import 'package:taskmasta/Screens/Pages/TabarPages/AllTasksPages/todopage.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({super.key});

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.purple,
                    width: MediaQuery.of(context).size.width * 0.004,
                  ),
                ),
                isScrollable: true,
                labelColor: Colors.purple,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.symmetric(vertical: 8),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.085,
                ),
                tabs: const [
                  Tab(text: 'Todo'),
                  // Tab(text: 'Ongoing'),
                  Tab(text: 'All Completed'),
                ],
              ),
              const Expanded(
                child: TabBarView(children: [
                  TodoPage(),
                  //  OngoingPage(),
                  CompletedPage()
                ]),
              ),
            ],
          ),
        ));
  }
}
