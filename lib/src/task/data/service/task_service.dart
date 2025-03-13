import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_task_0/src/task/data/model/task_model.dart';

abstract class TaskService {
  Future<List<Map<String, dynamic>>> getTasks();
  Future<List<Map<String, dynamic>>> createTask({required TaskModel task});
  Future<List<Map<String, dynamic>>> updateTask({required TaskModel task});
  Future<List<Map<String, dynamic>>> deleteTask({required int id});
}

class TaskServiceImpl extends TaskService {
  TaskServiceImpl({required Client client}) : _client = client;

  final Client _client;

  @override
  Future<List<Map<String, dynamic>>> createTask(
      {required TaskModel task}) async {
    final response = await _client.post(
        Uri.parse('http://10.0.2.2:8080/task/createTask'),
        body: {'title': task.title, 'description': task.description});

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(
          jsonDecode(response.body)['result']);
    } else {
      throw jsonDecode(response.body)['error'] as String;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> deleteTask({required int id}) async {
    final Response response = await _client.post(
        Uri.parse('http://10.0.2.2:8080/task/deleteTask'),
        body: {'id': id});

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(
          jsonDecode(response.body)['result']);
    } else {
      throw jsonDecode(response.body)['error'] as String;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getTasks() async {
    final response =
        await _client.post(Uri.parse('http://10.0.2.2:8080/task/getTasks'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(
          jsonDecode(response.body)['result']);
    } else {
      throw jsonDecode(response.body)['error'] as String;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> updateTask(
      {required TaskModel task}) async {
    final response = await _client
        .post(Uri.parse('http://10.0.2.2:8080/task/updateTask'), body: {
      'id': task.id,
      'title': task.title,
      'description': task.description,
      'isDone': task.isDone
    });

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(
          jsonDecode(response.body)['result']);
    } else {
      throw jsonDecode(response.body)['error'] as String;
    }
  }
}
