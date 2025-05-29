import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  final String? title;
  const TaskScreen({super.key, this.title});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            widget.title != null
                ? Text(widget.title!)
                : const Text('Task Details'),
      ),
    );
  }
}
