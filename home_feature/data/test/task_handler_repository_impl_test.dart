import 'package:domain/domain.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

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

void main() {
  group('test for TaskHandlerRepositoryImpl', () {
    final TaskHandlerRepositoryImpl taskHandlerRepositoryImpl =
        TaskHandlerRepositoryImpl();

    DateTime nowTime = DateTime.now();
    nowTime = DateTime(nowTime.year, nowTime.month, nowTime.day);

    List<Task> tasks = [
      Task(
        goal: 'test',
        selectedDate: SelectedDate(startDate: nowTime),
        colorCode: 0,
      ),
      Task(
        goal: 'test',
        selectedDate: SelectedDate(
            startDate: nowTime.subtract(Duration(days: 1)),
            endDate: nowTime.add(Duration(days: 1))),
        colorCode: 0,
      ),
      Task(
        goal: 'test',
        selectedDate:
            SelectedDate(startDate: nowTime.subtract(Duration(days: 1))),
        colorCode: 0,
      ),
      Task(
        goal: 'test',
        selectedDate: SelectedDate(
            startDate: nowTime.subtract(Duration(days: 2)),
            endDate: nowTime.subtract(Duration(days: 1))),
        colorCode: 0,
      ),
      Task(
        goal: 'test',
        selectedDate: SelectedDate(startDate: nowTime.add(Duration(days: 1))),
        colorCode: 0,
      ),
      Task(
        goal: 'test',
        selectedDate: SelectedDate(
            startDate: nowTime.add(Duration(days: 1)),
            endDate: nowTime.add(Duration(days: 2))),
        colorCode: 0,
      ),
      Task(
        goal: 'test',
        selectedDate: SelectedDate(startDate: nowTime),
        colorCode: 0,
        isCompleted: true,
      ),
    ];

    test('Get Today', () {
      List<Task> result = taskHandlerRepositoryImpl.getTodayTasks(tasks);

      expect(result.length, 2);
    });

    test('Get Postpone', () {
      List<Task> result = taskHandlerRepositoryImpl.getPostponeTasks(tasks);

      expect(result.length, 2);
    });

    test('Get Future', () {
      List<Task> result = taskHandlerRepositoryImpl.getFutureTasks(tasks);

      expect(result.length, 2);
    });

    test('Get Completed', () {
      List<Task> result = taskHandlerRepositoryImpl.getCompletedTasks(tasks);

      expect(result.length, 1);
    });
  });
}
