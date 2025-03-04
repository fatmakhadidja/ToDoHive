import 'package:flutter/material.dart';
import 'package:todoapp/core/utils.dart';
import 'package:todoapp/core/constants.dart';
import 'edit_task_page.dart';
import 'add_task_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> pressedTasks = [true, false, false, false];
  DateTime? selectedDate;
  List<Map<String, dynamic>> taskList = []; // Store tasks here
  bool isLoading = true; // To track loading state
  int indicator = 0;
  int category = 0;
  int workTasks = 0;
  int educationTasks = 0;
  int dailyTasks = 0;
  int groceriesTasks = 0;

  String date =
      "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";

  void navigateToAddTaskScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
    );

    if (result == true) {
      setState(() {
        fetchTasks();
      }); // Triggers rebuild when returning
    }
  }

  void navigateToEditTaskScreen(Map<String, dynamic> task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(
          id: task['id'],
          taskName: task['name'],
          taskCategory: task['category'],
          taskDescription: task['description'],
          date: DateTime.parse(task['date']),
        ),
      ),
    );
    if (result == true) {
      setState(() {
        fetchTasks();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      List<Map<String, dynamic>> tasks = await sqlDB.getData(
          "SELECT * FROM tasks WHERE category = $category AND date ='$date';");

      educationTasks = await sqlDB.countTasks("tasks", 0, date);
      workTasks = await sqlDB.countTasks("tasks", 1, date);
      dailyTasks = await sqlDB.countTasks("tasks", 2, date);
      groceriesTasks = await sqlDB.countTasks("tasks", 3, date);

      setState(() {
        taskList = tasks;
        isLoading = false;
        workTasks = workTasks;
        educationTasks = educationTasks;
        dailyTasks = dailyTasks;
        groceriesTasks = groceriesTasks;
      });
    } catch (e) {
      print("Error fetching tasks: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateTaskSelection(int index) {
    setState(() {
      for (int i = 0; i < pressedTasks.length; i++) {
        pressedTasks[i] = (i == index);
      }
      category = index;
      fetchTasks();
    });
  }

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
        selectedDate = pickedDate;
        date =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
        fetchTasks();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Image(
                      image: AssetImage('assets/images/homePageTopImage.png')),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 25, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          size: 16,
                          text: 'Hello,',
                          weight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        MyText(
                          size: 9,
                          text: 'Let\'s get started',
                          color: Color(0xff757575),
                          weight: FontWeight.w300,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => selectDate(context),
                icon: Icon(
                  Icons.edit_calendar,
                  color: Colors.black,
                ),
              )
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
                              taskNumber: educationTasks,
                              pressedTasks: pressedTasks,
                              index: 0,
                              onTap: updateTaskSelection,
                            ),
                            TaskTypeContainer(
                              color: MyColors.green,
                              imageIcon: 'assets/images/WorkIcon.png',
                              taskType: 'Work',
                              taskNumber: workTasks,
                              pressedTasks: pressedTasks,
                              index: 1,
                              onTap: updateTaskSelection,
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
                              taskNumber: dailyTasks,
                              pressedTasks: pressedTasks,
                              index: 2,
                              onTap: updateTaskSelection,
                            ),
                            TaskTypeContainer(
                              color: MyColors.brown,
                              imageIcon: 'assets/images/GroceriesIcon.png',
                              taskType: 'Groceries',
                              taskNumber: groceriesTasks,
                              pressedTasks: pressedTasks,
                              index: 3,
                              onTap: updateTaskSelection,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  isLoading
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : taskList.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(15),
                              child: Center(
                                  child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: Column(
                                  children: [    
                                    SizedBox(height: 30),
                                    MyText(
                                        size: 13,
                                        text: 'No Tasks left ..',
                                        color: Colors.grey)
                                  ],
                                ),
                              )),
                            )
                          : Column(
                              children: taskList
                                  .map((task) => TaskContainer(
                                        onTaskUpdated: () {
                                          navigateToEditTaskScreen(task);
                                        },
                                        id: task['id'],
                                        date: DateTime.parse(task[
                                            'date']), // turn String to DateTime
                                        category: task['category'],
                                        isChecked: task['isDone'] == 1,
                                        onTaskDeleted: () {
                                          setState(() {
                                            sqlDB.deleteData(
                                                "DELETE FROM tasks WHERE id = ${task['id']} ");
                                            fetchTasks();
                                          });
                                        },
                                        taskTitle: task['name'] ?? 'No Title',
                                        taskDescription: task['description'] ??
                                            'No Description',
                                        onStateChanged: (newValue) {
                                          setState(() {
                                            sqlDB.updateData(
                                              "tasks",
                                              {"isDone": newValue},
                                              "id = ?",
                                              [
                                                task['id']
                                              ], // Pass the task ID to specify which row to update
                                            );

                                            fetchTasks();
                                          });
                                        },
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
          navigateToAddTaskScreen();
        },
        backgroundColor: MyColors.mainPurple,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
