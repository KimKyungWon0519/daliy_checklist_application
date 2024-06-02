import 'dart:io';

import 'package:data/data.dart';
import 'package:data/entites/task.dart';
import 'package:isar/isar.dart';
import 'package:test/test.dart';

void main() {
  group('task database test', () {
    Directory directory = Directory('./test/isar_database');
    final DateTime dateTime = DateTime(2024, 5, 1);
    late TaskDatabase taskDatabase;

    setUpAll(() async {
      if (directory.existsSync()) {
        directory.deleteSync(recursive: true);
      }

      directory.createSync();

      await Isar.initializeIsarCore(download: true);

      taskDatabase = TaskDatabase(directory.path);
    });

    test('add 3 task', () async {
      for (int i = 1; i <= 3; i++) {
        Task task =
            Task(goal: 'test_$i', startDate: dateTime, colorCode: 0xFFFFFFFF);

        int result = await taskDatabase.addTask(task);

        expect(result, i);
      }
    });

    test('get task on selected date', () async {
      List<Task> tasks = await taskDatabase.getTaskOnSelectedDate(dateTime);

      expect(tasks.length, 3);

      for (int i = 0; i < 2; i++) {
        expect(tasks[i].id, i + 1);
      }
    });

    test('get task on month', () async {
      int result = 0;
      result = await taskDatabase.addTask(Task(
        goal: 'test_month',
        startDate: DateTime(2024, 4, 1),
        colorCode: 0xFFFFFFFF,
      ));

      expect(result, 4);

      result = await taskDatabase.addTask(Task(
        goal: 'test_month',
        startDate: DateTime(2024, 6, 1),
        colorCode: 0xFFFFFFFF,
      ));

      expect(result, 5);

      List<Task> tasks = await taskDatabase.getAllTasks();

      expect(tasks.length, 5);
    });

    tearDownAll(() {
      directory.deleteSync(recursive: true);
    });
  });
}
