import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/models/task.dart';

class TaskService {
  final taskCollection = FirebaseFirestore.instance.collection('taskApp');


  void addTask(Task taskData) {
    taskCollection.add(taskData.toMap()).then((value) {
      print("Task Added");
    }).catchError((error) {
      print("Failed to add task: $error");
    });
  }
  void updateTask(String taskId, Task taskData) {
    taskCollection.doc(taskId).update(taskData.toMap()).then((value) {
      print("Task Updated");
    }).catchError((error) {
      print("Failed to update task: $error");
    });
  }
  void deleteTask(String taskId) {
    taskCollection.doc(taskId).delete().then((value) {
      print("Task Deleted");
    }).catchError((error) {
      print("Failed to delete task: $error");
    });
  }
  Stream<QuerySnapshot> getTasks() {
    return taskCollection.snapshots();
  }
}