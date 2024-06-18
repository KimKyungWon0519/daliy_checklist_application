import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel {
  late final GetTask _getTask;
  late final StateProvider<List<Task>> tasksProvider;

  HomeViewModel({
    required GetTask getTask,
    List<Task>? initialTask,
  })  : _getTask = getTask,
        tasksProvider = StateProvider((ref) => initialTask ?? []);

  void addTaskUpdateListener(void Function(void event) listener) {
    _getTask.getTasksChangedWatcher().listen(listener);
  }

  Future<List<Task>> getAllTasks() {
    return _getTask.getAllTasks();
  }
}
