import 'package:fpdart/fpdart.dart';
import 'package:my_task_0/src/task/data/model/task_model.dart';
import 'package:my_task_0/src/task/data/service/task_service.dart';

abstract interface class TaskRepository {
  Either<String, List<TaskModel>> getTasks();
  Either<String, List<TaskModel>> createTasks({required TaskModel task});
  Either<String, List<TaskModel>> updateTasks({required TaskModel task});
  Either<String, List<TaskModel>> deleteTasks({required int id});
}

class TaskRepositoryImpl extends TaskRepository {
  final TaskService _taskService;

  TaskRepositoryImpl({required TaskService taskService})
      : _taskService = taskService;

  @override
  Either<String, List<TaskModel>> createTasks({required TaskModel task}) {
    try {
      return Right(_taskService.createTask(task: task));
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Either<String, List<TaskModel>> deleteTasks({required int id}) {
    try {
      return Right(_taskService.deleteTask(id: id));
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Either<String, List<TaskModel>> getTasks() {
    try {
      return Right(_taskService.getList());
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Either<String, List<TaskModel>> updateTasks({required TaskModel task}) {
    try {
      return Right(_taskService.updateTask(task: task));
    } catch (error) {
      return left(error.toString());
    }
  }
}
