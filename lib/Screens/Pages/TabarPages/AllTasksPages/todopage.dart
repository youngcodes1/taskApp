import 'package:flutter/material.dart';
import 'package:taskmasta/Widgets/custom_appbar.dart';
import 'package:taskmasta/Widgets/custom_textform.dart';
import 'package:taskmasta/Widgets/task_card.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08),
            child: CustomTextFormField(
              controller: searchController,
              suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.blue,
                  )),
              hintText: 'Search Task',
            ),
          ),
          const TaskCard(),
        ],
      ),
    );
  }
}
