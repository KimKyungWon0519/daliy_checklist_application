import 'package:domain/model/task.dart';

abstract interface class TaskRepository {
  Future<int> addTask(Task task);
  Future<List<Task>> getTaskOnSelectedDate(DateTime date);
  Future<List<Task>> getTaskOnMonth(int year, int month);
}
