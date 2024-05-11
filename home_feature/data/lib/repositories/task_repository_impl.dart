import 'package:data/data_sources/task_database.dart';
import 'package:data/mappers/task.dart';
import 'package:domain/domain.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDatabase taskDatabase;

  TaskRepositoryImpl({
    required this.taskDatabase,
  });

  @override
  Future<int> addTask(Task task) {
    return taskDatabase.addTask(task.toEntity());
  }

  @override
  Future<List<Task>> getAllTask() {
    // TODO: implement getAllTask
    throw UnimplementedError();
  }
}
