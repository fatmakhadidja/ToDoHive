import 'package:flutter/material.dart';
import 'package:todoapp/core/utils.dart';
import 'package:todoapp/core/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(children: [
                Image(image: AssetImage('assets/images/homePageTopImage.png')),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 18, 0, 10),
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit_calendar,
                    color: Colors.black,
                  ))
            ],
          ),
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
                        taskType: 'Projects',
                        taskNumber: 10),
                    TaskTypeContainer(
                        color: MyColors.green,
                        imageIcon: 'assets/images/WorkIcon.png',
                        taskType: 'Work',
                        taskNumber: 5),
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
                        taskNumber: 2),
                    TaskTypeContainer(
                        color: MyColors.brown,
                        imageIcon: 'assets/images/GroceriesIcon.png',
                        taskType: 'Groceries',
                        taskNumber: 4),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              TaskContainer(),
            ],
          ),
        ],
      ),
    );
  }
}
