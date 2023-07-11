class TaskListModel {
  List<TaskModel> tasks = [];
  num pageNumber = 0;
  num totalPages = 0;

  TaskListModel();

  factory TaskListModel.fromJson(dynamic data) {
    var model = TaskListModel();
    model.tasks = ((data['task'] ?? []) as List<TaskModel>)
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
  String createdAt = '';
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
