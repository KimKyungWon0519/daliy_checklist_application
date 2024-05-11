import 'package:data/data_sources/task_database.dart';
import 'package:domain/domain.dart';
import 'package:domain/model/task.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDatabase taskDatabase;

  TaskRepositoryImpl({
    required this.taskDatabase,
  });

  @override
  Future<int> addTask(Task task) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllTask() {
    // TODO: implement getAllTask
    throw UnimplementedError();
  }
}
