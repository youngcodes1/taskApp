import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:taskmasta/Services/task_databasehelper.dart';

import '../Models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final TaskDatabaseHelper _taskDatabaseHelper = TaskDatabaseHelper.instance;

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;
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
      _loading = false;
      notifyListeners();
      // if (inserted) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        text: 'Task added Successfully!',
      );
      // } else {
      //   QuickAlert.show(
      //     context: Get.context!,
      //     type: QuickAlertType.error,
      //     title: 'Oops...',
      //     text: 'Sorry, an error occured',
      //   );
      // }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _loading = false;
      notifyListeners();
    }
  }

  fetchAllTasks() async {
    try {
      List<Task> taskList = await _taskDatabaseHelper.getTasks();
      _tasks = taskList;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
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

  delete(int id) async {
    try {
      bool deleted = await _taskDatabaseHelper.deleteTask(id);
      if (deleted) {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.success,
          text: 'Task deleted Successfully!',
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
    }
  }
}
