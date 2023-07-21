import 'dart:async';

import 'package:app/components/task_page/task_header.dart';
import 'package:app/pages/pass_lock_page.dart';
import 'package:app/store/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/task_page/task_list_layout.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => TaskPageState();
}

@visibleForTesting
class TaskPageState extends State<TaskPage>
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

  Timer? timer;

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
    startTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    var isLogin = context.read<AppStorage>().isLogin;
    switch (state) {
      case AppLifecycleState.resumed:
        if (!isLogin) return;
        restartTimer();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        if (!isLogin) return;
        restartTimer();
        context.read<AppStorage>().closeDate = DateTime.now().toString();
        break;
      case AppLifecycleState.detached:
        if (!isLogin) return;
        restartTimer();
        context.read<AppStorage>().closeDate = DateTime.now().toString();
        break;
    }
  }

  void startTimer() {
    print('start');
    timer = Timer(const Duration(seconds: 10), () {
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
                restartTimer();
              },
            );
          });
    });
  }

  void restartTimer() {
    timer?.cancel();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (event) {
          restartTimer();
        },
        child: CustomScrollView(slivers: [
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: Size(0.w, 110.h),
              child: const SizedBox.shrink(),
            ),
            floating: true,
            expandedHeight: 300.h,
            flexibleSpace: TaskHeader(
              tabController,
              selectedType: selectedType,
              stopTimer: () {
                timer?.cancel();
              },
              restartTimer: () {
                restartTimer();
              },
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            TaskListLayout(
              restartTimer: () {
                restartTimer();
              },
              type: selectedType,
            )
          ]))
        ]),
      ),
    );
  }
}
