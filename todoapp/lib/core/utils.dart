import 'package:flutter/material.dart';

import 'constants.dart';

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
      textAlign: TextAlign.start,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
      maxLines: null,
      overflow: TextOverflow.visible,
      softWrap: true,
    );
  }
}

// ignore: must_be_immutable
class TaskTypeContainer extends StatefulWidget {
  final Color color;
  final String imageIcon;
  final String taskType;
  final int taskNumber;
  List<bool> pressedTasks;
  final int index;
  final Function(int) onTap;

  TaskTypeContainer(
      {super.key,
      required this.color,
      required this.imageIcon,
      required this.taskType,
      required this.taskNumber,
      required this.pressedTasks,
      required this.index,
      required this.onTap});

  @override
  State<TaskTypeContainer> createState() => _TaskTypeContainerState();
}

class _TaskTypeContainerState extends State<TaskTypeContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.index); // Call the callback function
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: MediaQuery.of(context).size.width * 0.47,
        height: MediaQuery.of(context).size.height * 0.18,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: widget.pressedTasks[widget.index]
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ]
              : [],
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
                  Text(
                    widget.taskType,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    widget.taskNumber.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskContainer extends StatefulWidget {
  final int id;
  final String taskTitle;
  final String taskDescription;
  final int category;
  DateTime date;
  bool isChecked;
  final Function(int) onStateChanged;
  final Function() onTaskDeleted;
  final Function() onTaskUpdated;

  TaskContainer({
    super.key,
    required this.taskTitle,
    required this.taskDescription,
    required this.onStateChanged,
    required this.isChecked,
    required this.onTaskDeleted,
    required this.category,
    required this.date,
    required this.id,
    required this.onTaskUpdated,
  });

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: widget.isChecked
              ? const Color.fromARGB(255, 157, 211, 158)
              : const Color.fromARGB(255, 231, 231, 231),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  activeColor: Color.fromARGB(255, 231, 231, 231),
                  value: widget.isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.isChecked = value ?? false;
                    });
                    widget.onStateChanged(widget.isChecked ? 1 : 0);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.4, // 60% of row width
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          color: widget.isChecked ? Colors.white : Colors.black,
                          size: 17,
                          text: widget.taskTitle,
                          weight: FontWeight.w900,
                        ),
                        SizedBox(height: 5),
                        MyText(
                          color: widget.isChecked ? Colors.white : Colors.black,
                          size: 11,
                          text: widget.taskDescription,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: widget.onTaskUpdated,
                  icon: Icon(
                    Icons.edit,
                    color: widget.isChecked ? Colors.white : Color(0xff757575),
                  ),
                ),
                IconButton(
                  onPressed: widget.onTaskDeleted,
                  icon: Icon(Icons.delete, color: Colors.red),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskNameTextField extends StatefulWidget {
  final String? taskName;
  final Function(String) onNameChanged;

  const TaskNameTextField(
      {super.key, required this.taskName, required this.onNameChanged});

  @override
  State<TaskNameTextField> createState() => _TaskNameTextFieldState();
}

class _TaskNameTextFieldState extends State<TaskNameTextField> {
  late TextEditingController mycontroller;

  @override
  void initState() {
    super.initState();
    mycontroller = TextEditingController(text: widget.taskName);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      controller: mycontroller,
      onChanged: widget.onNameChanged, // Call parent function
      decoration: InputDecoration(
        labelText: 'Enter task name..',
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: MyColors.mainPurple, width: 2),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoriesRow extends StatefulWidget {
  int? selectedCategory;
  final Function(int) onCategorySelected;

  CategoriesRow(
      {super.key,
      required this.selectedCategory,
      required this.onCategorySelected});

  @override
  State<CategoriesRow> createState() => _CategoriesRowState();
}

class _CategoriesRowState extends State<CategoriesRow> {
  List<String> categories = ["Education", "Work", "Daily Tasks", "Groceries"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(categories.length, (index) {
          bool isSelected = widget.selectedCategory == index;
          return GestureDetector(
            onTap: () {
              widget.onCategorySelected(index); // Notify parent widget
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isSelected ? MyColors.mainPurple : Colors.purple[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ignore: must_be_immutable
class CalendarTextField extends StatefulWidget {
  DateTime? date;
  final ValueChanged<DateTime> onDateChanged; // Add this

  CalendarTextField({super.key, this.date, required this.onDateChanged});

  @override
  _CalendarTextFieldState createState() => _CalendarTextFieldState();
}

class _CalendarTextFieldState extends State<CalendarTextField> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.date; // Initialize state with provided date
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  selectedDate == null
                      ? 'Select Date'
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: IconButton(
                  onPressed: () => _selectDate(context),
                  icon: Icon(
                    Icons.calendar_month,
                    color: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
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
      });

      // Notify parent widget about the change
      widget.onDateChanged(pickedDate);
    }
  }
}

// ignore: must_be_immutable
class TaskDescriptionTextField extends StatefulWidget {
  final String? taskDescription;
  final Function(String) onDescriptionChanged;

  const TaskDescriptionTextField(
      {super.key,
      required this.taskDescription,
      required this.onDescriptionChanged});

  @override
  State<TaskDescriptionTextField> createState() =>
      _TaskDescriptionTextFieldState();
}

class _TaskDescriptionTextFieldState extends State<TaskDescriptionTextField> {
  late TextEditingController mycontroller;

  @override
  void initState() {
    super.initState();
    mycontroller = TextEditingController(text: widget.taskDescription);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: mycontroller,
      onChanged: widget.onDescriptionChanged, // Call parent function
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Task Description',
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: 'Enter task description ..',
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: MyColors.mainPurple, width: 2),
        ),
      ),
    );
  }
}

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null, // This will be handled in the GestureDetector above
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(MyColors.mainPurple),
      ),
      child: MyText(
        size: 14,
        text: 'Add Task',
        color: Colors.white,
        weight: FontWeight.w700,
      ),
    );
  }
}

class EditTaskButton extends StatefulWidget {
  const EditTaskButton({super.key});

  @override
  State<EditTaskButton> createState() => _EditTaskButtonState();
}

class _EditTaskButtonState extends State<EditTaskButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(MyColors.mainPurple)),
      child: MyText(
        size: 14,
        text: 'Save Changes',
        color: Colors.white,
        weight: FontWeight.w700,
      ),
    );
  }
}
