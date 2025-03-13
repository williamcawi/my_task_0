import 'package:flutter/foundation.dart';
import 'package:my_task_0/src/task/data/model/task_model.dart';
import 'package:my_task_0/src/task/data/repository/task_repository.dart';
import 'package:my_task_0/src/task/ui/viewmodel/task_state.dart';

class TaskViewmodel extends ValueNotifier<TaskState> {
  final TaskRepository _taskRepository;

  TaskViewmodel({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(TaskInitial());

  void getTasksEvent() async {
    value = TaskLoading();
    final either = await _taskRepository.getTasks();
    either.fold((message) {
      value = TaskError(message: message);
    }, (tasks) {
      value = TaskSuccess(tasks: tasks);
    });
  }

  void createTaskEvent({required TaskModel task}) async {
    value = TaskLoading();
    final either = await _taskRepository.createTasks(task: task);
    either.fold((message) {
      value = TaskError(message: message);
    }, (tasks) {
      value = TaskSuccess(tasks: tasks);
    });
  }

  void updateTaskEvent({required TaskModel task}) async {
    value = TaskLoading();
    final either = await _taskRepository.updateTasks(task: task);
    either.fold((message) {
      value = TaskError(message: message);
    }, (tasks) {
      value = TaskSuccess(tasks: tasks);
    });
  }

  void deleteTaskEvent({required int id}) async {
    value = TaskLoading();
    final either = await _taskRepository.deleteTasks(id: id);
    either.fold((message) {
      value = TaskError(message: message);
    }, (tasks) {
      value = TaskSuccess(tasks: tasks);
    });
  }
}
