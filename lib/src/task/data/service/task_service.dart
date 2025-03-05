import 'package:my_task_0/src/task/data/model/task_model.dart';

abstract class TaskService {
  List<TaskModel> getList();
  List<TaskModel> createTask({required TaskModel task});
  List<TaskModel> updateTask({required TaskModel task});
  List<TaskModel> deleteTask({required int id});
}

class TaskServiceImpl extends TaskService {
  List<TaskModel> myList = [];

  @override
  List<TaskModel> createTask({required TaskModel task}) {
    int leng = myList.length;
    task.id = leng;
    myList.add(task);
    return myList;
  }

  @override
  List<TaskModel> deleteTask({required int id}) {
    myList.removeWhere((task) => task.id == id);
    return myList;
  }

  @override
  List<TaskModel> getList() {
    return myList;
  }

  @override
  List<TaskModel> updateTask({required TaskModel task}) {
    final int index = myList.indexWhere((t) => t.id == task.id);
    myList.removeAt(index);
    myList.insert(index, task);

    return myList;
  }
}
