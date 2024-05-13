import 'package:data/data_sources/task_database.dart';
import 'package:data/mappers/task.dart';
import 'package:domain/domain.dart';

class TaskRepositoryImpl implements TaskRepository {
  late final TaskDatabase _taskDatabase;

  TaskRepositoryImpl({
    required TaskDatabase taskDatabase,
  }) : _taskDatabase = taskDatabase;

  @override
  Future<int> addTask(Task task) {
    return _taskDatabase.addTask(task.toEntity());
  }

  @override
  Future<List<Task>> getAllTask() {
    return _taskDatabase
        .getAllTask()
        .then((value) => value.map((e) => e.toModel()).toList());
  }
}
