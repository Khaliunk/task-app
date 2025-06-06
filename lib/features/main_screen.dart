import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/core/utils/toasts.dart';
import 'package:todo_list/core/utils/utils.dart';
import 'package:todo_list/features/tasks/presentation/providers/connectivity_listener.dart';
import 'package:todo_list/features/tasks/presentation/providers/task_provider.dart';
import 'package:todo_list/features/tasks/presentation/screens/home_screen.dart';
import 'package:todo_list/features/tasks/presentation/screens/completed_task.dart';
import 'package:todo_list/features/tasks/presentation/screens/task_screen.dart';
import 'package:todo_list/features/tasks/presentation/screens/uncompleted_tasks.dart';
import 'package:todo_list/main.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CompletedTask(),
    UnCompletedTask(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Connectivity().checkConnectivity().then((status) {
      if (status.contains(ConnectivityResult.none)) {
        showInfoToast("Оффлайн байна");
      } else {
        showInfoToast("Интернэт холбогдсон байна");

        ref.read(taskListProvider.notifier).trySync();
      }
    });
    monitorConnection(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/home_bg.jpg', fit: BoxFit.cover),
        ),
        Positioned.fill(child: Container(color: Colors.white.withOpacity(0.5))),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.transparent),
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
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Бүх Таск',
              ),
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
        ),
      ],
    );
  }
}
