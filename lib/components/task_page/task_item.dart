import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/task_model.dart';
import '../../style/app_style.dart';
import '../confirm_dialog.dart';
import 'task_detail.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task, required this.onDelete});
  final TaskModel task;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmDialog(
              content: 'Are you sure to delete this task',
              confirm: () {
                onDelete();
              },
            );
          },
        );
      },
      // onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: REdgeInsets.only(right: 32),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return TaskDetail(task);
              });
        },
        child: ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            task.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppStyle.darkSilver,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppStyle.colorByTask(task.status, false),
            ),
            child: Center(
              child: Text(
                task.status,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
