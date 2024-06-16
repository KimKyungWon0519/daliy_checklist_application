import 'dart:io';

import 'package:data/data_sources/task_database.dart';
import 'package:data/repositories/task_repository_impl.dart';
import 'package:isar/isar.dart';
import 'package:domain/domain.dart';
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
          colorCode: 0xFFFFFFFF,
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
        colorCode: 0xFFFFFFFF,
      ));

      expect(result, 4);

      result = await taskRepositoryImpl.addTask(Task(
        goal: 'test2',
        selectedDate: SelectedDate(
          startDate: DateTime(2024, 6),
        ),
        colorCode: 0xFFFFFFFF,
      ));

      expect(result, 5);

      List<Task> tasks = await taskRepositoryImpl.getAllTasks();

      expect(tasks.length, 5);
    });

    tearDownAll(() {
      directory.deleteSync(recursive: true);
    });
  });
}
