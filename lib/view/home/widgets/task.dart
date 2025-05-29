import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Task 1'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [const Text('Description of Task 1'), const Text('Date')],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          // Handle delete action
        },
      ),
    );
  }
}
