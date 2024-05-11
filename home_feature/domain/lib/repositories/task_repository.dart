import 'package:domain/model/task.dart';

abstract interface class TaskRepository {
  Future<int> addTask(Task task);
  Future<List<Task>> getAllTask();
}