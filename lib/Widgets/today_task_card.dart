import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:taskmasta/Widgets/task_card_shimmer.dart';

import '../Provider/task_provider.dart';

class TodayTaskCard extends StatefulWidget {
  const TodayTaskCard({super.key});

  @override
  State<TodayTaskCard> createState() => _TodayTaskCardState();
}

class _TodayTaskCardState extends State<TodayTaskCard> {
  @override
  void initState() {
    Provider.of<TaskProvider>(context, listen: false).fetchTasksForToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context);

    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        if (taskProvider.loading) {
          return const TaskShimmer();
        } else if (taskProvider.taskAddedToday.isEmpty) {
          return const Center(
              child: Text(
            'no task available today',
            style: TextStyle(fontSize: 16),
          ));
        } else {
          final tasks = taskProvider.taskAddedToday;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 20, right: 20),
                  child: Card(
                      elevation: 10,
                      shadowColor: Colors.purple,
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 0.2,
                        // width: MediaQuery.of(context).size.width * 0.8,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    task.title,
                                    // 'code',

                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.blue),
                                  ),
                                  const Text(
                                    'Today',
                                    // // Customize this part

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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                      )));
            },
          );

          // return FutureBuilder<List<Task>>(
          //   future: taskprovider.fetchTasksForToday(),
          //   builder: ((context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const TaskShimmer();
          //     } else if (snapshot.hasError) {
          //       return const Center(child: Text('Error fetching tasks'));
          //     } else if (!snapshot.hasData && !snapshot.data!.isNotEmpty) {
          //       return const Center(child: Text('No Tasks available today'));
          //     } else {
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         itemCount: snapshot.data!.length,
          //         itemBuilder: (context, index) {
          //           return Padding(
          //             padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
          //             child: Card(
          //               elevation: 10,
          //               shadowColor: Colors.purple,
          //               child: Container(
          //                 height: MediaQuery.of(context).size.height * 0.2,
          //                 width: MediaQuery.of(context).size.width * 0.8,
          //                 decoration: BoxDecoration(
          //                   color: Colors.white,
          //                   borderRadius: BorderRadius.circular(20),
          //                 ),
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(20.0),
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Row(
          //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Text(
          //                             snapshot.data![index].title!,
          //                             // 'code',

          //                             style: const TextStyle(
          //                                 fontSize: 18, color: Colors.blue),
          //                           ),
          //                           Text(
          //                             // 'Todo',
          //                             // // Customize this part
          //                             snapshot.data![index].description!,
          //                             style: const TextStyle(
          //                                 fontSize: 18, color: Colors.orange),
          //                           ),
          //                         ],
          //                       ),
          //                       const SizedBox(
          //                         height: 20,
          //                       ),
          //                       const Text(
          //                         'coding on mondays',
          //                         style: TextStyle(fontSize: 18),
          //                       ),
          //                       const SizedBox(
          //                         height: 20,
          //                       ),
          //                       const Row(
          //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Row(
          //                             children: [
          //                               Text(
          //                                 'Due - ',
          //                                 style: TextStyle(
          //                                     fontSize: 18, color: Colors.blue),
          //                               ),
          //                               Text(
          //                                 '23/09/23',
          //                                 style: TextStyle(fontSize: 18),
          //                               ),
          //                             ],
          //                           ),
          //                           Text(
          //                             '10:23',
          //                             style: TextStyle(
          //                                 color: Colors.green,
          //                                 fontSize: 16,
          //                                 fontWeight: FontWeight.bold),
          //                           ),
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           );
          //         },
          //       );
          //     }
          //   }),
          // );

//   }
// }
        }
      },
    );
  }
}
