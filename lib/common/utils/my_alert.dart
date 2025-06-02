import 'package:flutter/material.dart';

showAlert({required BuildContext context, required String title, required String content,required Function onConfirm}) {
  showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Үгүй')),
      SizedBox(width: 10),
       ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text('Тийм'))    
    ],

  ),
);
}