import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/task_provider.dart';
import 'package:task_manager/utils.dart';
import 'package:task_manager/widgets/button.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  var categoryController = TextEditingController();
  var iconController = TextEditingController();

  @override
  void dispose() {
    categoryController.dispose();
    iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskState = context.watch<TaskState>();
    String category = categoryController.text;
    String icon = iconController.text;

    return AlertDialog(
      title: const Text("Add Category"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Category"),
          const SizedBox(
            height: 4,
          ),
          _CustomTextField(
              onChanged: (value) => category = value,
              hintText: 'Enter category'),
          const SizedBox(
            height: 16,
          ),
          const Text("Icon"),
          const SizedBox(
            height: 4,
          ),
          _CustomTextField(
              onChanged: (value) => icon = value,
              hintText: 'Icon should be emoji'),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              if (category.isNotEmpty) {
                taskState.addCategory(
                    category: category, icon: isEmoji(icon) ? icon : "📋");
              }
              Navigator.pop(context);
            },
            child: const Text("Add")),
      ],
    );
  }
}

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  var taskLabelController = TextEditingController();
  String selectTimeLabel = "Select time";
  String selectDateLabel = "Select Date";
  String taskLabel = "";
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  String taskCategory = "";
  @override
  void dispose() {
    taskLabelController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final themeColor = Theme.of(context).colorScheme;
    final taskState = context.watch<TaskState>();

    return Dialog.fullscreen(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton.outlined(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                )),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Add Task",
              style: textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "Category",
              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            DropdownMenu(
                width: double.maxFinite,
                inputDecorationTheme: InputDecorationTheme(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: themeColor.surfaceDim,
                ),
                onSelected: (value) {
                  setState(() {
                    if (value != null) {
                      taskCategory = value;
                    }
                  });
                },
                menuStyle: MenuStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(themeColor.surfaceDim)),
                initialSelection: taskState.categories.keys.first,
                dropdownMenuEntries: taskState.categories.keys
                    .map(
                      (e) => DropdownMenuEntry(value: e, label: e),
                    )
                    .toList()),
            const SizedBox(
              height: 32,
            ),
            Text(
              "Label",
              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),

            _CustomTextField(
                onChanged: (value) => setState(() {
                      taskLabel = value;
                    }),
                hintText: "Create Instagram Post"),
            const SizedBox(
              height: 12,
            ),

            const SizedBox(
              height: 32,
            ),
            // TODO: Select Categories
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Date",
                          style: textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: themeColor.surfaceDim,
                            shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onPressed: () async {
                            final DateTime? datePicker = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2026));
                            if (datePicker != null) {
                              setState(() {
                                selectedDate = datePicker;
                                selectDateLabel = formatDate(selectedDate);
                                // "${daysOfWeek[selectedDate.weekday]}, ${months[selectedDate.month - 1]} ${selectedDate.day}";
                              });
                            }
                          },
                          child: Text(selectDateLabel))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Time",
                          style: textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: themeColor.surfaceDim,
                            shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onPressed: () async {
                            final TimeOfDay? timeOfDay = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (timeOfDay != null) {
                              setState(() {
                                selectedTime = timeOfDay;
                                selectTimeLabel = formatTime(selectedTime);
                                // "${selectedTime.hour}:${selectedTime.minute}";
                              });
                            }
                          },
                          child: Text(selectTimeLabel))
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            CustomBtn(
                label: "Save Task",
                onPressed: () {
                  if (taskLabel.isNotEmpty) {
                    taskState.addTask(
                        label: taskLabel,
                        category: taskCategory,
                        time: selectedTime,
                        date: selectedDate);
                    Navigator.pop(context);
                  } else {
                    debugPrint("Please add Task Label");
                  }
                })
          ],
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  const _CustomTextField({required this.onChanged, required this.hintText});
  final String hintText;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          left: 10,
        ),
        hintText: hintText,
        filled: true,
        fillColor: theme.colorScheme.surfaceDim,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
    );
  }
}
