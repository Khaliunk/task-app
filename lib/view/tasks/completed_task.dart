import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/view/home/widgets/task_item.dart';

class CompletedTask extends StatelessWidget {
  const CompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    final base = BaseApp.of(context);
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: base.hiveDataStore.getTaskListenable(),
        builder: (context, Box<Task> box, child) {
          var tasks = box.values.toList();
          var completedList = tasks.where((test) => test.isCompleted == true).toList();
          
          if (completedList.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Таньд дуусгасан таск байхгүй байна...',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            );
          }else{

          return ListView.builder(
            itemCount: completedList.length,
            itemBuilder: (context, index) {
              final task = completedList[index];
              return TaskItem(task: task);
            },
          );
          }
        },
      ),
    );
  }
}