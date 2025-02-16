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
  const TaskTypeContainer(
      {super.key,
      required this.color,
      required this.imageIcon,
      required this.taskType,
      required this.taskNumber});

  @override
  State<TaskTypeContainer> createState() => _TaskTypeContainerState();
}

class _TaskTypeContainerState extends State<TaskTypeContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.48, // 80% of screen width
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

class TaskContainer extends StatefulWidget {
  const TaskContainer({super.key});

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xffD5D5D5), width: 1.5),
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Color(0xffC1C1C1), // Shadow color
          //     spreadRadius: 1, // How much the shadow spreads
          //     blurRadius: 20, // Softness of the shadow
          //     offset: Offset(0, 2), // Moves shadow right & down
          //   ),
          // ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          color: Colors.black,
                          size: 17,
                          text: 'Task1',
                          weight: FontWeight.bold),
                      SizedBox(height: 5),
                      MyText(
                          color: Color(0xff757575),
                          size: 11,
                          text: 'Description',
                          weight: FontWeight.w500),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: Color(0xff757575)),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete, color: Colors.red))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
