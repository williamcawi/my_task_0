import 'package:flutter/material.dart';
import 'package:my_task_0/src/task/ui/view/task_page.dart';
import 'package:my_task_0/src/task/ui/viewmodel/task_viewmodel.dart';

class App extends StatelessWidget {
  final TaskViewmodel taskViewmodel;
  const App({required this.taskViewmodel, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskPage(
        taskViewmodel: taskViewmodel,
      ),
    );
  }
}
