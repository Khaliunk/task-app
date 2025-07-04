import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/features/tasks/presentation/providers/task_provider.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/features/tasks/data/model/task.dart';
import 'package:todo_list/core/utils/toasts.dart';
import 'package:todo_list/core/utils/utils.dart';
import 'package:todo_list/features/tasks/presentation/providers/connectivity_listener.dart';

class TaskScreen extends ConsumerStatefulWidget {
  final Task? task;
  final TextEditingController? titleController;
  final TextEditingController? subtitleController;
  const TaskScreen({
    super.key,
    this.task,
    this.titleController,
    this.subtitleController,
  });

  @override
  TaskScreenState createState() => TaskScreenState();
}

class TaskScreenState extends ConsumerState<TaskScreen> {
  String? title;
  String? subtitle;
  DateTime? date;
  DateTime? time;
  bool isUpdate = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.task != null) {
      title = widget.task?.title;
      subtitle = widget.task?.subtitle;
      date = widget.task?.selectedDate;
      time = widget.task?.selectedTime;
      isUpdate = true;
    } else {
      title = widget.titleController?.text;
      subtitle = widget.subtitleController?.text;
      isUpdate = false;
    }
  }

  void updateTask() async {
    setState(() {
      isLoading = true;
    });
    if (isUpdate) {
      final task = widget.task!;

      widget.titleController?.text = title ?? '';
      widget.subtitleController?.text = subtitle ?? '';

      task.title = title ?? "";
      task.subtitle = subtitle ?? "";
      task.selectedDate = date!;
      task.selectedTime = time!;
      task.isSynced = false;

      await ref.read(taskListProvider.notifier).updateTask(task);
      setState(() {
        isLoading = false;
      });
      showSuccessToast("Таск амжилттай шинэчлэгдлээ");
      if (!mounted) return;
      Navigator.pop(context);
    } else {
      if (title != null && subtitle != null) {
        var task = Task.create(
          title: title,
          selectedDate: date,
          selectedTime: time,
          subtitle: subtitle,
        );

        await ref.read(taskListProvider.notifier).addTask(task);
        setState(() {
          isLoading = false;
        });
        showSuccessToast("Таск амжилттай нэмэгдлээ");
        if (!mounted) return;
        Navigator.pop(context);
      } else {
        showErrorToast("Таскийн нэр болон тайлбар хоосон байна");
        return;
      }
    }
  }

  dynamic deleteTask() {
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title:
                widget.task?.title != null
                    ? Text(widget.task?.title ?? '')
                    : const Text('Task Details'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Өнөөдрийн төлөвлөгөө чинь юу вэ?",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: widget.titleController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        labelText: "Таскийн нэр",
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        title = value;
                      },
                      onSubmitted: (value) {
                        title = value;
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: widget.subtitleController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        labelText: "Таскийн тайлбар",
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        subtitle = value;
                      },
                      onSubmitted: (value) {
                        subtitle = value;
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                  ),

                  SizedBox(height: 20),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(2030, 3, 5),
                            onConfirm: (selectedTime) {
                              setState(() {
                                if (widget.task?.selectedDate == null) {
                                  date = selectedTime;
                                } else {
                                  widget.task!.selectedDate = selectedTime;
                                }
                              });

                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.mn,
                          );
                        },
                        child: Text(
                          (date ?? widget.task?.selectedDate) != null
                              ? dateFormat(date ?? widget.task!.selectedDate)
                              : "Өдөр сонгох",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          DatePicker.showTimePicker(
                            context,
                            showTitleActions: true,
                            showSecondsColumn: false,
                            onChanged: (_) {},
                            onConfirm: (selectedTime) {
                              setState(() {
                                if (widget.task?.selectedTime == null) {
                                  time = selectedTime;
                                } else {
                                  widget.task!.selectedTime = selectedTime;
                                }
                              });

                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.mn,
                          );
                        },
                        child: Text(
                          (time ?? widget.task?.selectedTime) != null
                              ? (time ?? widget.task!.selectedTime)
                                  .toString()
                                  .substring(11, 16)
                              : "Цаг сонгох",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isUpdate
                    ? ElevatedButton(
                      onPressed: () {
                        deleteTask();
                        Navigator.pop(context);
                      },
                      child: const Text('Таск устгах'),
                    )
                    : SizedBox(),
                ElevatedButton(
                  child: Text(isUpdate ? 'Таск шинэчлэх' : "Таск нэмэх"),
                  onPressed: () {
                    updateTask();
                  },
                ),
              ],
            ),
          ),
        ),

        if (isLoading) // <-- true үед loader харуулна
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
      ],
    );
  }
}
