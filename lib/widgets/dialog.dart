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
          TextField(
            onChanged: (value) => category = value,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: 10,
              ),
              hintText: 'Enter category',
              filled: true,
              fillColor: theme.colorScheme.surfaceDim,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text("Icon"),
          const SizedBox(
            height: 4,
          ),
          TextField(
            onChanged: (value) => icon = value,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: 16,
              ),
              hintText: 'Icon should be emoji',
              filled: true,
              fillColor: theme.colorScheme.surfaceDim,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
          ),
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
