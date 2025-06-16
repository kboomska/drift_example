import 'package:drift_example/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:drift_example/src/feature/tasks/data/tasks_repository.dart';
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
  late final TasksRepository tasksRepository;
  late final Stream<List<TaskEntity>> currentTasks;
  late final ScrollController controller;

  @override
  void initState() {
    super.initState();
    tasksRepository = DependenciesScope.of(context).tasksRepository;
    currentTasks = tasksRepository.watch();
    controller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addTask() async {
    final task = TaskEntity(
      title: 'Another todo',
      content: 'Some description...',
      createdAt: DateTime.now(),
    );

    await tasksRepository.insert(task);

    if (controller.offset != 0) {
      controller.animateTo(
        0.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drift example app')),
      body: StreamBuilder<List<TaskEntity>>(
        stream: currentTasks,
        builder: (context, snapshot) {
          final tasks = snapshot.data ?? [];

          return ListView.builder(
            controller: controller,
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
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
