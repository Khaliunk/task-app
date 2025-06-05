import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/features/tasks/data/datasources/hive_data_store.dart';
import 'package:todo_list/features/tasks/data/model/task.dart';
import 'package:todo_list/features/tasks/repo/task_repo_impl.dart';

final taskBoxProvider = Provider<Box<Task>>(
  (ref) => Hive.box<Task>(HiveDataStore.boxName),
);

final boxServiceProvider = Provider<HiveDataStore>((ref) => HiveDataStore());

final taskListProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final box = ref.watch(taskBoxProvider);
  final boxService = ref.watch(boxServiceProvider);
  return TaskNotifier(box, boxService);
});

class TaskNotifier extends StateNotifier<List<Task>> {
  final Box<Task> box;
  final HiveDataStore boxService;
  TaskNotifier(this.box, this.boxService) : super(box.values.toList());

  Future<void> addTask(Task task) async {
    boxService.addTask(task);
    state = box.values.toList();
    await trySync();
  }

  Future<void> updateTask(Task task) async {
    boxService.updateTask(task);
    state = box.values.toList();
    await trySync();
  }

  Future<void> deleteTask(Task task) async {
    boxService.deleteTask(task);
    state = box.values.toList();
    await trySync();
  }

  Future<void> toggleCompleted(Task task) async {
    task.isCompleted = !task.isCompleted!;
    task.isSynced = false;
    await task.save();
    state = box.values.toList();
    await trySync();
  }

  Future<void> trySync() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity.contains(ConnectivityResult.wifi) ||
        connectivity.contains(ConnectivityResult.mobile)) {
      final firestore = FirebaseFirestore.instance;
      for (var task in box.values) {
        //end idg n shalgaad sync hiih
        if (!task.isSynced!) {
          await firestore.collection('taskApp').add(task.toMap());
          task.isSynced = true;
          await task.save();
        }
      }
      state = box.values.toList();
    }
  }
}
