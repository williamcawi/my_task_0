import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:my_task_0/app.dart';
import 'package:my_task_0/src/task/data/repository/task_repository.dart';
import 'package:my_task_0/src/task/data/service/task_service.dart';
import 'package:my_task_0/src/task/ui/viewmodel/task_viewmodel.dart';

void main() {
  final Client client = Client();
  final taskService = TaskServiceImpl(client: client);
  final taskRepository = TaskRepositoryImpl(taskService: taskService);
  final taskViewmodel = TaskViewmodel(taskRepository: taskRepository);
  runApp(App(
    taskViewmodel: taskViewmodel,
  ));
}
