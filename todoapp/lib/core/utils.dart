import 'package:flutter/material.dart';


class MyText extends StatelessWidget {
  final FontWeight? weight;
  final double size;
  final String text;
  final Color color;
  const MyText(
      {super.key,
      required this.size,
      this.weight,
      required this.text,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }
}

class TaskTypeContainer extends StatefulWidget {
  final Color color;
  final String imageIcon;
  final String taskType;
  final int taskNumber;
  const TaskTypeContainer({super.key,required this.color,required this.imageIcon, required this.taskType,required this.taskNumber});

  @override
  State<TaskTypeContainer> createState() => _TaskTypeContainerState();
}

class _TaskTypeContainerState extends State<TaskTypeContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.47, // 80% of screen width
      height: MediaQuery.of(context).size.height * 0.18,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(image: AssetImage(widget.imageIcon)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                    size: 15,
                    text: widget.taskType,
                    color: Colors.black,
                    weight: FontWeight.bold),
                MyText(
                    size: 15,
                    text: widget.taskNumber.toString(),
                    color: Colors.black,
                    weight: FontWeight.bold)
              ],
            )
          ],
        ),
      ),
    );
  }
}
