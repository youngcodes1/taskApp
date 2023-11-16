import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:taskmasta/Widgets/task_card_shimmer.dart';

import '../Provider/task_provider.dart';
import '../Provider/theme_provider.dart';

class CompletedCard extends StatefulWidget {
  const CompletedCard({super.key});

  @override
  State<CompletedCard> createState() => _CompletedCardState();
}

class _CompletedCardState extends State<CompletedCard> {
  @override
  void initState() {
    Provider.of<TaskProvider>(context, listen: false).fetchCompletedTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context);
    final themeprovider = Provider.of<ThemeProvider>(context);

    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        if (taskProvider.loading) {
          return const TaskShimmer();
        } else if (taskProvider.completedTasks.isEmpty) {
          return const Center(
              child: Text(
            'no task completed',
            style: TextStyle(
              fontSize: 16,
            ),
          ));
        } else {
          final tasks = taskProvider.completedTasks;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return Slidable(
                endActionPane: ActionPane(
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => {
                        // _showDialog(context, task),
                        // QuickAlert.show(
                        //   context: context,
                        //   type: QuickAlertType.confirm,
                        //   headerBackgroundColor: Colors.purple,
                        //   text: 'You want to mark as completed',
                        //   confirmBtnText: 'Yes',
                        //   cancelBtnText: 'No',
                        //   confirmBtnColor: Colors.green,
                        //   onConfirmBtnTap: () {},
                        // )
                      },
                      icon: Icons.edit,
                      label: '',
                      backgroundColor: Colors.blue,
                    ),
                    SlidableAction(
                      onPressed: (context) => {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          headerBackgroundColor: Colors.purple,
                          text: 'You want to delete',
                          confirmBtnText: 'Yes',
                          cancelBtnText: 'No',
                          confirmBtnColor: Colors.green,
                          onConfirmBtnTap: () {
                            Get.back();
                            taskprovider.delete(index);
                          },
                        )
                      },
                      icon: Icons.delete,
                      label: '',
                      backgroundColor: Colors.red,
                    ),
                    // SlidableAction(
                    //   onPressed: (context) => {
                    //     QuickAlert.show(
                    //       context: context,
                    //       type: QuickAlertType.confirm,
                    //       headerBackgroundColor: Colors.purple,
                    //       text: 'You want to mark as completed',
                    //       confirmBtnText: 'Yes',
                    //       cancelBtnText: 'No',
                    //       confirmBtnColor: Colors.green,
                    //       onConfirmBtnTap: () {},
                    //     )
                    //   },
                    //   icon: Icons.verified,
                    //   label: 'Completed',
                    //   backgroundColor: Colors.green,
                    // ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 20, right: 20),
                  child: Card(
                    elevation: 10,
                    shadowColor: themeprovider.isDarkModeEnabled
                        ? Colors.black
                        : Colors.purple,
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.2,
                      // width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: themeprovider.isDarkModeEnabled
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // 'code',
                                  task.title,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.blue),
                                ),
                                Text(
                                  // 'Todo',
                                  // Customize this part
                                  task.isCompleted ? 'Completed' : 'Todo',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: task.isCompleted
                                          ? Colors.green
                                          : Colors.orange),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              // 'coding on mondays',
                              task.description,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Due - ',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.blue),
                                    ),
                                    Text(
                                      // '23/09/23',
                                      task.createdDate,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Text(
                                  // '10:23',
                                  task.createdTime,
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
