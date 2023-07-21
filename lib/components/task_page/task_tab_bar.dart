import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../style/app_style.dart';

class TaskTabBar extends StatelessWidget {
  const TaskTabBar(
      {super.key, required this.tabController, required this.selectedType});
  final TabController tabController;
  final String selectedType;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        height: 50.h,
        child: Center(
          child: TabBar(
              dividerColor: Colors.transparent,
              controller: tabController,
              isScrollable: true,
              labelStyle:
                  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              labelPadding: REdgeInsets.symmetric(
                horizontal: 40,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppStyle.darkSilver,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppStyle.colorByTask(selectedType, false)),
              tabs: const [
                Tab(child: Text('To-do')),
                Tab(child: Text('Doing')),
                Tab(child: Text('Done')),
              ]),
        ),
      ),
    );
  }
}
