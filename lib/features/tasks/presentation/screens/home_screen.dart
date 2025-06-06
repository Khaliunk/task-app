import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/features/tasks/presentation/providers/task_provider.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/features/tasks/data/model/task.dart';
import 'package:todo_list/features/tasks/presentation/widgets/task_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskListProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          if (tasks.isNotEmpty) {
            return TaskItem(task: task, ref: ref);
          } else {
            return Container(
              child: Text(
                "Одоогоор таск байхгүй байна",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          }
        },
      ),
    );
  }
}
