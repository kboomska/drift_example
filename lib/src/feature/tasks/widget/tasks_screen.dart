import 'package:drift_example/src/feature/tasks/widget/tasks_list.dart';
import 'package:drift_example/src/feature/tasks/widget/tasks_scope.dart';
import 'package:flutter/material.dart';

/// {@template tasks_screen}
/// [TasksScreen] is a simple screen that displays a list of todo items and 
/// a button to add new tasks to the list.
/// {@endtemplate}
class TasksScreen extends StatefulWidget {
  /// {@macro tasks_screen}
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late final TasksState state;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    state = TasksScope.getState(context);
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  // Animates the position from its current value to the given value.
  void scrollTo(double offset) {
    if (scrollController.offset != 0) {
      scrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drift example app')),
      body: TasksList(scrollController: scrollController),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await state.addTask('Another todo', 'Some description...');
          scrollTo(0);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
