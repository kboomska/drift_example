import 'package:drift/drift.dart';
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
  Future<void> insert(TaskEntity entity);
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

    return tasks.map(
      (todoItems) =>
          todoItems
              .map(
                (todo) => TaskEntity(
                  id: todo.id,
                  title: todo.title,
                  content: todo.content,
                  createdAt: todo.createdAt,
                ),
              )
              .toList(),
    );
  }

  @override
  Future<void> insert(TaskEntity entity) async {
    _dataSource.insert(
      TodoItemsCompanion.insert(
        title: entity.title,
        content: entity.content,
        createdAt: Value(entity.createdAt),
      ),
    );
  }
}
