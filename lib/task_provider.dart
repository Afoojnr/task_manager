import 'package:flutter/material.dart';

class Task {
  String label;
  bool isCompleted;
  DateTime? date;
  TimeOfDay? time;

  Task({required this.label, this.date, this.time, this.isCompleted = false});
}

class Category {
  String icon;
  List<Task> tasks;

  Category({required this.icon, required this.tasks});
}

class TaskState extends ChangeNotifier {
  // final categories = <String, Category>{};

  final Map<String, Category> categories = {
    'School': Category(
      icon: '🎓',
      tasks: [
        Task(label: 'Math Homework', isCompleted: true),
        Task(label: 'Science Project', isCompleted: false),
        Task(label: 'Read Chapter 5', isCompleted: true),
      ],
    ),
    'Design': Category(
      icon: '🎯',
      tasks: [
        Task(label: 'Create Logo', isCompleted: true),
        Task(label: 'Draft Wireframe', isCompleted: true),
        Task(label: 'Review Prototypes', isCompleted: false),
      ],
    ),
    'Sport': Category(
      icon: '⚽️',
      tasks: [
        Task(label: 'Morning Run', isCompleted: true),
        Task(label: 'Team Practice', isCompleted: false),
      ],
    ),
    'Business': Category(
      icon: '💼',
      tasks: [
        Task(label: 'Client Meeting', isCompleted: true),
        Task(label: 'Budget Review', isCompleted: false),
        Task(label: 'Update Presentation', isCompleted: true),
      ],
    ),
  };

  late String currentCategory;
  late List<Task> currentTasks;

  // TODO: Understand this code below better. Initializer class on dart
  TaskState() {
    setCurrentCategory(categories.keys.isNotEmpty ? categories.keys.first : '');
  }

  void setCurrentCategory(String category) {
    currentCategory = category;
    currentTasks = categories[currentCategory]?.tasks ?? [];

    notifyListeners();
  }

  void addCategory({required String category, String icon = "📋"}) {
    categories[category] = Category(icon: icon, tasks: []);
    notifyListeners();
  }

  void addTask(
      {required String category,
      required String label,
      DateTime? date,
      TimeOfDay? time}) {
    categories[category]!
        .tasks
        .add(Task(label: label, isCompleted: false, date: date, time: time));
    notifyListeners();
  }

  void toggleTaskStatus(String label) {
    for (var task in currentTasks) {
      if (task.label == label) {
        task.isCompleted = !task.isCompleted;
      }
    }
    notifyListeners();
  }

  void deletTask(String label) {
    currentTasks.removeWhere((task) => task.label == label);
    notifyListeners();
  }
}
