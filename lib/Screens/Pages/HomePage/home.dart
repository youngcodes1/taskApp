import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:taskmasta/Provider/bottomnav_provider.dart';
import 'package:taskmasta/Screens/Pages/TaskPages/add_task.dart';

import '../../../Provider/user_provider.dart';
import '../../../Widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return const AddTaskPage();
      },
    );
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

  @override
  Widget build(BuildContext context) {
    // String greeting = getGreeting();
    final userprovider = Provider.of<UserProvider>(context);
    final bottomprovider = Provider.of<BottomNavProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
        backgroundColor: Colors.purple,
        title: 'Dashboard',
        leading: Icon(
          Icons.task,
          size: 30,
          color: Colors.white,
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              '👋Hi,',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' Silas',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.confirm,
                            headerBackgroundColor: Colors.purple,
                            text: 'Do you want to logout',
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
                      elevation: 10,
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "3",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Upcoming",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 200,
                    child: Card(
                      elevation: 10,
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "5",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Ongoing",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 200,
                    child: Card(
                      elevation: 10,
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "4",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Completed",
                            style: TextStyle(fontSize: 17, color: Colors.white),
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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCustomBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
