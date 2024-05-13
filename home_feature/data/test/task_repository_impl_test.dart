import 'dart:io';

import 'package:data/data.dart';
import 'package:data/repositories/task_repository_impl.dart';
import 'package:domain/domain.dart';
import 'package:isar/isar.dart';
import 'package:test/test.dart';

void main() {
  group('task repository impl test', () {
    Directory directory = Directory('./test/isar');
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
            startDate: DateTime.now(),
          ),
        );

        int result = await taskRepositoryImpl.addTask(task);

        expect(result, i);
      }
    });

    tearDownAll(() {
      directory.deleteSync(recursive: true);
    });
  });
}
