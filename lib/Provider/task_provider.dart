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

  bool _loading = false;
  bool get loading => _loading;

  addTask(String title, String description, String category, String createdDate,
      String createdTime) async {
    try {
      _loading = true;
      notifyListeners();
      // final currentTime = DateTime.now();

      final newTask = Task(
        title: title,
        description: description,
        category: category,
        createdDate: createdDate,
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
      final today = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(today);
      List<Task> taskMaps =
          await _taskDatabaseHelper.getTodaysTask(formattedDate);
      _taskAddedToday = taskMaps
          .map((taskMap) => Task.fromMap(taskMap as Map<String, dynamic>))
          .toList();
      _loading = false;
      notifyListeners();
      return _taskAddedToday;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  updateTasks(String title, String description, String category,
      String createdDate, String createdTime) async {
    try {
      _loading = true;
      notifyListeners();
      // final currentTime = DateTime.now();
      final updatedTask = Task(
        title: title,
        description: description,
        category: category,
        createdDate: createdDate,
        createdTime: createdTime,
      );
      bool updated = await _taskDatabaseHelper.updateTask(updatedTask);
      _loading = false;
      notifyListeners();
      if (updated) {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.success,
          text: 'Task updtaed Successfully!',
        );
      } else {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Sorry, an error occured',
        );
      }
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
}
