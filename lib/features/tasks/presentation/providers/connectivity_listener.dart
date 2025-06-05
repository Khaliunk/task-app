import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/core/utils/toasts.dart';
import 'package:todo_list/features/tasks/presentation/providers/task_provider.dart';

void monitorConnection(WidgetRef ref) {
  Connectivity().onConnectivityChanged.listen((status) async {
    if (status.contains(ConnectivityResult.none)) {
      showInfoToast("Offline mode");
    } else {
      showInfoToast("Синк хийж байна...");

      // Sync хийх provider-г дуудаж байна
      await ref.read(taskListProvider.notifier).trySync();
    }
  });
}

Future<void> checkCurrentConnectivity() async {
  final status = await Connectivity().checkConnectivity();

  if (status.contains(ConnectivityResult.none)) {
    print('Оффлайн байна');
  } else {
    print('Интернэттэй байна');
  }
}
