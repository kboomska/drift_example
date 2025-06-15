import 'package:drift/drift.dart';
import 'package:drift_example/src/core/app_database/app_database.dart';
import 'package:drift_example/src/core/app_database/tables/todo_items.dart';

part 'tasks_data_source.g.dart';

/// {@template tasks_data_source}
/// [TasksDataSource] inserts and watches tasks.
/// {@endtemplate}
abstract interface class TasksDataSource {
  Stream<List<TodoItem>> watch();

  Future<void> insert(TodoItemsCompanion entry);
}

/// {@macro tasks_data_source}
@DriftAccessor(tables: [TodoItems])
class TasksDataSourceImpl extends DatabaseAccessor<AppDatabase>
    with _$TasksDataSourceImplMixin
    implements TasksDataSource {
  /// {@macro tasks_data_source}
  TasksDataSourceImpl(super.attachedDatabase);

  @override
  Stream<List<TodoItem>> watch() => select(todoItems).watch();

  @override
  Future<void> insert(TodoItemsCompanion entry) =>
      into(todoItems).insert(entry);
}
