import 'package:flutter/material.dart';


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
