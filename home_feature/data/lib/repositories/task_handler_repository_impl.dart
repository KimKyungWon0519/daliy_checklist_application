import 'package:domain/domain.dart';

class TaskHandlerRepositoryImpl implements TaskHandlerRepository {
  @override
  List<Task> getTodayTasks(List<Task> tasks) {
    DateTime nowTime = DateTime.now();
    nowTime = DateTime(nowTime.year, nowTime.month, nowTime.day);

    tasks = tasks.where((element) {
      return element.selectedDate.isIncludeDate(nowTime);
    }).toList();

    return _removeCompletedTask(tasks);
  }

  @override
  List<Task> getPostponeTasks(List<Task> tasks) {
    DateTime nowTime = DateTime.now();
    nowTime = DateTime(nowTime.year, nowTime.month, nowTime.day);

    tasks = tasks.where((element) {
      DateTime time = element.selectedDate.startDate;

      return nowTime.compareTo(time) == -1;
    }).toList();

    return _removeCompletedTask(tasks);
  }

  @override
  List<Task> getFutureTasks(List<Task> tasks) {
    DateTime nowTime = DateTime.now();
    nowTime = DateTime(nowTime.year, nowTime.month, nowTime.day);

    tasks = tasks.where((element) {
      DateTime time =
          element.selectedDate.endDate ?? element.selectedDate.startDate;

      return nowTime.compareTo(time) == 1;
    }).toList();

    return _removeCompletedTask(tasks);
  }

  @override
  List<Task> getCompletedTasks(List<Task> tasks) {
    return tasks.where((element) => element.isCompleted).toList();
  }

  List<Task> _removeCompletedTask(List<Task> tasks) {
    return tasks.where((element) => !element.isCompleted).toList();
  }
}
