import 'package:domain/model/task.dart';
import 'package:domain/repositories/task_repository.dart';

class GetTask {
  late final TaskRepository _taskRepository;

  GetTask(final TaskRepository taskRepository)
      : _taskRepository = taskRepository;

  Future<List<Task>> getAllTask() {
    return _taskRepository.getAllTask();
  }
}

class AddTask {
  late final TaskRepository _taskRepository;

  AddTask(final TaskRepository taskRepository)
      : _taskRepository = taskRepository;

  Future<int> addTask(Task task) {
    return _taskRepository.addTask(task);
  }
}