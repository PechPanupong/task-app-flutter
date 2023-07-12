import 'package:app/components/task_page/detail_box.dart';
import 'package:app/style/app_style.dart';
import 'package:flutter/material.dart';

import '../components/task_page/task_list_layout.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with TickerProviderStateMixin {
  late TabController tabController;
  int selectedTab = 0;
  String selectedType = "TODO";

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(30),
                    height: 200,
                    decoration: const BoxDecoration(
                      color: AppStyle.darkPurple2,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Hi User',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'This is task app',
                          style: TextStyle(color: Colors.white54),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      height: 40,
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
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: TaskListLayout(
                  type: selectedType,
                ),
              ))
        ]),
      ),
    );
  }
}
