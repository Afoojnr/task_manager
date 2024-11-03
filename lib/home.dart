import 'package:flutter/material.dart';
import 'package:task_manager/task_provider.dart';
import 'package:task_manager/widgets/button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            Expanded(child: const TaskListView()),
            const SizedBox(
              height: 10,
            ),
            CustomBtn(
                label: "Add a new task",
                hasIcon: true,
                onPressed: () {
                  debugPrint("Add Task");
                }),
            const SizedBox(
              height: 16,
            ),
            // CustomBtn(
            //     label: "Save Task",
            //     onPressed: () {
            //       debugPrint("Saved Task");
            //     })
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
    final categories = context.watch<TaskState>().categories;

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
                                onPressed: () {}),
                            const SizedBox(
                              width: 12,
                            )
                          ],
                        );
                      }),
                      _CustomIconBtn(
                          icon: "+", label: "Add More", onPressed: () {}),
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
    final currentCategory = context.watch<TaskState>().currentCategory;
    final currentTasks = context.watch<TaskState>().currentTasks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$currentCategory's Tasks",
            style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
        SizedBox(
          height: 12,
        ),
        Expanded(
          child: ListView(
            children: [
              ...currentTasks.map((task) => _TaskListTile(
                    label: task.label,
                    isCompleted: task.isCompleted,
                  ))
            ],
          ),
        ),
        //       ListView(
        //         children: [

        // ...categories.values.first.tasks.map((task) {
        //   return _TaskListTile();
        // })
        //         ],
        //       )
        // _TaskListTile()
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
    return Column(
      children: [
        TextButton(
            style: TextButton.styleFrom(
              fixedSize: const Size(60, 50),
              backgroundColor: const Color.fromARGB(255, 206, 234, 245),
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
  const _TaskListTile({required this.label, this.isCompleted = false});
  final String label;
  final bool isCompleted;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: isCompleted,
      onChanged: (_) {},
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(label),
      subtitle: Text("Nov 7 (8 am to 7pm)"),
    );
  }
}
