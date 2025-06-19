import 'package:drift_example/src/feature/tasks/controller/tasks_controller.dart';
import 'package:drift_example/src/feature/tasks/model/task_entity.dart';
import 'package:flutter/widgets.dart';

abstract interface class TasksScopeController {
  Stream<List<TaskEntity>> get stream;

  Future<void> addTask(String title, String content);
}

class TasksScope extends StatefulWidget {
  const TasksScope({super.key, required this.child, required this.controller});

  final Widget child;

  final TasksController controller;

  static TasksScopeController getController(BuildContext context) =>
      _InheritedTasksScope.of(context).controller;

  @override
  State<TasksScope> createState() => _TasksScopeState();
}

class _TasksScopeState extends State<TasksScope>
    implements TasksScopeController {
  @override
  Stream<List<TaskEntity>> get stream => widget.controller.stream;

  @override
  Future<void> addTask(String title, String content) async =>
      await widget.controller.addTask(title, content);

  @override
  Widget build(BuildContext context) {
    return _InheritedTasksScope(controller: this, child: widget.child);
  }
}

class _InheritedTasksScope extends InheritedWidget {
  const _InheritedTasksScope({required super.child, required this.controller});

  final TasksScopeController controller;

  static _InheritedTasksScope of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<_InheritedTasksScope>()!;

  @override
  bool updateShouldNotify(_InheritedTasksScope oldWidget) {
    return false;
  }
}
