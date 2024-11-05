import 'package:flutter/material.dart';
import 'package:task_manager/home.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/task_provider.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskState(),
      child: MaterialApp(
          home: const HomePage(),
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 5, 90, 236),
                surfaceDim: const Color.fromARGB(255, 206, 234, 245)),
            // colorSchemeSeed: const Color.fromARGB(255, 5, 90, 236),
          )),
    );
  }
}
