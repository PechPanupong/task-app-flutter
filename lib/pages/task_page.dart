import 'dart:async';

import 'package:app/components/task_page/detail_box.dart';
import 'package:app/pages/pass_lock_page.dart';
import 'package:app/store/app_storage.dart';
import 'package:app/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/task_page/task_list_layout.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late TabController tabController;
  int selectedTab = 0;
  String selectedType = "TODO";
  late DateTime pauseTime;
  Timer? _timer;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      final newTabIndex = tabController.index;
      if (newTabIndex != selectedTab) {
        setState(() {
          selectedTab = newTabIndex;
        });

        switch (selectedTab) {
          case 0:
            selectedType = 'TODO';
          case 1:
            selectedType = 'DOING';
          case 2:
            selectedType = 'DONE';
          default:
            selectedType = 'TODO';
        }

        print('Selected $selectedType');
      }
    });
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    // _startTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        print('resumed');
        var close = context.read<AppStorage>().closeDate;
        DateTime resumedTime = DateTime.now();
        Duration appCloseDuration =
            resumedTime.difference(DateTime.parse(close));
        if (appCloseDuration.inSeconds > 10) {
          print('go');
          context.read<AppStorage>().isLogin = false;

          GoRouter.of(context).replace('/lock');
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        print('paused');
        context.read<AppStorage>().closeDate = DateTime.now();
        break;
      case AppLifecycleState.detached:
        print('detached');
        context.read<AppStorage>().closeDate = DateTime.now();
        break;
    }
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 10), () {
      context.read<AppStorage>().isLogin = false;
      GoRouter.of(context).replace('/lock');
    });
  }

  void _restartTimer() {
    _timer?.cancel();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _restartTimer();
        },
        child: SizedBox(
          width: double.infinity,
          child: Column(children: [
            Container(
              height: 300.h,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: REdgeInsets.all(30),
                      height: 270.h,
                      decoration: const BoxDecoration(
                        color: AppStyle.darkPurple2,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            'Hi User',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            'This is task app',
                            style: TextStyle(color: Colors.white54),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.h,
                    left: 20.w,
                    right: 20.w,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        height: 40.h,
                        child: Center(
                          child: TabBar(
                              dividerColor: Colors.transparent,
                              controller: tabController,
                              isScrollable: true,
                              labelPadding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              labelColor: Colors.white,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppStyle.floor),
                              tabs: const [
                                Tab(child: Text('To-do')),
                                Tab(child: Text('Doing')),
                                Tab(child: Text('Done')),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 2.0).r,
              child: TaskListLayout(
                type: selectedType,
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
