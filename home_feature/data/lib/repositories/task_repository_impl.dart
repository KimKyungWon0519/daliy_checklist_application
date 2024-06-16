import 'package:data/data_sources/task_database.dart';
import 'package:domain/domain.dart';
import 'package:shared_data/mappers/task.dart';

class TaskRepositoryImpl implements TaskRepository {
  late final TaskDatabase _taskDatabase;

  TaskRepositoryImpl({
    required TaskDatabase taskDatabase,
  }) : _taskDatabase = taskDatabase;

  @override
  Future<List<Task>> getAllTasks() {
    return _taskDatabase
        .getAllTasks()
        .then((value) => value.map((e) => e.toModel()).toList());
  }

  @override
  Stream<void> getTasksChangedWatcher() {
    return _taskDatabase.getTasksChangedWatcher();
  }
}
