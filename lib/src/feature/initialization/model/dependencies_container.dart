import 'package:drift_example/src/core/app_database/app_database.dart';

/// {@template dependencies_container}
/// Container used to reuse dependencies across the application.
/// {@endtemplate}
class DependenciesContainer {
  /// {@macro dependencies_container}
  const DependenciesContainer({required this.database});

  /// [AppDatabase] instance, used to store application data.
  final AppDatabase database;
}
