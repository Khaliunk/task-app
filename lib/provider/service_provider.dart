import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/services/task_service.dart';

final serviceProvider = StateProvider<TaskService>((ref) {
  return TaskService();
});
