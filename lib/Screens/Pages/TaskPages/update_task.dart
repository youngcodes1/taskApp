import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taskmasta/Widgets/custom_textform.dart';

import '../../../Utils/colors.dart';
import '../../../Widgets/custom_dropdown.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({super.key});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  String selectedCategory = '';
  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Update Task',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ],
                ),
              ),
              Form(
                child: Material(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Title',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        controller: title,
                        hintText: 'Add title',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Description',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: description,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Add description',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.inputInactive,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.myblue,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'description is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Category',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomDropdown(
                        onCategorySelected: onCategorySelected,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
