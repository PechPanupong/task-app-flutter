import 'package:app/pages/pass_lock_page.dart';
import 'package:app/pages/task_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../store/app_storage.dart';

class AppRouter {
  get router {
    return _router;
  }

  final _router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
      path: '/',
      // builder: (context, state) => const TaskPage(),
      builder: (context, state) {
        var isLogin = context.select((AppStorage value) => value.isLogin);
        print('islogin $isLogin');
        return isLogin ? const TaskPage() : PassLockScreen();
      },
    ),
    GoRoute(
      path: '/lock',
      builder: (context, state) => PassLockScreen(),
    ),
  ]);
}
