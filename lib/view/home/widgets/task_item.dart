import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/common/utils/my_alert.dart';
import 'package:todo_list/common/utils/toasts.dart';
import 'package:todo_list/common/utils/utils.dart';
import 'package:todo_list/view/tasks/task_screen.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
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
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.title),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>TaskScreen(
          titleController: titleController,
          subtitleController: subtitleController,
          task: widget.task,
        )));
      },
      leading: Checkbox(
        value: widget.task.isCompleted,
        onChanged: (bool? value) {
          widget.task.isCompleted = value ?? false;
          widget.task.save();
          setState(() {});
        },
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ Text(widget.task.subtitle), 
         Text('Хугацаа: ${dateFormat( widget.task.selectedDate)} ${(widget.task.selectedTime).toString().substring(11, 16)}') ],
          
        
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          
          showAlert(
           context:  context,
          title:  "Устгах",
          content:  "Та энэ таскийг устгах гэж байна",
            onConfirm: ()async {
              await widget.task.delete();
              showSuccessToast("Таск амжилттай устгагдлаа");
            },
          );
          
        },
      ),
    );
  }
}
