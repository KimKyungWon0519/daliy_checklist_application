import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel {
  late final StateProvider<DateTime> selectedDateProvider;
  late final StateProvider<List<Task>> tasksProvider;

  late final GetTask _getTask;

  HomeViewModel({
    required GetTask getTask,
  }) : _getTask = getTask {
    selectedDateProvider = StateProvider((ref) => DateTime.now());
    tasksProvider = StateProvider((ref) => []);
  }

  Future<List<Task>> getAllTask(final DateTime date) {
    return _getTask.getAllTask(date);
  }
}
