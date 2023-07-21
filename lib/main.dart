import 'package:app/router/app_router.dart';
import 'package:app/store/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp(AppRouter(), await AppStorage.create()));
}

class MyApp extends StatelessWidget {
  const MyApp(this.appRouter, this.appStorage, {super.key});

  final AppRouter appRouter;
  final AppStorage appStorage;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppStorage>(
      create: (context) => appStorage,
      child: Builder(builder: (context) {
        return ScreenUtilInit(
          designSize: const Size(390, 933),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return SafeArea(
              child: MaterialApp.router(
                  routeInformationProvider:
                      appRouter.router.routeInformationProvider,
                  routeInformationParser:
                      appRouter.router.routeInformationParser,
                  routerDelegate: appRouter.router.routerDelegate,
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    colorScheme:
                        ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                    useMaterial3: true,
                  ),
                  builder: (context, child) {
                    return child!;
                  }),
            );
          },
        );
      }),
    );
  }
}
