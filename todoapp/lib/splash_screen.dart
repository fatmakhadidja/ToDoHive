import 'package:flutter/material.dart';
import 'dart:async';
import 'package:todoapp/core/utils.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Your main screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/gradientBg.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(image: AssetImage('assets/images/Vector1.png')),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/images/logo.png')),
                      SizedBox(width: 10),
                      MyText(
                          text: 'TodoHive', size: 41, weight: FontWeight.w900,color:Colors.black)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                          size: 13,
                          color:Colors.black,
                          text: 'Innovative, user-friendly,\n'
                              'and easy.')
                    ],
                  ),
                  SizedBox(height: 10),
                  CircularProgressIndicator(
                    color: Colors.black,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image(image: AssetImage('assets/images/Vector2.png')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
