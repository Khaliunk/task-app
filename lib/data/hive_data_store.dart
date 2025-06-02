
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/models/task.dart';

class HiveDataStore {

  static const String _boxName = 'tasksBox';

  final Box<Task> box = Hive.box<Task>(_boxName);
  
  Future<void> addTask(Task task) async {
    await box.put(task.id, task);
  }
  Future<void> updateTask(Task task) async {
    await task.save();
  }
  Future<void> deleteTask(Task task) async {
    await task.delete();
  }

  Future<Task?> getTask(int index) async {
    return box.get(index);
  }

  ValueListenable<Box<Task>> getTaskListenable() {
    return box.listenable();
  }
}