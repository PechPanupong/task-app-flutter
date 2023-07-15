class CommonUtil {
  static String mapTaskWording(String type) {
    switch (type) {
      case 'TODO':
        return 'To-do';
      case 'DOING':
        return 'Doing';
      case 'DONE':
        return 'Done';
      default:
        return 'Task';
    }
  }
}
