import 'package:todo_list/features/tasks/data/datasources/hive_data_store.dart';
import 'package:todo_list/features/tasks/data/datasources/remote_data.dart';
import 'package:todo_list/features/tasks/data/model/task.dart';
import 'package:todo_list/features/tasks/repo/task_repo.dart';

class TaskRepoImpl implements TaskRepo {
  final HiveDataStore local;
  final TaskRemoteDataSource remote;

  TaskRepoImpl({required this.local, required this.remote});

  @override
  Future<void> addTasks(Task task) async {
    await local.addTask(task);
    await syncTasks();
  }

  @override
  Future<void> completeTask(Task task) {
    // TODO: implement completeTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTasks() async {
    return local.getTasks();
  }

  @override
  Future<void> syncTasks() async {
    final unsynced = local.getUnsynced();
    for (var todo in unsynced) {
      await remote.uploadTask(todo);
      await local.markSynced(todo.id);
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    task.isSynced = false;
    await local.updateTask(task);
    await syncTasks();
  }
}
