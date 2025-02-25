import 'package:flutter/material.dart';
import 'package:todoapp/core/utils.dart';
import 'sqldb/sqldb.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  List<String> categories = ["Education", "Work", "Daily Tasks", "Groceries"];
  final SqlDB sqlDB = SqlDB();
  DateTime selectedDate = DateTime.now();
  String taskName = '';
  String taskDescription = '';
  int taskCategory = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Stack(children: [
                  Image(
                      image: AssetImage('assets/images/homePageTopImage.png')),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(8, 18, 0, 10),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.black,
                      )),
                ]),
                MyText(
                  size: 16,
                  text: 'Create New Task',
                  color: Color(0xff444444),
                  weight: FontWeight.w500,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    size: 16,
                    text: 'Task Name',
                    color: Colors.black,
                    weight: FontWeight.w800,
                  ),
                  SizedBox(height: 10),
                  TaskNameTextField(
                    taskName: taskName,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CategoriesRow(selectedCategory: taskCategory),
              ],
            ),
            SizedBox(height: 18),
            CalendarTextField(
                date: DateTime.now(),
                onDateChanged: (newDate) {
                  setState(() {
                    selectedDate = newDate; // Update the parent state
                  });
                }),
            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TaskDescriptionTextField(
                taskDescription: taskDescription,
              ),
            ),
            SizedBox(height: 18),
            AddTaskButton(
                taskName: taskName,
                taskDescription: taskDescription,
                taskCategory: categories[taskCategory],
                date:
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}')
          ],
        ),
      ),
    ));
  }
}
