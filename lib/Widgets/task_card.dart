import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:taskmasta/Widgets/task_card_shimmer.dart';

import '../Models/task_model.dart';
import '../Provider/task_provider.dart';
import '../Screens/Pages/TaskPages/update_task.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  void initState() {
    Provider.of<TaskProvider>(context, listen: false).fetchAllTasks();
    super.initState();
  }

  void _showDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return UpdateTask(task: task);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context);

    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        if (taskProvider.loading) {
          return const TaskShimmer();
        } else if (taskProvider.tasks.isEmpty) {
          return const Center(
              child: Text(
            'no tasks available',
            style: TextStyle(
              fontSize: 16,
            ),
          ));
        } else {
          final tasks = taskProvider.tasks;

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
                        _showDialog(context, task),
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
                      label: 'Edit',
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
                      label: 'Delete',
                      backgroundColor: Colors.red,
                    ),
                    SlidableAction(
                      onPressed: (context) => {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          headerBackgroundColor: Colors.purple,
                          text: 'You want to mark as completed',
                          confirmBtnText: 'Yes',
                          cancelBtnText: 'No',
                          confirmBtnColor: Colors.green,
                          onConfirmBtnTap: () {},
                        )
                      },
                      icon: Icons.verified,
                      label: 'Completed',
                      backgroundColor: Colors.green,
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 20, right: 20),
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.purple,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                                const Text(
                                  'Todo', // Customize this part
                                  // task.isCompleted?'Completed':'Todo',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.orange),
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
          //   },

          // );

          // return FutureBuilder<List<Task>>(
          //   future: taskprovider.fetchAllTasks(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const TaskShimmer();
          //     } else if (snapshot.hasError) {
          //       return Text('Error: ${snapshot.error}');
          //     } else if (snapshot.hasData) {
          //       final tasks = snapshot.data!;

          //       return ListView.builder(
          //         shrinkWrap: true,
          //         itemCount: tasks.length,
          //         itemBuilder: (context, index) {
          //           final task = tasks[index];

          //           return Slidable(
          //             endActionPane: ActionPane(
          //               motion: const BehindMotion(),
          //               children: [
          //                 SlidableAction(
          //                   onPressed: (context) => {
          //                     QuickAlert.show(
          //                       context: context,
          //                       type: QuickAlertType.confirm,
          //                       headerBackgroundColor: Colors.purple,
          //                       text: 'You want to delete',
          //                       confirmBtnText: 'Yes',
          //                       cancelBtnText: 'No',
          //                       confirmBtnColor: Colors.green,
          //                       onConfirmBtnTap: () {
          //                         taskprovider.delete(index);
          //                       },
          //                     )
          //                   },
          //                   icon: Icons.delete,
          //                   label: 'Delete',
          //                   backgroundColor: Colors.red,
          //                 ),
          //                 SlidableAction(
          //                   onPressed: (context) => {
          //                     QuickAlert.show(
          //                       context: context,
          //                       type: QuickAlertType.confirm,
          //                       headerBackgroundColor: Colors.purple,
          //                       text: 'You want to mark as completed',
          //                       confirmBtnText: 'Yes',
          //                       cancelBtnText: 'No',
          //                       confirmBtnColor: Colors.green,
          //                       onConfirmBtnTap: () {},
          //                     )
          //                   },
          //                   icon: Icons.verified,
          //                   label: 'Completed',
          //                   backgroundColor: Colors.green,
          //                 ),
          //               ],
          //             ),
          //             child: Padding(
          //               padding:
          //                   const EdgeInsets.only(top: 40.0, left: 20, right: 20),
          //               child: Card(
          //                 elevation: 10,
          //                 shadowColor: Colors.purple,
          //                 child: Container(
          //                   height: MediaQuery.of(context).size.height * 0.2,
          //                   width: MediaQuery.of(context).size.width * 0.8,
          //                   decoration: BoxDecoration(
          //                     color: Colors.white,
          //                     borderRadius: BorderRadius.circular(20),
          //                   ),
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(20.0),
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Row(
          //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                           children: [
          //                             Text(
          //                               // 'code',
          //                               task.title,
          //                               style: const TextStyle(
          //                                   fontSize: 18, color: Colors.blue),
          //                             ),
          //                             const Text(
          //                               'Todo', // Customize this part
          //                               style: TextStyle(
          //                                   fontSize: 18, color: Colors.orange),
          //                             ),
          //                           ],
          //                         ),
          //                         const SizedBox(
          //                           height: 20,
          //                         ),
          //                         const Text(
          //                           'coding on mondays',
          //                           style: TextStyle(fontSize: 18),
          //                         ),
          //                         const SizedBox(
          //                           height: 20,
          //                         ),
          //                         const Row(
          //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                           children: [
          //                             Row(
          //                               children: [
          //                                 Text(
          //                                   'Due - ',
          //                                   style: TextStyle(
          //                                       fontSize: 18, color: Colors.blue),
          //                                 ),
          //                                 Text(
          //                                   '23/09/23',
          //                                   style: TextStyle(fontSize: 18),
          //                                 ),
          //                               ],
          //                             ),
          //                             Text(
          //                               '10:23',
          //                               style: TextStyle(
          //                                   color: Colors.green,
          //                                   fontSize: 16,
          //                                   fontWeight: FontWeight.bold),
          //                             ),
          //                           ],
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           );
          //         },
          //       );
          //     } else {
          //       return const Center(child: Text('No tasks available.'));
          //     }
          //   },
          // );
//   }
// }
        }
      },
    );
  }
}
