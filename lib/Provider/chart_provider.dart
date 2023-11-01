import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Models/chart_model.dart';

class ChartProvider extends ChangeNotifier {
  List<ChartData>? _data;
  TooltipBehavior? _tooltip;
  List<ChartData>? get chartData => _data;
  TooltipBehavior? get chartTooltip => _tooltip;

  initializeChart() {
    _data = [
      ChartData('Todo', 25, color: Colors.orange),
      ChartData('Ongoing', 38, color: Colors.blue),
      ChartData('Completed', 34, color: Colors.green)
    ];
    _tooltip = TooltipBehavior(enable: true);
    notifyListeners();
  }
}
