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
}
