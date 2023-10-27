import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:taskmasta/Screens/Pages/TaskPages/add_task.dart';

import '../../../Provider/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.money_sharp,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  ' TaskMasta',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  '👋Hello,',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' Silas',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )
                              ],
                            )
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddTaskPage());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
