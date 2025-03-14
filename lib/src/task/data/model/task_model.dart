class TaskModel {
  int? id;
  final String title;
  final String description;
  bool isDone = false;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        isDone: map['isDone']);
  }
}
