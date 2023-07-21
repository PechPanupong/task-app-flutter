import 'package:flutter/material.dart';

class CommonUtil {
  static String mapTaskWording(String type) {
    switch (type) {
      case 'TODO':
        return 'To-do';
      case 'DOING':
        return 'Doing';
      case 'DONE':
        return 'Done';
      default:
        return 'Task';
    }
  }

  showSnackBar(BuildContext context, String? text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text ?? 'Completed'),
      ),
    );
  }
}
