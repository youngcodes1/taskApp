import 'package:flutter/material.dart';
import 'package:taskmasta/Widgets/task_card.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TaskCard(),
        ],
      ),
    );
  }
}
