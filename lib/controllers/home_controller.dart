import 'package:flutter/material.dart';
import 'package:flutter_todo_list/helpers.dart';
import 'package:flutter_todo_list/todo_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController {
  final description = TextEditingController();

  final toDoList = <TodoModel>[].obs;
  final results = <TodoModel>[].obs;
  final showOnlyNotDone = false.obs;
  final searchText = "".obs;
  final doneText = "".obs;
  final box = Hive.box("todos");

  @override
  void onInit() {
    for (final value in box.values) {
      final todo = TodoModel.fromJson(value);
      toDoList.add(todo);
    }
    super.onInit();
  }

  @override
  void onClose() {
    description.dispose();
    super.onClose();
  }

  void addTask() {
    final key = Helpers.generateNonce();

    final modelToDo = TodoModel(
      id: key,
      description: description.text,
      isDone: false,
    );

    toDoList.add(modelToDo);
    description.clear();
    toDoList.refresh();

    final value = modelToDo.toJson();
    box.put(key, value);
  }

  void deleteTodo(String key) {
    toDoList.removeWhere((e) => e.id == key);
    box.delete(key);
  }
}
