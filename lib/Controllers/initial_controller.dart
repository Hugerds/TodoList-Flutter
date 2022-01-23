import 'package:flutter/cupertino.dart';
import 'package:todo_list/Helpers/constants_helper.dart';
import 'package:todo_list/Models/task_model.dart';
import 'package:todo_list/Services/task_service.dart';

class InitialController extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  ValueNotifier<List<Task>> listaTasks = ValueNotifier([]);
  TextEditingController taskTitleController = TextEditingController();
  String token = Constants.token;
  InitialController() {
    getTasks();
  }
  void ordenaListaByCompleted() {
    listaTasks.value.sort((a, b) => a.completed ? 1 : -1);
  }

  Future getTasks() async {
    List<Task>? list = await _taskService.getTasks(token);
    if (list == null) return;
    listaTasks.value = List.from(listaTasks.value)..addAll(list);
  }

  Future createTask() async {
    Task? task = await _taskService.createTask(taskTitleController.text, token);
    if (task == null) return;
    listaTasks.value = List.from(listaTasks.value)..add(task);
  }

  Future updateTask(int index) async {
    Task? task =
        await _taskService.updateCompleteTask(listaTasks.value[index], token);
    if (task == null) return;
    listaTasks.value[index] = task;
    listaTasks.notifyListeners();
  }

  Future deleteTask(String id) async {
    bool deletedTask = await _taskService.deleteTask(id, token);
    if (!deletedTask) return;
    listaTasks.value
        .remove(listaTasks.value.firstWhere((element) => element.id == id));
    listaTasks.notifyListeners();
  }
}
