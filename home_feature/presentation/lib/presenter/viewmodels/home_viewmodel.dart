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

  List<Task> getTodayTask(List<Task> tasks) {
    DateTime nowTime = DateTime.now();
    nowTime = DateTime(nowTime.year, nowTime.month, nowTime.day);

    return tasks.where((element) {
      return element.selectedDate.isIncludeDate(nowTime);
    }).toList();
  }
}
