import 'package:domain/domain.dart';

class TaskHandlerRepositoryImpl implements TaskHandlerRepository {
  @override
  List<Task> getTodayTasks(List<Task> tasks) {
    DateTime nowTime = DateTime.now();
    nowTime = DateTime(nowTime.year, nowTime.month, nowTime.day);

    return tasks.where((element) {
      return element.selectedDate.isIncludeDate(nowTime);
    }).toList();
  }

  @override
  List<Task> getPostponeTasks(List<Task> tasks) {
    DateTime nowTime = DateTime.now();
    nowTime = DateTime(nowTime.year, nowTime.month, nowTime.day);

    return tasks.where((element) {
      DateTime time =
          element.selectedDate.endDate ?? element.selectedDate.startDate;

      return nowTime.compareTo(time) == -1;
    }).toList();
  }

  @override
  List<Task> getFutureTasks(List<Task> tasks) {
    DateTime nowTime = DateTime.now();
    nowTime = DateTime(nowTime.year, nowTime.month, nowTime.day);

    return tasks.where((element) {
      DateTime time =
          element.selectedDate.endDate ?? element.selectedDate.startDate;

      return nowTime.compareTo(time) == 1;
    }).toList();
  }
}
