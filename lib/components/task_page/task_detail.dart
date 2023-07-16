import 'package:app/models/task.dart';
import 'package:app/store/app_storage.dart';
import 'package:app/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TaskDetail extends StatelessWidget {
  const TaskDetail(this.taskDetail, {super.key});

  final TaskModel taskDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 90.h / 100.h,
      width: MediaQuery.of(context).size.width,
      padding: REdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: AppStyle.darkSilver,
                  size: 36.0,
                ),
              ),
            ],
          ),
          Container(
            padding: REdgeInsets.symmetric(horizontal: 15),
            child: Text(
              taskDetail.title,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Container(
                  padding: REdgeInsets.only(
                      left: 15, right: 15, bottom: 15, top: 30),
                  child: Text(
                    taskDetail.description,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
