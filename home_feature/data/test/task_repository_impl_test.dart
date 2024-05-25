import 'dart:io';

import 'package:data/data_sources/task_database.dart';
import 'package:data/repositories/task_repository_impl.dart';
import 'package:domain/domain.dart';
import 'package:isar/isar.dart';
import 'package:test/test.dart';

void main() {
  group('task repository impl test', () {
    Directory directory = Directory('./test/isar_repository');
    final DateTime date = DateTime(2024, 5, 1);
    late TaskDatabase taskDatabase;
    late TaskRepositoryImpl taskRepositoryImpl;

    setUpAll(() async {
      if (directory.existsSync()) {
        directory.deleteSync(recursive: true);
      }

      directory.createSync();

      await Isar.initializeIsarCore(download: true);

      taskDatabase = TaskDatabase(directory.path);
      taskRepositoryImpl = TaskRepositoryImpl(taskDatabase: taskDatabase);
    });

    test('add 3 task', () async {
      for (int i = 1; i <= 3; i++) {
        Task task = Task(
          goal: 'test_$i',
          selectedDate: SelectedDate(
            startDate: date,
          ),
        );

        int result = await taskRepositoryImpl.addTask(task);

        expect(result, i);
      }
    });

    test('get task on selected date', () async {
      List<Task> tasks = await taskRepositoryImpl.getTaskOnSelectedDate(date);

      for (int i = 0; i < 2; i++) {
        expect(tasks[i].goal, equals('test_${i + 1}'));
      }
    });

    test('get task on month', () async {
      int result = 0;
      result = await taskRepositoryImpl.addTask(Task(
        goal: 'test1',
        selectedDate: SelectedDate(
          startDate: DateTime(2024, 4),
        ),
      ));

      expect(result, 4);

      result = await taskRepositoryImpl.addTask(Task(
        goal: 'test2',
        selectedDate: SelectedDate(
          startDate: DateTime(2024, 6),
        ),
      ));

      expect(result, 5);

      List<Task> tasks = await taskRepositoryImpl.getTaskOnMonth(2024, 5);

      expect(tasks.length, 3);
    });

    tearDownAll(() {
      directory.deleteSync(recursive: true);
    });
  });
}
