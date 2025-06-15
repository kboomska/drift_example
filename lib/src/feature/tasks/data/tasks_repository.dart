import 'package:drift_example/src/core/app_database/app_database.dart';
import 'package:drift_example/src/feature/tasks/data/tasks_data_source.dart';
import 'package:drift_example/src/feature/tasks/model/task_entity.dart';

/// {@template tasks_repository}
/// [TasksRepository] inserts and watches tasks.
/// {@endtemplate}
abstract interface class TasksRepository {
  /// Watch tasks.
  Stream<List<TaskEntity>> watch();

  /// Insert task.
  Future<void> insert(String title, String content);
}

/// {@macro tasks_repository}
class TasksRepositoryImpl implements TasksRepository {
  /// {@macro tasks_repository}
  TasksRepositoryImpl({required TasksDataSource dataSource})
    : _dataSource = dataSource;

  /// The instance of [TasksDataSource] used to insert and watch todo items.
  final TasksDataSource _dataSource;

  @override
  Stream<List<TaskEntity>> watch() {
    final tasks = _dataSource.watch();

    return tasks.asyncMap(
      (dto) =>
          dto
              .map(
                (todo) => TaskEntity(
                  title: todo.title,
                  content: todo.content,
                  createdAt: todo.createdAt,
                ),
              )
              .toList(),
    );
  }

  @override
  Future<void> insert(String title, String content) async {
    _dataSource.insert(
      TodoItemsCompanion.insert(title: title, content: content),
    );
  }
}
