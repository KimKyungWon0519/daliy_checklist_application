import 'package:domain/model/task.dart';
import 'package:domain/repositories/task_repository.dart';

class GetTask {
  late final TaskRepository _taskRepository;

  GetTask({
    required final TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  Future<List<Task>> getTaskOnSelectedDate(DateTime date) {
    return _taskRepository.getTaskOnSelectedDate(date);
  }

  Future<List<Task>> getTaskOnMonth(int year, int month) {
    return _taskRepository.getTaskOnMonth(year, month);
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
