import 'package:shared_domain/domain.dart';

abstract interface class TaskRepository {
  Future<int> addTask(Task task);
  Future<List<Task>> getTaskOnSelectedDate(DateTime date);
  Future<List<Task>> getAllTasks();
  Future<int> updateCompletedFlag(Task task);
}
