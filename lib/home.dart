import 'package:flutter/material.dart';
import 'package:task_manager/task_provider.dart';
import 'package:task_manager/utils.dart';
import 'package:task_manager/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/widgets/dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> showAddTaskDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AddTaskDialog();
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(
              height: 30,
            ),
            const Categories(),
            const SizedBox(
              height: 10,
            ),
            const Expanded(child: TaskListView()),
            const SizedBox(
              height: 10,
            ),
            CustomBtn(
                label: "Add a new task",
                hasIcon: true,
                onPressed: () => showAddTaskDialog(context)),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hey there, Afolabi",
          style: textTheme.headlineMedium,
        ),
        Text(
          "Organize your plans for the day",
          style: textTheme.bodyLarge,
        )
      ],
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final taskState = context.watch<TaskState>();
    final categories = taskState.categories;

    Future<void> showAddCategoryDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AddCategoryDialog();
          });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Categories",
            style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...categories.entries.map((category) {
                        return Row(
                          children: [
                            _CustomIconBtn(
                                icon: category.value.icon,
                                label: category.key,
                                onPressed: () {
                                  taskState.setCurrentCategory(category.key);
                                }),
                            const SizedBox(
                              width: 12,
                            )
                          ],
                        );
                      }),
                      _CustomIconBtn(
                          icon: "+",
                          label: "Add More",
                          onPressed: () {
                            showAddCategoryDialog(context);
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final taskState = context.watch<TaskState>();
    final currentCategory = taskState.currentCategory;
    final currentTasks = taskState.currentTasks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            currentCategory.isEmpty
                ? "Please Add Category"
                : "$currentCategory's Tasks",
            style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: ListView(
            children: [
              if (currentTasks.isEmpty) const Text('No Tasks Available'),
              ...currentTasks.map((task) => Column(
                    children: [
                      _TaskListTile(
                        label: task.label,
                        isCompleted: task.isCompleted,
                        date: task.date,
                        time: task.time,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

class _CustomIconBtn extends StatelessWidget {
  const _CustomIconBtn(
      {required this.icon, required this.label, required this.onPressed});
  final String icon;
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        TextButton(
            style: TextButton.styleFrom(
              fixedSize: const Size(60, 50),
              backgroundColor: colorTheme.surfaceDim,
            ),
            onPressed: onPressed,
            child: Text(
              icon,
              style: textTheme.headlineSmall,
            )),
        const SizedBox(
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}

// how to extend the Task class created
class _TaskListTile extends StatelessWidget {
  const _TaskListTile(
      {required this.label,
      this.isCompleted = false,
      required this.date,
      required this.time});
  final String label;
  final bool isCompleted;
  final DateTime? date;
  final TimeOfDay? time;
  @override
  Widget build(BuildContext context) {
    final taskState = context.watch<TaskState>();

    final colorTheme = Theme.of(context).colorScheme;
    return CheckboxListTile(
      value: isCompleted,
      tileColor: colorTheme.surfaceDim,
      secondary: IconButton(
          onPressed: () {
            taskState.deletTask(label);
          },
          icon: const Icon(
            Icons.delete_forever_rounded,
            color: Color.fromARGB(255, 160, 18, 8),
          )),
      onChanged: (_) {
        taskState.toggleTaskStatus(label);
      },
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        label,
        style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null),
      ),
      subtitle: Text(
        "${formatDate(date ?? DateTime.now())}  (${formatTime(time ?? TimeOfDay.now())})",
        style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null),
      ),
    );
  }
}
