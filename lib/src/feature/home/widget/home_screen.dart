import 'package:drift_example/src/core/app_database/app_database.dart';
import 'package:drift_example/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:flutter/material.dart';

/// {@template home_screen}
/// HomeScreen is a simple screen that displays a list of items.
/// {@endtemplate}
class HomeScreen extends StatefulWidget {
  /// {@macro home_screen}
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ValueNotifier<List<TodoItem>> _todoItems;

  @override
  void initState() {
    super.initState();
    _todoItems = ValueNotifier<List<TodoItem>>([]);
  }

  @override
  void dispose() {
    _todoItems.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final database = DependenciesScope.of(context).appDatabase;

    return Scaffold(
      appBar: AppBar(title: Text('Drift example app')),
      body: ValueListenableBuilder(
        valueListenable: _todoItems,
        builder: (context, item, _) {
          return ListView.builder(
            itemCount: _todoItems.value.length,
            itemBuilder: (context, index) {
              return Text(item[index].content);
            },
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await database
                  .into(database.todoItems)
                  .insert(
                    TodoItemsCompanion.insert(
                      title: 'Another todo',
                      content: 'Some description...',
                    ),
                  );
            },
            child: Icon(Icons.add),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () async {
              _todoItems.value =
                  await database.select(database.todoItems).get();
            },
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
