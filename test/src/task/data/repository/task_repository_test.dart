import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_task_0/src/task/data/model/task_model.dart';
import 'package:my_task_0/src/task/data/repository/task_repository.dart';
import 'package:my_task_0/src/task/data/service/task_service.dart';

class MockTaskService extends Mock implements TaskService {}

void main() {
  late MockTaskService mockTaskService;
  late TaskRepository taskRepository;

  setUp(() {
    mockTaskService = MockTaskService();
    taskRepository = TaskRepositoryImpl(taskService: mockTaskService);
  });

  test('método getTasks: deve retornar um Right de lista de TaskModel', () {
    //Arrange
    when(() => mockTaskService.getList()).thenAnswer(
        (_) => [TaskModel(title: 'title', description: 'description')]);
    //Act
    final result = taskRepository.getTasks();

    //Assert
    expect(result, isA<Right<String, List<TaskModel>>>());
  });
}
