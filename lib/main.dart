import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_list/data/hive_data_store.dart';
import 'package:todo_list/firebase_options.dart';
import 'package:todo_list/models/task.dart';

import 'package:todo_list/view/main_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  var box = await Hive.openBox<Task>('tasksBox');
  await box.clear();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(BaseApp(child: const MyApp()));
}

class BaseApp extends InheritedWidget {
   BaseApp({
    Key ? key,
    required this.child,
  }) : super(key: key, child: child);
  final Widget child;
  final HiveDataStore hiveDataStore = HiveDataStore();
  static BaseApp of(BuildContext context) {
    final BaseApp? result = context.dependOnInheritedWidgetOfExactType<BaseApp>();
    assert(result != null, 'No BaseApp found in context');
    return result!;
  }
  
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: MainScreen(),
      ),
    );
  }
}
