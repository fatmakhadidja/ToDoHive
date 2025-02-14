import 'package:flutter/material.dart';

import 'package:todoapp/core/utils.dart';

class Onboardingpage extends StatelessWidget {
  const Onboardingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/gradientBg.png'),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/images/logo.png')),
                  SizedBox(width: 10),
                  BlackText(text: 'TodoHive', size: 41, weight: FontWeight.w900)
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlackText(
                      size: 13,
                      text: 'Innovative, user-friendly,\n'
                          'and easy.')
                ],
              ),
              SizedBox(height: 10),
              SizedBox(width: 150, height: 30, child: GetStartedButton())
            ],
          ),
        ),
      ),
    );
  }
}
