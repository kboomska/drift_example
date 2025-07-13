import 'package:drift_example/src/core/app_database/app_database.dart';
import 'package:drift_example/src/feature/tasks/data/tasks_repository.dart';

/// {@template dependencies_container}
/// Container used to reuse dependencies across the application.
/// {@endtemplate}
class DependenciesContainer {
  /// {@macro dependencies_container}
  const DependenciesContainer({
    required this.database,
    required this.tasksRepository,
  });

  /// [AppDatabase] instance, used to store application data.
  final AppDatabase database;

  /// [TasksRepository] instance, used to insert and watch todo tasks.
  final TasksRepository tasksRepository;
}
