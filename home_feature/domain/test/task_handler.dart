import 'package:domain/repositories/task_handler_repository.dart';
import 'package:shared_domain/models/task.dart';

class TaskHandlerUseCase {
  late final TaskHandlerRepository _taskHandlerRepository;

  TaskHandlerUseCase({
    required TaskHandlerRepository taskHandlerRepository,
  }) : _taskHandlerRepository = taskHandlerRepository;

  List<Task> getTodayTasks(List<Task> tasks) {
    return _taskHandlerRepository.getTodayTasks(tasks);
  }

  List<Task> getPostponeTasks(List<Task> tasks) {
    return _taskHandlerRepository.getPostponeTasks(tasks);
  }

  List<Task> getFutureTasks(List<Task> tasks) {
    return _taskHandlerRepository.getFutureTasks(tasks);
  }

  List<Task> getCompletedTasks(List<Task> tasks) {
    return _taskHandlerRepository.getCompletedTasks(tasks);
  }
}
