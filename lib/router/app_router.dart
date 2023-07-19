import 'package:app/pages/pass_lock_page.dart';
import 'package:app/pages/task_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../store/app_storage.dart';

class AppRouter {
  get router {
    return _router;
  }

  final _router = GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        var isLogin = context.read<AppStorage>().isLogin;
        var closeDate = context.read<AppStorage>().closeDate;
        Duration isTimeOut =
            DateTime.now().difference(DateTime.parse(closeDate));

        if (isTimeOut.inSeconds > 10) return '/lock';
        return isLogin ? '/' : '/lock';
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const TaskPage(),
        ),
        GoRoute(
          path: '/lock',
          builder: (context, state) => const PassLockScreen(),
        ),
      ]);
}
