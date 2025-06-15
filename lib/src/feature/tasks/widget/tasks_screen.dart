import 'package:drift_example/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:drift_example/src/feature/tasks/model/task_entity.dart';
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
  @override
  Widget build(BuildContext context) {
    final tasksRepository = DependenciesScope.of(context).tasksRepository;
    final currentTasks = tasksRepository.watch();

    return Scaffold(
      appBar: AppBar(title: Text('Drift example app')),
      body: StreamBuilder<List<TaskEntity>>(
        stream: currentTasks,
        builder: (context, snapshot) {
          final tasks = snapshot.data ?? [];

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return ListTile(
                title: Text(task.title),
                subtitle: Text('${task.content} $index'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await tasksRepository.insert('Another todo', 'Some description...');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
