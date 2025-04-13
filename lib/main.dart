import 'dart:developer';

import 'package:drift_example/src/core/app_database/app_database.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  await database
      .into(database.todoItems)
      .insert(
        TodoItemsCompanion.insert(
          title: 'todo: finish drift setup',
          content: 'We can now write queries and define our own tables.',
        ),
      );
  List<TodoItem> allItems = await database.select(database.todoItems).get();

  log('items in database: $allItems');
}
