import 'package:domain/repositories/task_repository.dart';
import 'package:shared_domain/shared_domain.dart';

class GetTask {
  late final TaskRepository _taskRepository;

  GetTask({
    required final TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  Future<List<Task>> getTaskOnSelectedDate(DateTime date) {
    return _taskRepository.getTaskOnSelectedDate(date);
  }

  Future<List<Task>> getAllTasks() {
    return _taskRepository.getAllTasks();
  }
}

class AddTask {
  late final TaskRepository _taskRepository;

  AddTask({
    required final TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  Future<int> addTask(Task task) {
    return _taskRepository.addTask(task);
  }
}

class UpdateTask {
  late final TaskRepository _taskRepository;

  UpdateTask({
    required final TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  Future<int> updateCompletedFlag(Task task) {
    return _taskRepository.updateCompletedFlag(task);
  }
}
