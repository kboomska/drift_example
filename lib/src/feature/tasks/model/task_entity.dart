/// {@template task_entity}
/// Todo task entity.
/// {@endtemplate}
class TaskEntity {
  final int? id;
  final String title;
  final String content;
  final DateTime? createdAt;

  /// {@macro task_entity}
  TaskEntity({
    this.id,
    required this.title,
    required this.content,
    this.createdAt,
  });

  TaskEntity copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'TaskEntity(id: $id'
        ', title: $title'
        ', content: $content'
        ', createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant TaskEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ content.hashCode ^ createdAt.hashCode;
  }
}
