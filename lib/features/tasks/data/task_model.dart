class TaskModel {
  final String id;
  final String title;
  final String? imagePath;

  const TaskModel({
    required this.id,
    required this.title,
    this.imagePath,
  });
}
