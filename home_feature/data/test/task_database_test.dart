import 'dart:io';

import 'package:data/data.dart';
import 'package:data/entites/task.dart';
import 'package:isar/isar.dart';
import 'package:test/test.dart';

void main() {
  group('task database test', () {
    Directory directory = Directory('./test/isar');
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
        Task task = Task(
          goal: 'test_$i',
          startDate: DateTime.now(),
        );

        int result = await taskDatabase.addTask(task);

        expect(result, i);
      }
    });

    test('get all task', () async {
      List<Task> tasks = await taskDatabase.getAllTask();

      expect(tasks.length, 3);

      for (int i = 0; i < 2; i++) {
        expect(tasks[i].id, i + 1);
      }
    });

    tearDownAll(() {
      directory.deleteSync(recursive: true);
    });
  });
}
