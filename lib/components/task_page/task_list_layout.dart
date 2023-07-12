import 'dart:convert';

import 'package:app/components/task_page/detail_box.dart';
import 'package:app/models/task.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskListLayout extends StatefulWidget {
  const TaskListLayout({super.key, this.type = 'TODO'});
  final String type;
  @override
  _TaskListLayoutState createState() => _TaskListLayoutState();
}

class _TaskListLayoutState extends State<TaskListLayout> {
  List<TaskModel> tasks = [];
  Map<String, List<TaskModel>> groupedTasks = {};
  // late TaskListModel tasks;
  int pageNumber = 0;
  int offset = 0;
  int itemLimit = 10;
  int totalPages = 1;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchTasks();
    scrollController.addListener(scrollListener);
  }

  @override
  void didUpdateWidget(TaskListLayout oldWidget) {
    if (oldWidget.type != widget.type) {
      // Reset the tasks and fetch new tasks when type changes
      setState(() {
        tasks.clear();
        groupedTasks.clear();
        pageNumber = 0;
        offset = 0;
        totalPages = 1;
      });
      fetchTasks();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  Future<void> fetchTasks() async {
    if (isLoading || pageNumber >= totalPages) return;
    setState(() {
      isLoading = true;
    });
    try {
      final response = await dio.get(
          'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list',
          queryParameters: {
            'offset': offset,
            'limit': itemLimit,
            'sortBy': 'createdAt',
            'isAsc': true,
            'status': widget.type
          });

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          pageNumber = data['pageNumber'];
          totalPages = data['totalPages'];
          final list = TaskListModel.fromJson(response.data).tasks;
          tasks.addAll(list);
          groupedTasks = groupTasksByDate(tasks);
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    offset++;
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading) {
      fetchTasks();
    }
  }

  void _deleteTask(String taskId, String createdAt) {
    final dateKey = DateFormat('yyyy-MM-dd').format(DateTime.parse(createdAt));

    setState(() {
      groupedTasks[dateKey]!.removeWhere((task) => task.id == taskId);

      if (groupedTasks[dateKey]!.isEmpty) {
        groupedTasks.remove(dateKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: groupedTasks.length + 1,
      itemBuilder: (context, index) {
        if (index < groupedTasks.length) {
          final date = groupedTasks.keys.elementAt(index);
          final tasksForDate = groupedTasks[date];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  date,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasksForDate!.length,
                itemBuilder: (context, index) {
                  final task = tasksForDate[index];

                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) {
                      _deleteTask(task.id, task.createdAt);
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: DetailBox(
                      data: task,
                    ),
                  );
                },
              ),
            ],
          );
        } else if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
