import 'package:intl/intl.dart';

class TaskListModel {
  List<TaskModel> tasks = [];
  num pageNumber = 0;
  num totalPages = 0;

  TaskListModel();

  factory TaskListModel.fromJson(dynamic data) {
    var model = TaskListModel();
    model.tasks = ((data['tasks'] ?? []) as List<dynamic>)
        .map((e) => TaskModel.fromJson(e))
        .toList();
    model.pageNumber = data['pageNumber'];
    model.totalPages = data['totalPages'];
    return model;
  }
}

class TaskModel {
  String id = '';
  String title = '';
  String description = '';
  dynamic createdAt = DateTime.now();
  String status = '';

  TaskModel();

  factory TaskModel.fromJson(dynamic data) {
    var model = TaskModel();
    model.id = data['id'];
    model.title = data['title'];
    model.description = data['description'];
    model.createdAt = data['createdAt'];
    model.status = data['status'];
    return model;
  }
}

Map<String, List<TaskModel>> groupTasksByDate(List<TaskModel> tasks) {
  final Map<String, List<TaskModel>> groupedTasks = {};

  for (final task in tasks) {
    final formattedDate =
        DateFormat('dd MMM yyyy').format(DateTime.parse(task.createdAt));

    if (groupedTasks.containsKey(formattedDate)) {
      groupedTasks[formattedDate]!.add(task);
    } else {
      groupedTasks[formattedDate] = [task];
    }
  }

  return groupedTasks;
}
