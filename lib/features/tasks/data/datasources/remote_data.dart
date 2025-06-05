import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/features/tasks/data/model/task.dart';

class TaskRemoteDataSource {
  final FirebaseFirestore firestore;

  TaskRemoteDataSource(this.firestore);

  Future<void> uploadTask(Task task) async {
    await firestore.collection('taskApp').add(task.toMap());
  }

  void updateTask(String taskId, Task taskData) {
    firestore
        .collection('taskApp')
        .doc(taskId)
        .update(taskData.toMap())
        .then((value) {
          print("Task Updated");
        })
        .catchError((error) {
          print("Failed to update task: $error");
        });
  }

  void deleteTask(String taskId) {
    firestore
        .collection('taskApp')
        .doc(taskId)
        .delete()
        .then((value) {
          print("Task Deleted");
        })
        .catchError((error) {
          print("Failed to delete task: $error");
        });
  }
}
