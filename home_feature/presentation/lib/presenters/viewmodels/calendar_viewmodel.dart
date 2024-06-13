import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarViewModel {
  late final StateProvider<DateTime> selectedDateProvider;
  late final StateProvider<List<Task>> selectedDateTasksProvider;
  late final StateProvider<List<Task>> allTasksProvider;

  late final GetTask _getTask;
  late final UpdateTask _updateTask;

  CalendarViewModel({
    required GetTask getTask,
    required UpdateTask updateTask,
  })  : _getTask = getTask,
        _updateTask = updateTask {
    selectedDateProvider = StateProvider((ref) => DateTime.now());
    selectedDateTasksProvider = StateProvider((ref) => []);
    allTasksProvider = StateProvider((ref) => []);
  }

  Future<List<Task>> getTaskOnSelectedDate(final DateTime date) {
    return _getTask.getTaskOnSelectedDate(date);
  }

  Future<List<Task>> getAllTasks() {
    return _getTask.getAllTasks();
  }

  Future<int> changedCompleted(Task task, bool isCompleted) {
    return _updateTask
        .updateCompletedFlag(task.copyWith(isCompleted: isCompleted));
  }
}
