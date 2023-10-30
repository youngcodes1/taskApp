import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmasta/Widgets/custom_button.dart';
import '../../../Provider/task_provider.dart';
import '../../../Utils/colors.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/custom_dropdown.dart';
import '../../../Widgets/custom_textform.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController createdDate = TextEditingController();
  TextEditingController createdTime = TextEditingController();
  // when you are passing the controller you will pass selectedCategory for the category option
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
  void dispose() {
    title.dispose();
    description.dispose();
    createdDate.dispose();
    createdTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskprovider = Provider.of<TaskProvider>(context);
    return Scaffold(
        appBar: CustomAppBar(
          title: 'ADD TASK',
          centerTitle: true,
          backgroundColor: Colors.purple,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel)),
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Title',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: title,
                      hintText: 'Add  title',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'title is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'description is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Category',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        CustomDropdown(
                          onCategorySelected: onCategorySelected,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
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
                              width: MediaQuery.of(context).size.width * 0.4,
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
                                width: MediaQuery.of(context).size.width * 0.4,
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
                      height: 30,
                    ),
                    CustomButton(
                        label: 'Add task',
                        color: Colors.purple,
                        loading: taskprovider.loading,
                        onPressed: taskprovider.loading
                            ? () {}
                            : () {
                                if (_formkey.currentState!.validate()) {
                                  taskprovider.addTask(
                                      title.text,
                                      description.text,
                                      selectedCategory,
                                      createdDate.text,
                                      createdTime.text);
                                }
                              }),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
