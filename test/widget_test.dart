import 'dart:async';

import 'package:app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/tab_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:app/store/app_storage.dart';
import 'package:app/pages/pass_lock_page.dart';
import 'package:app/pages/task_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAppStorage extends Mock implements AppStorage {}

class MockTabController extends Mock implements TabController {}

class MockBuildContext extends Mock implements BuildContext {}

class MockTimer extends Mock implements Timer {}

class MockWidgetsBinding extends Mock implements WidgetsBinding {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late TaskPageState taskPageState;
  late MockAppStorage mockAppStorage;
  late AppRouter appRouter;
  late MockSharedPreferences mockSharedPreferences;
  late AppStorage appStorage;

  setUp(() {
    mockAppStorage = MockAppStorage();
    taskPageState = TaskPageState();
    appRouter = AppRouter();
    mockSharedPreferences = MockSharedPreferences();
    appStorage = AppStorage(mockSharedPreferences);
  });

  group('TaskPageState', () {
    test('selectedType returns the correct type based on selectedTab', () {
      // Test when selectedTab is 0
      taskPageState.selectedTab = 0;
      expect(taskPageState.selectedType, 'TODO');

      // Test when selectedTab is 1
      taskPageState.selectedTab = 1;
      expect(taskPageState.selectedType, 'DOING');

      // Test when selectedTab is 2
      taskPageState.selectedTab = 2;
      expect(taskPageState.selectedType, 'DONE');

      // Test when selectedTab is an invalid value
      taskPageState.selectedTab = -1;
      expect(taskPageState.selectedType, 'TODO');
    });
  });
}
