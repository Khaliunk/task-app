import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/features/tasks/presentation/providers/task_provider.dart';
import 'package:todo_list/features/tasks/presentation/widgets/task_item.dart';

class CompletedTask extends ConsumerWidget {
  const CompletedTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListProvider);
    var completedList =
        tasks.where((test) => test.isCompleted == true).toList();
    return Scaffold(
      body: ListView.builder(
        itemCount: completedList.length,
        itemBuilder: (context, index) {
          final task = completedList[index];
          return TaskItem(task: task, ref: ref);
        },
      ),
    );
  }
}
