class TaskModel {
  final int? id;
  final String title;
  final String description;
  final bool isCompleted;
  final String iconType;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.iconType = 'task',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted ? 1 : 0,
      'icon_type': iconType,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int?,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      isCompleted: (map['is_completed'] as int? ?? 0) == 1,
      iconType: map['icon_type'] as String? ?? 'task',
    );
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    String? iconType,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      iconType: iconType ?? this.iconType,
    );
  }
}

