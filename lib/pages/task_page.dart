import 'package:app/style/app_style.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with TickerProviderStateMixin {
  late TabController tabController;
  int selectedTab = 0;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      setState(() {
        selectedTab = tabController.index;
      });

      print('Selected $selectedTab');
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
                    padding: EdgeInsets.all(30),
                    height: 200,
                    decoration: const BoxDecoration(
                      color: AppStyle.darkPurple2,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Hi User'), Text('This task app')],
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
                      padding: EdgeInsets.all(4),
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
                            tabs: [
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
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Container(
                            color: index.isOdd ? Colors.white : Colors.black12,
                            height: 100.0,
                            child: Center(
                              child: Text('$index', textScaleFactor: 5),
                            ),
                          );
                        },
                        childCount: 20,
                      ),
                    ),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeader({required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: 66.0,
      child: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 12),
          color: Colors.white,
          elevation: 5.0,
          child: Center(child: widget),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 66.0;

  @override
  double get minExtent => 66.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
