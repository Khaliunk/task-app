import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/features/tasks/data/model/task.dart';
import 'package:todo_list/core/utils/my_alert.dart';
import 'package:todo_list/core/utils/toasts.dart';
import 'package:todo_list/core/utils/utils.dart';
import 'package:todo_list/features/tasks/presentation/providers/task_provider.dart';
import 'package:todo_list/features/tasks/presentation/screens/task_screen.dart';

class TaskItem extends ConsumerStatefulWidget {
  final Task task;
  final WidgetRef ref;
  const TaskItem({super.key, required this.task, required this.ref});

  @override
  ConsumerState<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends ConsumerState<TaskItem> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.task.title;
    subtitleController.text = widget.task.subtitle;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    subtitleController.dispose();
  }

  deleteTask() async {
    await ref.read(taskListProvider.notifier).deleteTask(widget.task);
    showSuccessToast("Таск амжилттай устгагдлаа");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          title: Text(
            widget.task.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => TaskScreen(
                      titleController: titleController,
                      subtitleController: subtitleController,
                      task: widget.task,
                    ),
              ),
            );
          },
          leading: Checkbox(
            value: widget.task.isCompleted,
            onChanged: (bool? value) {
              widget.ref
                  .read(taskListProvider.notifier)
                  .toggleCompleted(widget.task);
            },
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.task.subtitle),
              Text(
                'Хугацаа: ${dateFormat(widget.task.selectedDate)} ${(widget.task.selectedTime).toString().substring(11, 16)}',
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showAlert(
                context: context,
                title: "Устгах",
                content: "Та энэ таскийг устгах гэж байна",
                onConfirm: () async {
                  deleteTask();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
