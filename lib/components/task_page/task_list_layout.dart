import 'package:app/models/task_model.dart';
import 'package:app/style/app_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../utils/common.dart';
import 'task_detail.dart';
import 'task_item.dart';

class TaskListLayout extends StatefulWidget {
  const TaskListLayout({super.key, this.type = 'TODO', this.restartTimer});
  final String type;
  final Function? restartTimer;
  @override
  _TaskListLayoutState createState() => _TaskListLayoutState();
}

class _TaskListLayoutState extends State<TaskListLayout> {
  List<TaskModel> tasks = [];
  Map<String, List<TaskModel>> groupedTasks = {};
  int pageNumber = 0;
  int offset = 0;
  int itemLimit = 10;
  int totalPages = 1;
  bool isLoading = false;
  final Dio dio = Dio();
  final CommonUtil common = CommonUtil();
  String apiURL = 'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list';

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  @override
  void didUpdateWidget(TaskListLayout oldWidget) {
    if (oldWidget.type != widget.type) {
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
    super.dispose();
  }

  Future<void> fetchTasks() async {
    if (isLoading || pageNumber >= totalPages) return;
    setState(() {
      isLoading = true;
    });

    try {
      final response = await dio.get(apiURL, queryParameters: {
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

  _deleteTask(String taskId, String createdAt) {
    final dateKey = DateFormat('dd MMM yyyy').format(DateTime.parse(createdAt));
    setState(() {
      groupedTasks[dateKey]!.removeWhere((task) => task.id == taskId);
      if (groupedTasks[dateKey]!.isEmpty) {
        groupedTasks.remove(dateKey);
      }
      common.showSnackBar(context, 'Task Deleted !!!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: fetchTasks(),
      builder: (context, snapshot) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (groupedTasks.isEmpty && !isLoading) {
          return Center(
            child: Text(
              'No ${CommonUtil.mapTaskWording(widget.type)} task right now',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppStyle.darkSilver,
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                for (int index = 0; index < groupedTasks.length; index++)
                  Container(
                    padding: REdgeInsets.only(right: 10, left: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: REdgeInsets.all(8.0),
                          child: Text(
                            groupedTasks.keys.elementAt(index),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            for (final task
                                in groupedTasks.values.elementAt(index))
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      isDismissible: false,
                                      builder: (BuildContext context) {
                                        return TaskDetail(
                                          task,
                                          restartTimer: () =>
                                              widget.restartTimer!(),
                                        );
                                      });
                                },
                                child: TaskItem(
                                  task: task,
                                  onDelete: () =>
                                      _deleteTask(task.id, task.createdAt),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
