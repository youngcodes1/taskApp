import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Models/chart_model.dart';
import '../Models/task_model.dart';

class ChartProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  List<ChartData>? _chartData = [];
  TooltipBehavior? _tooltip;
  List<ChartData>? get chartData => _chartData;
  TooltipBehavior? get chartTooltip => _tooltip;
  List<Task> get tasks => _tasks;

  void _updateChartData() {
    // Filter tasks based on categories
    //   List<Task> todoTasks = _tasks.where((task) => !task.isCompleted).toList();
    //   List<Task> todayTasks = _tasks
    //       .where((task) =>
    //           task.createdDate.isAtSameMomentAs(DateTime.now()) &&
    //           !task.isCompleted)
    //       .toList();
    //   List<Task> completedTasks = _tasks.where((task) => task.isCompleted).toList();

    //   // Get the count for each category
    //   int todoCount = todoTasks.length;
    //   int todayCount = todayTasks.length;
    //   int completedCount = completedTasks.length;

    //   // Calculate total count
    //   int totalCount = todoCount + todayCount + completedCount;

    //   // Calculate percentages
    //   double todoPercentage = (todoCount / totalCount) * 100;
    //   double todayPercentage = (todayCount / totalCount) * 100;
    //   double completedPercentage = (completedCount / totalCount) * 100;

    //   // Update _chartData
    //   _chartData = [
    //     ChartData('Todo', todoPercentage, color: Colors.orange),
    //     ChartData('Today', todayPercentage, color: Colors.blue),
    //     ChartData('Completed', completedPercentage, color: Colors.green),
    //   ];

    //   // Notify listeners to update dependent widgets
    //   notifyListeners();
    // }

    // initializeChart() {
    //   _data = [
    //     ChartData('Todo', 25, color: Colors.orange),
    //     ChartData('Ongoing', 38, color: Colors.blue),
    //     ChartData('Completed', 34, color: Colors.green)
    //   ];
    //   _tooltip = TooltipBehavior(enable: true);
    //   notifyListeners();
  }
}
