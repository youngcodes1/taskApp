import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:provider/provider.dart';

import '../../../../Models/task_model.dart';
import '../../../../Provider/task_provider.dart';
import '../../../../Provider/theme_provider.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DateTime _selectedDate = DateTime.now();
  List<Task> _tasksForSelectedDate = [];

  Future<void> _fetchTasksForSelectedDate(TaskProvider taskProvider) async {
    final tasks = await taskProvider.getTasksForDate(_selectedDate);

    setState(() {
      _tasksForSelectedDate = tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context);
    final themeprovider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: DatePicker(DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.purple,
                selectedTextColor: Colors.white,
                dateTextStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                dayTextStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                monthTextStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600), onDateChange: (date) async {
              setState(() {
                _selectedDate = date;
              });
              await _fetchTasksForSelectedDate(taskprovider);
            }),
          ),
          Expanded(
            child: _tasksForSelectedDate.isEmpty
                ? const Center(
                    child: Text(
                      'no task available for this day',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tasksForSelectedDate.length,
                    itemBuilder: ((context, index) {
                      final task = _tasksForSelectedDate[index];

                      return Padding(
                          padding: const EdgeInsets.only(
                              top: 40.0, left: 20, right: 20),
                          child: Card(
                              elevation: 10,
                              shadowColor: themeprovider.isDarkModeEnabled
                                  ? Colors.black
                                  : Colors.purple,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  color: themeprovider.isDarkModeEnabled
                                      ? Colors.black
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            task.title,
                                            // 'code',

                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.blue),
                                          ),
                                          Text(
                                            // 'Today',
                                            task.isCompleted
                                                ? 'Completed'
                                                : 'Todo',
                                            // // Customize this part

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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Due - ',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.blue),
                                              ),
                                              Text(
                                                // '23/09/23',
                                                task.createdDate,
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            // '10:23',
                                            task.createdTime,
                                            style: const TextStyle(
                                                color: Colors.purple,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )));
                    })),
          )
        ],
      ),
    );
  }
}
