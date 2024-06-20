import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel {
  late final GetTask _getTask;
  late final TaskHandlerUseCase _taskHandlerUseCase;
  late final StateProvider<List<Task>> tasksProvider;

  HomeViewModel({
    required GetTask getTask,
    required TaskHandlerUseCase taskHandlerUseCase,
    List<Task>? initialTask,
  })  : _getTask = getTask,
        _taskHandlerUseCase = taskHandlerUseCase,
        tasksProvider = StateProvider((ref) => initialTask ?? []);

  void addTaskUpdateListener(void Function(void event) listener) {
    _getTask.getTasksChangedWatcher().listen(listener);
  }

  Future<List<Task>> getAllTasks() {
    return _getTask.getAllTasks();
  }

  List<Task> getTodayTasks(List<Task> tasks) {
    return _taskHandlerUseCase.getTodayTasks(tasks);
  }

  List<Task> getPostponeTasks(List<Task> tasks) {
    return _taskHandlerUseCase.getPostponeTasks(tasks);
  }

  List<Task> getFutureTasks(List<Task> tasks) {
    return _taskHandlerUseCase.getFutureTasks(tasks);
  }

  List<Task> getCompletedTasks(List<Task> tasks) {
    return _taskHandlerUseCase.getCompletedTasks(tasks);
  }
}
