import 'package:app/pages/change_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/app_style.dart';
import 'task_tab_bar.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this.tabController,
      {super.key,
      required this.selectedType,
      this.restartTimer,
      this.stopTimer});

  final TabController tabController;
  final String selectedType;
  final Function? restartTimer;
  final Function? stopTimer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Stack(
        children: [
          Positioned(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              width: MediaQuery.of(context).size.width,
              padding: REdgeInsets.only(right: 30, left: 30, bottom: 30),
              height: 270.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: AppStyle.colorByTask(selectedType, true),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi User',
                        style: TextStyle(
                            color: AppStyle.darkSilver,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                          onPressed: () {
                            stopTimer!();

                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                isDismissible: true,
                                enableDrag: false,
                                builder: (BuildContext context) {
                                  return ChangePassWord(
                                    restartTimer: () => restartTimer!(),
                                  );
                                });
                          },
                          color: AppStyle.darkSilver,
                          icon: const Icon(Icons.settings))
                    ],
                  ),
                  const Text(
                    'This is task app',
                    style: TextStyle(color: AppStyle.darkSilver),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 10.h,
              left: 20.w,
              right: 20.w,
              child: TaskTabBar(
                  tabController: tabController, selectedType: selectedType)),
        ],
      ),
    );
  }
}
