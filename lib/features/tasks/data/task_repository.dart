import 'task_model.dart';

class TaskRepository {
  TaskRepository._();
  static final instance = TaskRepository._();

  final List<TaskModel> _tasks = [];

  List<TaskModel> getAll() => List.unmodifiable(_tasks);

  void add(TaskModel task) {
    _tasks.insert(0, task);
  }
}
