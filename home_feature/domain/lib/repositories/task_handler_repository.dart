import 'package:domain/domain.dart';

abstract interface class TaskHandlerRepository {
  List<Task> getTodayTasks(List<Task> tasks);
}
