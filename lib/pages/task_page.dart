import 'dart:async';

import 'package:app/pages/pass_lock_page.dart';
import 'package:app/store/app_storage.dart';
import 'package:app/style/app_style.dart';
import 'package:flutter/material.dart';
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
  String get selectedType {
    switch (selectedTab) {
      case 0:
        return 'TODO';
      case 1:
        return 'DOING';
      case 2:
        return 'DONE';
      default:
        return 'TODO';
    }
  }

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
      }
    });
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    // _startTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    var isLogin = context.read<AppStorage>().isLogin;
    switch (state) {
      case AppLifecycleState.resumed:
        if (!isLogin) return;
        _restartTimer();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        if (!isLogin) return;
        _restartTimer();
        context.read<AppStorage>().closeDate = DateTime.now();
        break;
      case AppLifecycleState.detached:
        if (!isLogin) return;
        _restartTimer();
        context.read<AppStorage>().closeDate = DateTime.now();
        break;
    }
  }

  void _startTimer() {
    print('start timer');
    _timer = Timer(const Duration(seconds: 10), () {
      context.read<AppStorage>().isLogin = false;
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: false,
          builder: (BuildContext context) {
            return PassLockScreen(
              isPage: false,
              startTimer: () {
                _restartTimer();
              },
            );
          });
    });
  }

  void _restartTimer() {
    _timer?.cancel();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (event) {
          // _restartTimer();
        },
        child: SizedBox(
          width: double.infinity,
          child: Column(children: [
            SizedBox(
              height: 300.h,
              child: Stack(
                children: [
                  Positioned(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                      width: MediaQuery.of(context).size.width,
                      padding: REdgeInsets.all(30),
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
                          Text(
                            'Hi User',
                            style: TextStyle(
                                color: AppStyle.darkSilver,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w700),
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
                    child: Card(
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
                              labelStyle: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                              labelPadding: REdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              labelColor: Colors.white,
                              unselectedLabelColor: AppStyle.darkSilver,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppStyle.colorByTask(
                                      selectedType, false)),
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
              padding: REdgeInsets.symmetric(horizontal: 20),
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
