import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/common/utils/toasts.dart';
import 'package:todo_list/common/utils/utils.dart';

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
    if (isUpdate) {
      widget.titleController?.text = title ?? '';
      widget.subtitleController?.text = subtitle ?? '';

      widget.task?.selectedDate = date!;
      widget.task?.selectedTime = time!;

      widget.task?.save();
      showSuccessToast("Таск амжилттай шинэчлэгдлээ");
      Navigator.pop(context);
    } else {
      if (title != null && subtitle != null) {
        var task = Task.create(
          title: title,
          selectedDate: date,
          selectedTime: time,
          subtitle: subtitle,
        );
        BaseApp.of(context).hiveDataStore.addTask(task);

        showSuccessToast("Таск амжилттай нэмэгдлээ");

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
    return Scaffold(
      appBar: AppBar(
        title:
            widget.task?.title != null
                ? Text(widget.task?.title ?? '')
                : const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
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
            Spacer(),
            Row(
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
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
