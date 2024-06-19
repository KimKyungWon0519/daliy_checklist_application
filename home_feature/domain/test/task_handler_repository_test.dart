import 'package:domain/repositories/task_handler_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_domain/models/selected_date.dart';
import 'package:shared_domain/models/task.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'task_handler_repository_test.mocks.dart';

@GenerateMocks([TaskHandlerRepository])
void main() {
  group('test for TaskHandlerRepositoryImpl', () {
    final TaskHandlerRepository taskHandlerRepository =
        MockTaskHandlerRepository();
    DateTime nowTime = DateTime.now();
    nowTime = DateTime(nowTime.year, nowTime.month, nowTime.day);

    List<Task> tasks = List.empty();

    test('Get Today', () {
      when(taskHandlerRepository.getTodayTasks(tasks)).thenAnswer((_) => [
            Task(
                goal: 'test',
                selectedDate: SelectedDate(startDate: DateTime.now()),
                colorCode: 0),
          ]);

      List<Task> result = taskHandlerRepository.getTodayTasks(tasks);

      expect(result.length, 1);
    });

    test('Get Postpone', () {
      when(taskHandlerRepository.getPostponeTasks(tasks)).thenAnswer((_) => [
            Task(
                goal: 'test',
                selectedDate: SelectedDate(startDate: DateTime.now()),
                colorCode: 0),
          ]);

      List<Task> result = taskHandlerRepository.getPostponeTasks(tasks);

      expect(result.length, 1);
    });

    test('Get Future', () {
      when(taskHandlerRepository.getFutureTasks(tasks)).thenAnswer((_) => [
            Task(
                goal: 'test',
                selectedDate: SelectedDate(startDate: DateTime.now()),
                colorCode: 0),
          ]);

      List<Task> result = taskHandlerRepository.getFutureTasks(tasks);

      expect(result.length, 1);
    });

    test('Get Completed', () {
      when(taskHandlerRepository.getCompletedTasks(tasks)).thenAnswer((_) => [
            Task(
                goal: 'test',
                selectedDate: SelectedDate(startDate: DateTime.now()),
                colorCode: 0),
          ]);

      List<Task> result = taskHandlerRepository.getCompletedTasks(tasks);

      expect(result.length, 1);
    });
  });
}
