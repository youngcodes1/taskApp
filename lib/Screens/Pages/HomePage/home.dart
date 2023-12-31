import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:taskmasta/Provider/bottomnav_provider.dart';
import 'package:taskmasta/Provider/task_provider.dart';
import 'package:taskmasta/Provider/utils_provider.dart';
import 'package:taskmasta/Screens/Pages/TaskPages/add_task.dart';

import '../../../Models/chart_model.dart';
import '../../../Provider/chart_provider.dart';
import '../../../Provider/theme_provider.dart';
import '../../../Provider/user_provider.dart';
import '../../../Widgets/chart.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/task_card.dart';
import '../../../Widgets/today_task_card.dart';
import '../TaskPages/update_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChartData>? data;
  TooltipBehavior? _tooltip;
  String? user;

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return const AddTaskPage();
      },
    );
  }

  getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? storedUser = prefs.getString('email');
      if (storedUser != null) {
        final nameMatch = RegExp(r'([^0-9@]+)').firstMatch(storedUser);
        if (nameMatch != null) {
          final name = nameMatch.group(0);
          setState(() {
            user = name;
          });
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    // fetchTaskCounts();
    data = [
      ChartData('Today', 25, color: Colors.orange),
      ChartData('All Tasks', 38, color: Colors.blue),
      ChartData('Completed', 34, color: Colors.green),
    ];
    _tooltip = TooltipBehavior(enable: true);

    getUser();

    Provider.of<TaskProvider>(context, listen: false).fetchTaskCounts();
    Provider.of<TaskProvider>(context, listen: false).completetaskCount();
  }

  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context);
    final bottomprovider = Provider.of<BottomNavProvider>(context);
    final utilsprovider = Provider.of<UtilsProvider>(context);
    final taskprovider = Provider.of<TaskProvider>(context);
    final themeprovider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: themeprovider.isDarkModeEnabled
            ? Colors.grey[900] ?? Colors.black
            : Colors.purple,
        title: 'Dashboard',
        leading: const Icon(
          Icons.task,
          size: 30,
          color: Colors.white,
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: themeprovider.isDarkModeEnabled
                    ? Colors.grey[900] ?? Colors.black
                    : Colors.purple,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            // height: 125,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              '👋Good ${utilsprovider.greeting}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' $user',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   'Good ${utilsprovider.greeting}',
                        //   style: const TextStyle(
                        //       color: Colors.white, fontSize: 16),
                        // )
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.confirm,
                            headerBackgroundColor: Colors.purple,
                            text: themeprovider.isDarkModeEnabled
                                ? 'Do you want to logout'
                                : 'you want to logout',
                            confirmBtnText: 'Yes',
                            cancelBtnText: 'No',
                            confirmBtnColor: Colors.green,
                            onConfirmBtnTap: () {
                              userprovider.logoutUser();
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ))
                  ]),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView(
            children: [
              SizedBox(
                child: Card(
                    elevation: 10,
                    shadowColor: themeprovider.isDarkModeEnabled
                        ? Colors.black
                        : Colors.purple,
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: themeprovider.isDarkModeEnabled
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                            height: 180, width: 180, child: Chart(data)))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: Card(
                          shadowColor: Colors.orange,
                          elevation: 10,
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // "3",
                                // todayTasks.toString(),
                                taskprovider.todayTasks.toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Today's Tasks",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: Card(
                          shadowColor: Colors.blue,
                          elevation: 10,
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // "5",
                                // totalTasks.toString(),
                                taskprovider.totalTasks.toString(),

                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "All Tasks",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: Card(
                          shadowColor: Colors.green,
                          elevation: 10,
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // "4",
                                taskprovider.completeTasks.toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Completed Tasks",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Today'),
                    TextButton(
                        onPressed: () {
                          bottomprovider.updateIndex(0);
                        },
                        child: const Text('View All'))
                  ],
                ),
              ),
              // const TaskCard(),
              const TodayTaskCard()
            ],
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeprovider.isDarkModeEnabled
            ? Colors.grey[900] ?? Colors.black
            : Colors.purple,
        onPressed: () {
          _showCustomBottomSheet(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
