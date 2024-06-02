import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel {
  late final StateProvider<DateTime> selectedDateProvider;
  late final StateProvider<List<Task>> selectedDateTasksProvider;
  late final StateProvider<List<Task>> allTasksProvider;

  late final GetTask _getTask;

  HomeViewModel({
    required GetTask getTask,
  }) : _getTask = getTask {
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
}
