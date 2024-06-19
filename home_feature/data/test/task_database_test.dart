import 'dart:async';
import 'dart:io';

import 'package:data/data_sources/task_database.dart';
import 'package:isar/isar.dart';
import 'package:shared_data/data.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('test for TaskDatabase', () {
    Directory directory = Directory('./test/isar_database');
    late TaskDatabase taskDatabase;

    setUpAll(() async {
      if (directory.existsSync()) {
        directory.deleteSync(recursive: true);
      }

      directory.createSync();

      await Isar.initializeIsarCore(download: true);

      taskDatabase = TaskDatabase(directory.path);
    });

    test('test for stream listener', () async {
      bool streamUpdate = false;
      final Completer completer = Completer<void>();

      taskDatabase.getTasksChangedWatcher().listen((event) {
        streamUpdate = true;
        completer.complete();
      });

      Isar isar = createIsar(directory.path);

      await isar.writeTxn(() => isar.tasks.put(Task(
          goal: 'test', startDate: DateTime.now(), colorCode: 0xFFFFFFFF)));

      await completer.future;

      expect(streamUpdate, true);
    });

    test('get all task', () async {
      List<Task> tasks = await taskDatabase.getAllTasks();

      expect(tasks.length, 1);
    });

    tearDownAll(() {
      directory.deleteSync(recursive: true);
    });
  });
}
