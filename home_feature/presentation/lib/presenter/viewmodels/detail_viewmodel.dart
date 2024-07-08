import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailViewModel {
  late final GetTask _getTask;
  late final TaskHandlerUseCase _taskHandlerUseCase;
  late final UpdateTask _updateTask;
  late final StateProvider<List<Task>> tasksProvider;

  DetailViewModel({
    required UpdateTask updateTask,
    required GetTask getTask,
    required TaskHandlerUseCase taskHandlerUseCase,
  })  : tasksProvider = StateProvider((ref) => []),
        _updateTask = updateTask,
        _getTask = getTask,
        _taskHandlerUseCase = taskHandlerUseCase;

  void addTaskUpdateListener(void Function(void event) listener) {
    _getTask.getTasksChangedWatcher().listen(listener);
  }

  Future<void> changeCompletedTask(Task task, bool isCompleted) {
    return _updateTask.changeCompleted(task, isCompleted);
  }

  Future<List<Task>> getAllTasks(TasksType type) async {
    List<Task> tasks = await _getTask.getAllTasks();

    switch (type) {
      case TasksType.today:
        return _taskHandlerUseCase.getTodayTasks(tasks);
      case TasksType.future:
        return _taskHandlerUseCase.getFutureTasks(tasks);
      case TasksType.postpone:
        return _taskHandlerUseCase.getPostponeTasks(tasks);
      case TasksType.all:
        return tasks;
      case TasksType.completed:
        return _taskHandlerUseCase.getCompletedTasks(tasks);
    }
  }
}
