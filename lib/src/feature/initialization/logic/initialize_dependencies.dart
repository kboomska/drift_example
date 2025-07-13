import 'package:drift_example/src/core/app_database/app_database.dart';
import 'package:drift_example/src/feature/initialization/model/dependencies_container.dart';
import 'package:drift_example/src/feature/tasks/data/tasks_data_source.dart';
import 'package:drift_example/src/feature/tasks/data/tasks_repository.dart';

/// Initializes dependencies and returns a [DependenciesContainer] object.
Future<DependenciesContainer> $initializeDependencies() async {
  // Create or obtain the app database instance.
  final database = AppDatabase();

  // Repository that is used for inserting and watching tasks.
  final tasksRepository = TasksRepositoryImpl(
    dataSource: TasksDataSourceImpl(database),
  );

  return DependenciesContainer(
    database: database,
    tasksRepository: tasksRepository,
  );
}
