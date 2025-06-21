import 'package:drift_example/src/feature/tasks/model/task_entity.dart';
import 'package:drift_example/src/feature/tasks/widget/tasks_scope.dart';
import 'package:flutter/material.dart';

/// {@template tasks_list}
/// [TasksList] displays a list of todo items.
/// {@endtemplate}
class TasksList extends StatefulWidget {
  /// {@macro tasks_list}
  const TasksList({super.key, required this.scrollController});

  /// Controls the scrolling of the [TasksList] widget.
  final ScrollController scrollController;

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  // Used to sequentially receive task data.
  late final Stream<List<TaskEntity>> taskStream;

  @override
  void initState() {
    super.initState();
    taskStream = TasksScope.getTasks(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TaskEntity>>(
      stream: taskStream,
      builder: (context, snapshot) {
        final tasks = snapshot.data ?? [];

        return ListView.builder(
          controller: widget.scrollController,
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
    );
  }
}
