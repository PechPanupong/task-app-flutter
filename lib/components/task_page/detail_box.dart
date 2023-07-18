import 'package:app/components/task_page/task_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/task_model.dart';
import '../../style/app_style.dart';

class DetailBox extends StatefulWidget {
  final TaskModel data;

  const DetailBox({
    required this.data,
  });

  @override
  State<DetailBox> createState() => _DetailBoxState();
}

class _DetailBoxState extends State<DetailBox> {
  bool toggleShow = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return TaskDetail(widget.data);
            });

        setState(() {
          toggleShow = !toggleShow;
        });
      },
      child: ListTile(
        title: Text(
          widget.data.title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          widget.data.description,
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
            color: AppStyle.colorByTask(widget.data.status, false),
          ),
          child: Center(
            child: Text(
              widget.data.status,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
