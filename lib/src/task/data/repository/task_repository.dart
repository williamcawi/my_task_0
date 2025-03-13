import 'package:fpdart/fpdart.dart';
import 'package:my_task_0/src/task/data/model/task_model.dart';
import 'package:my_task_0/src/task/data/service/task_service.dart';

abstract interface class TaskRepository {
  Future<Either<String, List<TaskModel>>> getTasks();
  Future<Either<String, List<TaskModel>>> createTasks(
      {required TaskModel task});
  Future<Either<String, List<TaskModel>>> updateTasks(
      {required TaskModel task});
  Future<Either<String, List<TaskModel>>> deleteTasks({required int id});
}

class TaskRepositoryImpl extends TaskRepository {
  final TaskService _taskService;

  TaskRepositoryImpl({required TaskService taskService})
      : _taskService = taskService;

  @override
  Future<Either<String, List<TaskModel>>> createTasks(
      {required TaskModel task}) async {
    try {
      final listMap = await _taskService.createTask(task: task);

      final listTasks = listMap.map((map) => TaskModel.fromMap(map)).toList();

      return Right(listTasks);
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> deleteTasks({required int id}) async {
    try {
      final listMap = await _taskService.deleteTask(id: id);

      final listTasks = listMap.map((map) => TaskModel.fromMap(map)).toList();

      return Right(listTasks);
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> getTasks() async {
    try {
      final listMap = await _taskService.getTasks();

      final listTasks = listMap.map((map) => TaskModel.fromMap(map)).toList();

      return Right(listTasks);
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> updateTasks(
      {required TaskModel task}) async {
    try {
      final listMap = await _taskService.updateTask(task: task);

      final listTasks = listMap.map((map) => TaskModel.fromMap(map)).toList();
      return Right(listTasks);
    } catch (error) {
      return left(error.toString());
    }
  }
}
