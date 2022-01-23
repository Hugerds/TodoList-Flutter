import 'package:dio/dio.dart';
import 'package:todo_list/Helpers/constants_helper.dart';
import 'package:todo_list/Models/task_model.dart';

class TaskService {
  late Dio _dio;
  final baseURL = Constants.baseUrl;
  TaskService() {
    _dio = Dio();
  }

  Future<List<Task>?> getTasks(String token) async {
    try {
      Response response = await _dio.get(baseURL + "/task",
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      if (response.data == null) throw Exception();
      List<Task> listTask =
          (response.data as List).map((x) => Task.fromJson(x)).toList();
      return listTask;
    } catch (e) {
      return null;
    }
  }

  Future<Task?> createTask(String taskTitle, String token) async {
    try {
      Map<String, dynamic> body = {
        "title": taskTitle,
        "completed": false,
        "userId": "cbadfd41-25cd-4b52-b8ee-d44a0b951ca7"
      };
      Response response = await _dio.post(baseURL + "/task",
          data: body,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      if (response.data == null) throw Exception();
      Task task = Task.fromJson(response.data);
      return task;
    } catch (e) {
      return null;
    }
  }

  Future<Task?> updateCompleteTask(Task _task, String token) async {
    try {
      Map<String, dynamic> body = {"id": _task.id, "completed": true};
      Response response = await _dio.post(baseURL + "/task/completeTask",
          data: body,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      if (response.data == null) throw Exception();
      Task task = Task.fromJson(response.data);
      return task;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTask(String id, String token) async {
    try {
      Response response = await _dio.delete(baseURL + "/task/$id",
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      if (response.data == null) throw Exception();
      return true;
    } catch (e) {
      return false;
    }
  }
}
