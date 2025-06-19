import 'package:drift_example/src/feature/tasks/data/tasks_repository.dart';
import 'package:drift_example/src/feature/tasks/model/task_entity.dart';

class TasksController {
  TasksController({required TasksRepository repository})
    : _tasksRepository = repository,
      stream = repository.watch();

  final TasksRepository _tasksRepository;

  final Stream<List<TaskEntity>> stream;

  Future<void> addTask(String title, String content) async {
    final task = TaskEntity(
      title: title,
      content: content,
      createdAt: DateTime.now(),
    );

    await _tasksRepository.insert(task);
  }
}
