import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'package:todoapp/core/utils.dart';

// ignore: must_be_immutable
class EditTaskScreen extends StatefulWidget {
  int? id;
  String? taskName;
  String? taskDescription;
  DateTime? date;
  int? taskCategory;
  List<String> categories = ["Education", "Work", "Daily Tasks", "Groceries"];
  EditTaskScreen(
      {super.key,
      this.taskDescription,
      this.taskName,
      this.date,
      this.taskCategory,
      this.id});

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
                  onNameChanged: (newName) {
                    setState(() {
                      widget.taskName = newName;
                    });
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CategoriesRow(
                selectedCategory: widget.taskCategory,
                onCategorySelected: (int newCategory) {
                  setState(() {
                    widget.taskCategory = newCategory;
                  });
                },
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
              onDescriptionChanged: (newDescription) {
                setState(() {
                  widget.taskDescription = newDescription;
                });
              },
            ),
          ),
          SizedBox(height: 18),
          GestureDetector(
              onTap: () async {
                String formattedDate =
                    "${widget.date!.year.toString()}-${widget.date!.month.toString().padLeft(2, '0')}-${widget.date!.day.toString().padLeft(2, '0')}";
                await sqlDB.updateData(
                  "tasks",
                  {
                    "name": widget.taskName,
                    "description": widget.taskDescription,
                    "category": widget.taskCategory,
                    "isDone": 0,
                    "date": formattedDate,
                  },
                  "id = ?",
                  [
                    widget.id
                  ], // Pass the task ID to specify which row to update
                );

                Navigator.pop(context, true);
              },
              child: EditTaskButton())
        ],
      ),
    ));
  }
}

int getGategoryStr(String? category) {
  if (category == 'Education') return 0;
  if (category == 'Work') return 1;
  if (category == 'Daily Tasks') return 2;
  if (category == 'Groceries') {
    return 3;
  } else {
    return 4;
  }
}
