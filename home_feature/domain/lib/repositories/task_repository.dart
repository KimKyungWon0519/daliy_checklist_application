import 'package:shared_domain/domain.dart';

abstract interface class TaskRepository {
  Stream<void> getTasksChangedWatcher();

  Future<List<Task>> getAllTasks();
}
