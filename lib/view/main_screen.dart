import 'package:flutter/material.dart';
import 'package:todo_list/common/utils/toasts.dart';
import 'package:todo_list/common/utils/utils.dart';
import 'package:todo_list/view/home/home_screen.dart';
import 'package:todo_list/view/tasks/completed_task.dart';
import 'package:todo_list/view/tasks/task_screen.dart';
import 'package:todo_list/view/tasks/uncompleted_tasks.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
     HomeScreen(),
     CompletedTask(),
     UnCompletedTask()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
  }
Future<void> someAction() async {
  bool isConnected = await checkInternetConnection();
  if (!isConnected) {
    showErrorToast('Интернет холболт алга байна. Дахин оролдоно уу.');
    return;
  }
  // Proceed with network request or other logic
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: _screens.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Бүх Таск'),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Дууссан Таск',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.indeterminate_check_box),
            label: 'Дуусгаагүй Таск',
          ),
        ],
        currentIndex: _selectedIndex,

        onTap: _onItemTapped,
      ),
    );
  }
}
