import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel {
  late final GetTask _getTask;
  late final StateProvider<List<Task>> _tasksProvider;

  HomeViewModel({
    required GetTask getTask,
  }) : _getTask = getTask {
    _tasksProvider = StateProvider((ref) {
      _getTask.getTasksChangedWatcher().listen((event) {
        print('??');
      });

      return [];
    });
  }
}
