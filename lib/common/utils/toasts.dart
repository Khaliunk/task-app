
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

showErrorToast(String message) {
  toastification.show(
  title: Text(message),
  autoCloseDuration: const Duration(seconds: 5),
  type: ToastificationType.error,
);
}

showSuccessToast(String message) {
 toastification.show(
  title: Text(message),
  autoCloseDuration: const Duration(seconds: 5),
  type: ToastificationType.success,
  );  
}

showInfoToast(String message) {
  toastification.show(
  title: Text(message),
  autoCloseDuration: const Duration(seconds: 5),
  type: ToastificationType.info,
  );  
}