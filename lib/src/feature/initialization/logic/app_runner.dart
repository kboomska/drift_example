import 'dart:async';
import 'dart:developer';

import 'package:clock/clock.dart';
import 'package:drift_example/src/core/app_database/app_database.dart';
import 'package:drift_example/src/feature/initialization/model/dependencies_container.dart';
import 'package:drift_example/src/feature/initialization/widget/root_context.dart';
import 'package:drift_example/src/feature/tasks/data/tasks_data_source.dart';
import 'package:drift_example/src/feature/tasks/data/tasks_repository.dart';
import 'package:flutter/widgets.dart';

/// {@template app_runner}
/// A class that is responsible for running the application.
/// {@endtemplate}
class AppRunner {
  /// {@macro app_runner}
  const AppRunner._();

  /// Initializes dependencies and launches the application within a guarded
  /// execution zone.
  static Future<void> startup() async {
    await runZonedGuarded(
      () async {
        // Ensure Flutter is initialized.
        WidgetsFlutterBinding.ensureInitialized();

        Future<void> launchApplication() async {
          try {
            // Initialize dependencies.
            final database = AppDatabase();
            final tasksDataSource = TasksDataSourceImpl(database);
            final tasksRepository = TasksRepositoryImpl(
              dataSource: tasksDataSource,
            );

            // Create the dependencies container.
            final dependencies = DependenciesContainer(
              tasksRepository: tasksRepository,
            );

            runApp(RootContext(dependenciesContainer: dependencies));
          } on Object catch (e, stackTrace) {
            log(
              '${clock.now()} Initialization failed',
              error: e,
              stackTrace: stackTrace,
            );
          }
        }

        // Launch the application.
        await launchApplication();
      },
      (error, stack) {
        log('${clock.now()} Zone error', error: error, stackTrace: stack);
      },
    );
  }
}
