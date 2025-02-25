import 'package:flutter/material.dart';

import 'package:todoapp/core/utils.dart';

// ignore: must_be_immutable
class EditTaskScreen extends StatefulWidget {
  String? taskName;
  String? taskDescription;
  String? category;
  DateTime? date;
  EditTaskScreen(
      {super.key,
      this.taskDescription,
      this.taskName,
      this.category,
      this.date});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Row(
            children: [
              Stack(children: [
                Image(image: AssetImage('assets/images/homePageTopImage.png')),
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
                text: 'Edit Task',
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
                  taskName: widget.taskName,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CategoriesRow(
                selectedCategory: getGategory(widget.category),
              ),
            ],
          ),
          SizedBox(height: 18),
          CalendarTextField(
              date: widget.date,
              onDateChanged: (newDate) {
                setState(() {
                  widget.date = newDate; // Update the parent state
                });
              }),
          SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TaskDescriptionTextField(
              taskDescription: widget.taskDescription,
            ),
          ),
          SizedBox(height: 18),
          EditTaskButton()
                ],
              ),
        ));
  }
}

int getGategory(String? category) {
  if (category == 'Education') return 0;
  if (category == 'Work') return 1;
  if (category == 'Daily Tasks') return 2;
  if (category == 'Groceries')
    return 3;
  else
    return 4;
}
