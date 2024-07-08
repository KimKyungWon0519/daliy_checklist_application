import 'package:domain/repositories/task_repository.dart';
import 'package:shared_domain/domain.dart';

class GetTask {
  late final TaskRepository _taskRepository;

  GetTask({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  Future<List<Task>> getAllTasks() {
    return _taskRepository.getAllTasks();
  }

  Stream<void> getTasksChangedWatcher() {
    return _taskRepository.getTasksChangedWatcher();
  }
}

class UpdateTask {
  late final TaskRepository _taskRepository;

  UpdateTask({
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  Future<void> changeCompleted(Task task, bool isCompleted) {
    return _taskRepository.updateTask(task.copyWith(isCompleted: isCompleted));
  }
}
