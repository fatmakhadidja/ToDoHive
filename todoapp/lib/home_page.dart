import 'package:flutter/material.dart';
import 'package:todoapp/core/utils.dart';
import 'package:todoapp/core/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> pressedTasks = [true, false, false, false];
  void _updateTaskSelection(int index) {
    setState(() {
      for (int i = 0; i < pressedTasks.length; i++) {
        pressedTasks[i] = (i == index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate;

    Future<void> selectDate(BuildContext context) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: MyColors.mainPurple,
              colorScheme: ColorScheme.light(primary: MyColors.mainPurple),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );

      if (pickedDate != null && pickedDate != selectedDate) {
        setState(() {
          selectedDate = pickedDate; // Update the selected date
        });
      }
    }

    List<Map<String, String>> taskList = [
      {
        'taskTitle': 'Task 1',
        'taskDescription': 'Complete the Flutter project'
      },
      {'taskTitle': 'Task 2', 'taskDescription': 'Review UI design'},
      {'taskTitle': 'Task 3', 'taskDescription': 'Write documentation'},
      {
        'taskTitle': 'Task 3',
        'taskDescription':
            'Write documentation\n Write documentation\n Write documentation'
      },
    ];
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(children: [
                Image(image: AssetImage('assets/images/homePageTopImage.png')),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 25, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          size: 16,
                          text: 'Hello,',
                          weight: FontWeight.bold,
                          color: Colors.black),
                      MyText(
                        size: 9,
                        text: 'Let\'s get started',
                        color: Color(0xff757575),
                        weight: FontWeight.w300,
                      )
                    ],
                  ),
                ),
              ]),
              IconButton(
                  onPressed: () => selectDate(context),
                  icon: Icon(
                    Icons.edit_calendar,
                    color: Colors.black,
                  ))
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TaskTypeContainer(
                              color: MyColors.blue,
                              imageIcon: 'assets/images/ProjectIcon.png',
                              taskType: 'Education',
                              taskNumber: 10,
                              pressedTasks: pressedTasks,
                              index: 0,
                              onTap: _updateTaskSelection,
                            ),
                            TaskTypeContainer(
                              color: MyColors.green,
                              imageIcon: 'assets/images/WorkIcon.png',
                              taskType: 'Work',
                              taskNumber: 5,
                              pressedTasks: pressedTasks,
                              index: 1,
                              onTap: _updateTaskSelection,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TaskTypeContainer(
                              color: MyColors.mainPurple,
                              imageIcon: 'assets/images/DailyTasksIcon.png',
                              taskType: 'Daily Tasks',
                              taskNumber: 2,
                              pressedTasks: pressedTasks,
                              index: 2,
                              onTap: _updateTaskSelection,
                            ),
                            TaskTypeContainer(
                              color: MyColors.brown,
                              imageIcon: 'assets/images/GroceriesIcon.png',
                              taskType: 'Groceries',
                              taskNumber: 4,
                              pressedTasks: pressedTasks,
                              index: 3,
                              onTap: _updateTaskSelection,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  taskList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: Center(
                              child: MyText(
                            size: 18,
                            text: ' You Have No Tasks Today',
                            color: Colors.black,
                            weight: FontWeight.w500,
                          )),
                        )
                      : Column(
                          children: taskList
                              .map((task) => TaskContainer(
                                    taskTitle: task['taskTitle'] ?? 'No Title',
                                    taskDescription: task['taskDescription'] ??
                                        'No Description',
                                  ))
                              .toList(),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addTask');
        },
        backgroundColor: MyColors.mainPurple,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
