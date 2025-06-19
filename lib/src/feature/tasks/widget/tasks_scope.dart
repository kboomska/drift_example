import 'package:drift_example/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:drift_example/src/feature/tasks/controller/tasks_controller.dart';
import 'package:drift_example/src/feature/tasks/data/tasks_data_source.dart';
import 'package:drift_example/src/feature/tasks/data/tasks_repository.dart';
import 'package:drift_example/src/feature/tasks/model/task_entity.dart';
import 'package:flutter/widgets.dart';

abstract interface class TasksState {
  Stream<List<TaskEntity>> get stream;

  Future<void> addTask(String title, String content);
}

class TasksScope extends StatefulWidget {
  const TasksScope({super.key, required this.child});

  final Widget child;

  static TasksState getState(BuildContext context) =>
      _InheritedTasksScope.of(context).state;

  static Stream<List<TaskEntity>> getStream(BuildContext context) =>
      _InheritedTasksScope.of(context).state.stream;

  @override
  State<TasksScope> createState() => _TasksScopeState();
}

class _TasksScopeState extends State<TasksScope> implements TasksState {
  late final TasksController _tasksController;

  @override
  void initState() {
    super.initState();
    final database = DependenciesScope.of(context).database;
    _tasksController = TasksController(
      repository: TasksRepositoryImpl(
        dataSource: TasksDataSourceImpl(database),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Stream<List<TaskEntity>> get stream => _tasksController.stream;

  @override
  Future<void> addTask(String title, String content) async =>
      await _tasksController.addTask(title, content);

  @override
  Widget build(BuildContext context) {
    return _InheritedTasksScope(state: this, child: widget.child);
  }
}

class _InheritedTasksScope extends InheritedWidget {
  const _InheritedTasksScope({required super.child, required this.state});

  final TasksState state;

  static _InheritedTasksScope of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<_InheritedTasksScope>()!;

  @override
  bool updateShouldNotify(_InheritedTasksScope oldWidget) {
    return false;
  }
}
