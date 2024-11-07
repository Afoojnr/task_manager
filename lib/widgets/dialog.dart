import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/task_provider.dart';

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
    final theme = Theme.of(context);
    String category = categoryController.text;
    String icon = iconController.text;

    bool isEmoji(String input) {
      final emojiPattern =
          RegExp(r"^(?:[\u203C-\u3299\uD83C-\uDBFF\uDC00-\uDFFF]+)$");

      return emojiPattern.hasMatch(input);
    }

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

  @override
  void dispose() {
    taskLabelController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    String taskLabel = taskLabelController.text;

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
              height: 12,
            ),
            // TODO: select category
            Text(
              "Label",
              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            _CustomTextField(
                onChanged: (value) => taskLabel = value,
                hintText: "Create Instagram Post"),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text("Start",
                        style: textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold))
                    //TODO: DropDown with date and time picker
                  ],
                )
              ],
            )
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
