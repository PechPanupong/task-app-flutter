import 'package:app/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key, this.confirm});

  final Function? confirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Confirmation',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(
        'Are you sure to delete this task',
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
            Navigator.of(context).pop(true); // Close the dialog
            // confirm!(); // Perform the desired action
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
