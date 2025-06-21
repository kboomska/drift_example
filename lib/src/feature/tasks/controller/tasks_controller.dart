import 'package:drift_example/src/feature/tasks/data/tasks_repository.dart';
import 'package:drift_example/src/feature/tasks/model/task_entity.dart';

/// {@template tasks_controller}
/// A controller that handles tasks.
/// {@endtemplate}
class TasksController {
  /// {@macro tasks_controller}
  TasksController({required TasksRepository repository})
    : _tasksRepository = repository,
      stream = repository.watch();

  final TasksRepository _tasksRepository;

  /// A source of tasks data.
  final Stream<List<TaskEntity>> stream;

  /// [addTask] is used to add a new task.
  Future<void> addTask(String title, String content) async {
    final task = TaskEntity(
      title: title,
      content: content,
      createdAt: DateTime.now(),
    );

    await _tasksRepository.insert(task);
  }
}
