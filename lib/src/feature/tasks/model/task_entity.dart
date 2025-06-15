/// {@template task_entity}
/// Todo task entity.
/// {@endtemplate}
class TaskEntity {
  final String title;
  final String content;
  final DateTime? createdAt;

  /// {@macro task_entity}
  TaskEntity({
    required this.title,
    required this.content,
    required this.createdAt,
  });

  TaskEntity copyWith({String? title, String? content, DateTime? createdAt}) {
    return TaskEntity(
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() =>
      'TasksEntity(title: $title, content: $content, createdAt: $createdAt)';

  @override
  bool operator ==(covariant TaskEntity other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.content == content &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode ^ createdAt.hashCode;
}
