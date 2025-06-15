import 'package:drift_example/src/feature/tasks/data/tasks_repository.dart';

/// {@template dependencies_container}
/// Container used to reuse dependencies across the application.
/// {@endtemplate}
class DependenciesContainer {
  /// {@macro dependencies_container}
  const DependenciesContainer({required this.tasksRepository});

  /// [TasksRepository] instance, used to insert and watch todo tasks.
  final TasksRepository tasksRepository;
}
