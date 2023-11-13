import 'package:flutter/material.dart';

import 'package:taskmasta/Widgets/completed_taskcard.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          CompletedCard(),
        ],
      ),
    );
  }
}
