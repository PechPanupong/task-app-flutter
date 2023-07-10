import 'package:app/style/app_style.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       pinned: true,
      //       expandedHeight: MediaQuery.of(context).size.width - 50,
      //       flexibleSpace: FlexibleSpaceBar(
      //         background: Container(
      //           decoration: const BoxDecoration(
      //             color: AppStyle.floor,
      //             borderRadius: BorderRadius.only(
      //                 bottomLeft: Radius.circular(30),
      //                 bottomRight: Radius.circular(30)),
      //           ),
      //           child: Text('pech'),
      //         ),
      //       ),
      //     ),
      //     SliverPersistentHeader(
      //       pinned: true,
      //       delegate: PersistentHeader(
      //         widget: const Row(
      //           // Format this to meet your need
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: <Widget>[
      //             Text('Hello World'),
      //             Text('Hello World'),
      //             Text('Hello World'),
      //           ],
      //         ),
      //       ),
      //     ),
      //     SliverList(
      //       delegate: SliverChildBuilderDelegate(
      //         (BuildContext context, int index) {
      //           return Container(
      //             color: index.isOdd ? Colors.white : Colors.black12,
      //             height: 100.0,
      //             child: Center(
      //               child: Text('$index', textScaleFactor: 5),
      //             ),
      //           );
      //         },
      //         childCount: 20,
      //       ),
      //     ),
      //   ],
      // ),
      body: Container(
        width: double.infinity,
        child: Column(children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: AppStyle.floor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  left: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 100,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 2,
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
