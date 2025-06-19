import 'package:drift_example/src/feature/tasks/model/task_entity.dart';
import 'package:drift_example/src/feature/tasks/widget/tasks_scope.dart';
import 'package:flutter/material.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  late final Stream<List<TaskEntity>> stream;

  @override
  void initState() {
    super.initState();
    stream = TasksScope.getStream(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TaskEntity>>(
      stream: stream,
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
