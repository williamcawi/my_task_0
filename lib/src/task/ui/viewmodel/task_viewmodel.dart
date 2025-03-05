import 'package:flutter/foundation.dart';
import 'package:my_task_0/src/task/data/repository/task_repository.dart';
import 'package:my_task_0/src/task/ui/viewmodel/task_state.dart';

class TaskViewmodel extends ValueNotifier<TaskState> {
  final TaskRepository _taskRepository;

  TaskViewmodel({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(TaskInitial());

  void getTasksEvent() async {
    value = TaskLoading();
    final either = _taskRepository.getTasks();
    either.fold((message) {
      value = TaskError(message: message);
    }, (tasks) {
      value = TaskSuccess(tasks: tasks);
    });
  }
}
