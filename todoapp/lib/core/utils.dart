import 'package:flutter/material.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: ButtonStyle(
          side: WidgetStatePropertyAll<BorderSide>(
              BorderSide(color: Colors.black))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Get Started',
              style: TextStyle(color: Colors.black, fontSize: 13)),
          Icon(
            Icons.arrow_circle_right_outlined,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class BlackText extends StatelessWidget {
  final FontWeight? weight;
  final double size;
  final String text;
  const BlackText(
      {super.key, required this.size, this.weight, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: size, fontWeight: weight),
    );
  }
}
