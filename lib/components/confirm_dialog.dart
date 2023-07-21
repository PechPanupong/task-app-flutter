import 'package:app/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog(
      {super.key,
      this.title = 'Confirmation',
      this.content = 'Are you sure to continue?',
      this.confirm});

  final Function? confirm;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(
        content,
        style: TextStyle(
            fontSize: 20.sp,
            color: AppStyle.darkSilver,
            fontWeight: FontWeight.w500),
      ),
      actionsPadding: REdgeInsets.only(bottom: 10, right: 25),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Close the dialog
          },
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
        TextButton(
          onPressed: () {
            confirm!(); // Perform the desired action
            Navigator.of(context).pop(true); // Close the dialog
          },
          child: Text(
            'Confirm',
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
      ],
    );
  }
}
