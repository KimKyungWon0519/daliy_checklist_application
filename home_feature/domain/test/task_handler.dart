import 'package:domain/usecases/task_handler.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_domain/models/selected_date.dart';
import 'package:shared_domain/models/task.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'task_handler.mocks.dart';

@GenerateMocks([TaskHandlerUseCase])
void main() {
  group('test for TaskHandlerRepositoryImpl', () {
    final TaskHandlerUseCase taskHandlerUseCase = MockTaskHandlerUseCase();
    DateTime nowTime = DateTime.now();
    nowTime = DateTime(nowTime.year, nowTime.month, nowTime.day);

    List<Task> tasks = List.empty();

    test('Get Today', () {
      when(taskHandlerUseCase.getTodayTasks(tasks)).thenAnswer((_) => [
            Task(
                goal: 'test',
                selectedDate: SelectedDate(startDate: DateTime.now()),
                colorCode: 0),
          ]);

      List<Task> result = taskHandlerUseCase.getTodayTasks(tasks);

      expect(result.length, 1);
    });

    test('Get Postpone', () {
      when(taskHandlerUseCase.getPostponeTasks(tasks)).thenAnswer((_) => [
            Task(
                goal: 'test',
                selectedDate: SelectedDate(startDate: DateTime.now()),
                colorCode: 0),
          ]);

      List<Task> result = taskHandlerUseCase.getPostponeTasks(tasks);

      expect(result.length, 1);
    });

    test('Get Future', () {
      when(taskHandlerUseCase.getFutureTasks(tasks)).thenAnswer((_) => [
            Task(
                goal: 'test',
                selectedDate: SelectedDate(startDate: DateTime.now()),
                colorCode: 0),
          ]);

      List<Task> result = taskHandlerUseCase.getFutureTasks(tasks);

      expect(result.length, 1);
    });

    test('Get Completed', () {
      when(taskHandlerUseCase.getCompletedTasks(tasks)).thenAnswer((_) => [
            Task(
                goal: 'test',
                selectedDate: SelectedDate(startDate: DateTime.now()),
                colorCode: 0),
          ]);

      List<Task> result = taskHandlerUseCase.getCompletedTasks(tasks);

      expect(result.length, 1);
    });
  });
}
