import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Models/chart_model.dart';

class Chart extends StatelessWidget {
  final List<ChartData>? data;
  // const Chart({super.key, this.data});
  const Chart(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
        legend: const Legend(
            isVisible: true,
            position: LegendPosition.right,
            textStyle: TextStyle(fontSize: 15)),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <DoughnutSeries<ChartData, String>>[
          DoughnutSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            pointColorMapper: (ChartData data, _) => data.color,
            dataLabelSettings: const DataLabelSettings(
                isVisible: true, labelPosition: ChartDataLabelPosition.outside),
            name: 'Task',
          )
        ]);
  }
}
