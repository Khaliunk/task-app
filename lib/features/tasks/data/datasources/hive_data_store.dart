import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/features/tasks/data/model/task.dart';

class HiveDataStore {
  static const String boxName = 'tasksBox';

  final Box<Task> box = Hive.box<Task>(boxName);

  Future<void> addTask(Task task) async {
    await box.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    await task.save();
  }

  Future<void> deleteTask(Task task) async {
    await task.delete();
  }

  List<Task> getTasks() => box.values.toList();

  Future<void> markSynced(String id) async {
    final todo = box.get(id);
    if (todo != null) {
      todo.isSynced = true;
      await todo.save();
    }
  }

  List<Task> getUnsynced() =>
      box.values.where((todo) => !todo.isSynced!).toList();
}
