import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:taskmasta/Services/task_databasehelper.dart';

import '../Models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final TaskDatabaseHelper _taskDatabaseHelper = TaskDatabaseHelper.instance;

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;
  List<Task> _taskAddedToday = [];
  List<Task> get taskAddedToday => _taskAddedToday;
  List<Task> _filteredTasks = [];
  List<Task> get filteredTasks => _filteredTasks;
  List<Task> _completedTasks = [];
  List<Task> get completedTasks => _completedTasks;
  List<Task> _tasksForSelectedDate = [];
  List<Task> get tasksForSelectedDate => _tasksForSelectedDate;
  // int _totalTasks = 0;
  // int get totalTasks => _totalTasks;

  // int _todayTasks = 0;
  // int get todayTasks => _todayTasks;

  int totalTasks = 0;
  int todayTasks = 0;
  int completeTasks = 0;

  bool _loading = false;
  bool get loading => _loading;

  addTask(String title, String description, String category, String createdDate,
      String createdTime) async {
    try {
      _loading = true;
      notifyListeners();
      final DateTime parsedDate = DateFormat('yMMMd').parse(createdDate);
      final newTask = Task(
        title: title,
        description: description,
        category: category,
        createdDate: DateFormat('yMMMd').format(parsedDate),
        createdTime: createdTime,
      );
      // bool inserted =
      await _taskDatabaseHelper.insertTask(newTask);
      await fetchTasksForToday();
      _loading = false;
      notifyListeners();
      // if (inserted) {
      Get.back();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        text: 'Task added Successfully!',
      );

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllTasks() async {
    try {
      _loading = true;
      notifyListeners();
      final List<Task> taskList = await _taskDatabaseHelper.getAllTasks();
      _loading = false;
      _tasks = taskList;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _loading = false;
    }
  }

  Future<List<Task>> fetchTasksForToday() async {
    try {
      _loading = true;
      notifyListeners();
      final List<Task> todayTasks = await _taskDatabaseHelper.getTodaysTask();
      _taskAddedToday = todayTasks;
      _loading = false;
      return todayTasks;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  updateTasks(int? id, String title, String description, String category,
      String createdDate, String createdTime) async {
    try {
      _loading = true;
      notifyListeners();

      final updatedTask = Task(
        id: id,
        title: title,
        description: description,
        category: category,
        createdDate: createdDate,
        createdTime: createdTime,
      );

      await _taskDatabaseHelper.updateTask(updatedTask);
      _loading = false;
      notifyListeners();

      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        text: 'Task updtaed Successfully!',
      );

      fetchAllTasks();
      notifyListeners();

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _loading = false;
      notifyListeners();
    }
  }

  delete(int index) async {
    try {
      await _taskDatabaseHelper.deleteTask(_tasks[index].id!);
      _tasks.removeAt(index);

      notifyListeners();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        text: 'Task deleted Successfully!',
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  searchTasks(String query) {
    try {
      _filteredTasks = _tasks
          .where((task) =>
              task.title.toLowerCase().contains(query.toLowerCase()) ||
              task.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  markCompleted(int index) async {
    try {
      // Set the completion status to true
      _tasks[index].isCompleted = true;

      // Update the task in the database
      await _taskDatabaseHelper.updateTask(_tasks[index]);

      // Move the completed task to the _completedTasks list
      _completedTasks.add(_tasks[index]);

      // Remove the completed task from the main tasks list
      // _tasks.removeAt(index);

      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        text: 'Task Completed!',
      );
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  fetchCompletedTasks() async {
    try {
      _loading = true;
      notifyListeners();
      _completedTasks = await _taskDatabaseHelper.getCompletedTasks();
      _loading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> fetchTaskCounts() async {
    try {
      await fetchAllTasks();
      await fetchTasksForToday();

      totalTasks = _tasks.length;
      todayTasks = _taskAddedToday.length;

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  completetaskCount() async {
    try {
      await fetchCompletedTasks();
      completeTasks = _completedTasks.length;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // bool isTaskOverdue(Task task){
  //    final now = DateTime.now();
  //   return !task.isCompleted && task.createdDate.isBefore()
  // }

  Future<List<Task>> getTasksForDate(DateTime date) async {
    try {
      _loading = true;
      notifyListeners();
      final List<Task> tasks = await _taskDatabaseHelper.getTasksForDate(date);
      _loading = false;
      return tasks;
    } catch (e) {
      debugPrint(e.toString());
      _loading = false;
      return [];
    }
  }
}
