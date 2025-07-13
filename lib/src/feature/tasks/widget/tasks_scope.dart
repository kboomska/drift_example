import 'package:drift_example/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:drift_example/src/feature/tasks/controller/tasks_controller.dart';
import 'package:drift_example/src/feature/tasks/model/task_entity.dart';
import 'package:flutter/widgets.dart';

/// {@template tasks_state}
/// State for widget [TasksScope].
/// {@endtemplate}
abstract interface class TasksState {
  /// A source of tasks data.
  Stream<List<TaskEntity>> get stream;

  /// [addTask] is used to add a new task.
  Future<void> addTask(String title, String content);
}

/// {@template tasks_scope}
/// TasksScope widget.
/// {@endtemplate}
class TasksScope extends StatefulWidget {
  /// {@macro tasks_scope}
  const TasksScope({super.key, required this.child});

  /// The child widget.
  final Widget child;

  /// Get state from the closest instance of [TasksScope].
  static TasksState getState(BuildContext context) =>
      _InheritedTasksScope.of(context).state;

  /// Get tasks.
  static Stream<List<TaskEntity>> getTasks(BuildContext context) =>
      _InheritedTasksScope.of(context).state.stream;

  @override
  State<TasksScope> createState() => _TasksScopeState();
}

class _TasksScopeState extends State<TasksScope> implements TasksState {
  late final TasksController _tasksController;

  @override
  void initState() {
    super.initState();
    final repository = DependenciesScope.of(context).tasksRepository;
    _tasksController = TasksController(repository: repository);
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

/// {@template inherited_tasks_scope}
/// [_InheritedTasksScope] widget.
/// {@endtemplate}
class _InheritedTasksScope extends InheritedWidget {
  const _InheritedTasksScope({required super.child, required this.state});

  /// [TasksState] instance.
  final TasksState state;

  static _InheritedTasksScope of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<_InheritedTasksScope>()!;

  @override
  bool updateShouldNotify(_InheritedTasksScope oldWidget) {
    return state != oldWidget.state;
  }
}
