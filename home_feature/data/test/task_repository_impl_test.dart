import 'dart:async';
import 'dart:io';

import 'package:data/data_sources/task_database.dart';
import 'package:data/repositories/task_repository_impl.dart';
import 'package:domain/domain.dart' as Domain;
import 'package:isar/isar.dart';
import 'package:shared_data/data.dart' as SharedData;
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('test for TaskRepositoryImpl', () {
    Directory directory = Directory('./test/isar_database');

    late TaskRepositoryImpl taskRepositoryImpl;

    setUpAll(() async {
      if (directory.existsSync()) {
        directory.deleteSync(recursive: true);
      }

      directory.createSync();

      await Isar.initializeIsarCore(download: true);

      TaskDatabase taskDatabase = TaskDatabase(directory.path);

      taskRepositoryImpl = TaskRepositoryImpl(taskDatabase: taskDatabase);
    });

    test('test for stream listener', () async {
      bool streamUpdate = false;
      final Completer completer = Completer<void>();

      taskRepositoryImpl.getTasksChangedWatcher().listen((event) {
        streamUpdate = true;
        completer.complete();
      });

      Isar isar = SharedData.createIsar(directory.path);

      await isar.writeTxn(() => isar.tasks.put(SharedData.Task(
          goal: 'test', startDate: DateTime.now(), colorCode: 0xFFFFFFFF)));

      await completer.future;

      expect(streamUpdate, true);
    });

    test('get all task', () async {
      List<Domain.Task> tasks = await taskRepositoryImpl.getAllTasks();

      expect(tasks.length, 1);
    });

    tearDownAll(() {
      directory.deleteSync(recursive: true);
    });
  });
}
