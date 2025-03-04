import 'package:flutter/material.dart';
import 'package:todoapp/screens/add_task_screen.dart';
import 'package:todoapp/screens/edit_task_page.dart';
import 'package:todoapp/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: {
        '/addTask': (context) => AddTaskScreen(),
        '/editTask': (context) => EditTaskScreen(),
      },
    );
  }
}
