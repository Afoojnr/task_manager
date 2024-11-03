import 'package:flutter/foundation.dart';

class Task {
  String label;
  bool isCompleted;

  Task({required this.label, this.isCompleted = false});
}

class Category {
  String icon;
  List<Task>? tasks;

  Category({this.icon = "📋", this.tasks});
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

  TaskState() {
    setCurrentCategory(categories.keys.isNotEmpty ? categories.keys.first : '');
  }

  void setCurrentCategory(String category) {
    currentCategory = category;
    currentTasks = categories[currentCategory]?.tasks ?? [];

    notifyListeners();
  }
}
