import 'dart:io';

import 'package:data/data.dart';
import 'package:data/entites/task.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

void main() {
  group('task database test', () {
    Directory directory = Directory('./test/isar');
    late TaskDatabase taskDatabase;

    setUpAll(() async {
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

    tearDownAll(() {
      directory.deleteSync(recursive: true);
    });
  });
}
