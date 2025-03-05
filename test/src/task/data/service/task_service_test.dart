import 'package:flutter_test/flutter_test.dart';
import 'package:my_task_0/src/task/data/model/task_model.dart';
import 'package:my_task_0/src/task/data/service/task_service.dart';

void main() {
  late TaskService taskService;

  setUp(() {
    taskService = TaskServiceImpl();
  });

  test(' método getList: deve retornar uma List<TaskModel>', () {
    //Arrange

    //Act
    final result = taskService.getList();
    //Assert
    expect(result, isA<List<TaskModel>>());
  });

  test('método createTask: deve returna uma lista com a tarefa criada', () {
    //Arrange
    final task = TaskModel(title: 'teste', description: 'description');
    //Act
    final List<TaskModel> result = taskService.createTask(task: task);
    //Assert
    expect(result, isA<List<TaskModel>>());
    expect(result[0], equals(task));
    expect(result[0].id, equals(0));
  });

  test('método createTask: deve retornar uma lista com 3 tarefas e uma criada',
      () {
    //Arrange
    final task0 = TaskModel(title: 'teste', description: 'description');
    final task1 = TaskModel(title: 'teste', description: 'description');
    final task2 = TaskModel(title: 'teste', description: 'description');
    //Act
    taskService.createTask(task: task0);
    taskService.createTask(task: task1);
    final List<TaskModel> result = taskService.createTask(task: task2);
    //Assert
    expect(result, isA<List<TaskModel>>());
    expect(result[0].id, equals(0));
    expect(result[1].id, equals(1));
    expect(result[2].id, equals(2));
  });

  test(
      'método deleteTask: deve deletar a tarefa na lista que contenha o id fornecido',
      () {
    //Arrange
    final task = TaskModel(id: 0, title: 'title', description: 'description');
    //Act
    taskService.createTask(task: task);
    final List<TaskModel> result = taskService.deleteTask(id: 0);
    //Assert
    expect(result.any((task) => task.id == 0), false);
    expect(result.length, equals(0));
  });

  test(
      'método updateTask, deve retornar uma lista de taskModel com a tarefa atualizada',
      () {
    // Arrange
    final task = TaskModel(title: 'title', description: 'description');
    // Act
    taskService.createTask(task: task);
    final result = taskService.updateTask(
        task: TaskModel(
            id: 0,
            isDone: true,
            title: 'title 2',
            description: 'description 2'));

    // Assert
    expect(result, isA<List<TaskModel>>());
    expect(result[0].title, equals('title 2'));
    expect(result[0].description, equals('description 2'));
    expect(result[0].isDone, equals(true));
  });
}
