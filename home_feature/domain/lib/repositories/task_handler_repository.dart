import 'package:domain/domain.dart';

abstract interface class TaskHandlerRepository {
  List<Task> getTodayTasks(List<Task> tasks);
  List<Task> getPostponeTasks(List<Task> tasks);
  List<Task> getFutureTasks(List<Task> tasks);
}
