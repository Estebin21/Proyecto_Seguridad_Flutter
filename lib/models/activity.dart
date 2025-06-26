class Activity {
  final String title;
  final String description;
  final String contentType;
  final String contentPath;
  final int order;
  bool isCompleted;

  Activity({
    required this.title,
    required this.description,
    required this.contentType,
    required this.contentPath,
    required this.order,
    this.isCompleted = false,
  });
}