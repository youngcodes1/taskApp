import 'package:flutter/material.dart';

import 'calender.dart';
import 'graphs.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.purple,
                    width: MediaQuery.of(context).size.width * 0.004,
                  ),
                ),
                isScrollable: true,
                labelColor: Colors.purple,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.symmetric(vertical: 8),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.085,
                ),
                tabs: const [
                  Tab(text: 'Calender'),
                  Tab(text: 'Graph'),
                ],
              ),
              const Expanded(
                child: TabBarView(children: [
                  CalenderPage(),
                  GraphPage(),
                ]),
              ),
            ],
          ),
        ));
  }
}
