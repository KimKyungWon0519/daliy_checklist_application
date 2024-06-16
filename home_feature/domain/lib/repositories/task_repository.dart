import 'package:shared_domain/shared_domain.dart';

abstract interface class TaskRepository {
  Stream<void> getTasksChangedWatcher();

  Future<List<Task>> getAllTasks();
}
