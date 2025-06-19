import 'package:drift_example/src/feature/tasks/model/task_entity.dart';
import 'package:drift_example/src/feature/tasks/widget/tasks_scope.dart';
import 'package:flutter/material.dart';

/// {@template tasks_screen}
/// [TasksScreen] is a simple screen that displays a list of todo items.
/// {@endtemplate}
class TasksScreen extends StatefulWidget {
  /// {@macro tasks_screen}
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late final TasksScopeController controller;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    controller = TasksScope.getController(context);
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drift example app')),
      body: StreamBuilder<List<TaskEntity>>(
        stream: controller.stream,
        builder: (context, snapshot) {
          final tasks = snapshot.data ?? [];

          return ListView.builder(
            controller: scrollController,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[tasks.length - index - 1];

              return ListTile(
                title: Text(task.title),
                subtitle: Text('${task.content} ${task.id}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addTask('Another todo', 'Some description...');
          if (scrollController.offset != 0) {
            scrollController.animateTo(
              0.0,
              duration: Duration(milliseconds: 300),
              curve: Curves.bounceIn,
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
