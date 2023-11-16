import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskmasta/Models/task_model.dart';
import 'package:taskmasta/Widgets/custom_textform.dart';

import '../../../Provider/task_provider.dart';
import '../../../Provider/theme_provider.dart';
import '../../../Utils/colors.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_dropdown.dart';

class UpdateTask extends StatefulWidget {
  final Task task;
  const UpdateTask({super.key, required this.task});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController createdDate = TextEditingController();
  TextEditingController createdTime = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedCategory = '';
  DateTime? selectedDate;
  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (selectedTime != null) {
      setState(() {
        createdTime.text = selectedTime.format(context);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2030));

    if (picked != null) {
      setState(() {
        createdDate.text = DateFormat.yMMMd().format(picked);
      });
    }
  }

  @override
  void initState() {
    title.text = widget.task.title;
    description.text = widget.task.description;
    selectedCategory = widget.task.category;
    createdDate.text = widget.task.createdDate;
    createdTime.text = widget.task.createdTime;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context);
    final themeprovider = Provider.of<ThemeProvider>(context);
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
                          color: Colors.purple),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Due date',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: CustomTextFormField(
                                  controller: createdDate,
                                  labelText: 'select a date',
                                  prefixIcon: IconButton(
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                    icon: const Icon(
                                      Icons.calendar_month,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'date is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Due time',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: CustomTextFormField(
                                    controller: createdTime,
                                    labelText: 'select time',
                                    prefixIcon: IconButton(
                                      onPressed: () {
                                        _selectTime(context);
                                      },
                                      icon: const Icon(
                                        Icons.schedule_outlined,
                                        color: Colors.purple,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'time is required';
                                      }
                                      return null;
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.26,
                            child: CustomButton(
                              label: 'Close',
                              onPressed: () {
                                Get.back();
                              },
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.17,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.26,
                            child: CustomButton(
                              label: 'Update',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Get.back();
                                  taskprovider.updateTasks(
                                      widget.task.id,
                                      title.text,
                                      description.text,
                                      selectedCategory,
                                      createdDate.text,
                                      createdTime.text);
                                }
                              },
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      )
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
