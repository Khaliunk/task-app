import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/features/tasks/presentation/providers/task_provider.dart';
import 'package:todo_list/features/tasks/presentation/widgets/task_item.dart';

class UnCompletedTask extends ConsumerWidget {
  const UnCompletedTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListProvider);
    var unCompletedList =
        tasks.where((test) => test.isCompleted == false).toList();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemCount: unCompletedList.length,
        itemBuilder: (context, index) {
          final task = unCompletedList[index];
          return TaskItem(task: task, ref: ref);
        },
      ),
    );
  }
}
