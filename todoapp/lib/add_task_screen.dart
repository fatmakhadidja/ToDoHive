import 'package:flutter/material.dart';
import 'package:todoapp/core/constants.dart';
import 'package:todoapp/core/utils.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
              TaskNameTextField(),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CategoriesRow(),
          ],
        ),
        SizedBox(height: 18),
        CalendarTextField(),
        SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TaskDescriptionTextField(),
        ),
        SizedBox(height: 18),
        AddTaskButton()
      ],
    ));
  }
}
