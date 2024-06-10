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
  Future<List<Task>> getTaskOnSelectedDate(DateTime date) {
    final DateTime target = DateTime(date.year, date.month, date.day);

    return _taskDatabase
        .getTaskOnSelectedDate(target)
        .then((value) => value.map((e) => e.toModel()).toList());
  }

  @override
  Future<List<Task>> getAllTasks() {
    return _taskDatabase
        .getAllTasks()
        .then((value) => value.map((e) => e.toModel()).toList());
  }

  @override
  Future<int> updateCompletedFlag(Task task) {
    return _taskDatabase.updateTask(task.toEntity());
  }
}
