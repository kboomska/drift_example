import 'dart:async';
import 'dart:developer';

import 'package:clock/clock.dart';
import 'package:drift_example/src/core/app_database/app_database.dart';
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

            await database
                .into(database.todoItems)
                .insert(
                  TodoItemsCompanion.insert(
                    title: 'todo: finish drift setup',
                    content:
                        'We can now write queries and define our own tables.',
                  ),
                );
            List<TodoItem> allItems =
                await database.select(database.todoItems).get();

            log('Items in database: $allItems');
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
