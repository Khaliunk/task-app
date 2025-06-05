import 'package:todo_list/features/tasks/data/model/task.dart';

abstract class TaskRepo {
  Future<List<Task>> getTasks();
  Future<void> addTasks(Task task);
  Future<void> completeTask(Task task);
  Future<void> syncTasks();
  Future<void> updateTask(Task task);
}
