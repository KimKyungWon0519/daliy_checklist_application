import 'package:domain/domain.dart';

class HomeViewModel {
  late final GetTask _getTask;

  HomeViewModel({
    required GetTask getTask,
  }) : _getTask = getTask {
    _listenTaskUpdate();
  }

  void _listenTaskUpdate() {
    _getTask.getTasksChangedWatcher().listen((event) {});
  }
}
