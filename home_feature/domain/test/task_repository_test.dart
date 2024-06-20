import 'dart:async';

import 'package:domain/domain.dart' as Domain;
import 'package:domain/repositories/task_repository.dart';
import 'package:shared_domain/models/selected_date.dart';
import 'package:shared_domain/models/task.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class MockTaskRepository implements TaskRepository {
  @override
  Stream<void> getTasksChangedWatcher() async* {
    for (int i = 0; i < 1; i++) {
      yield 0;
    }
  }

  @override
  Future<List<Domain.Task>> getAllTasks() {
    return Future.value([
      Task(
          goal: 'goal',
          selectedDate: SelectedDate(startDate: DateTime.now()),
          colorCode: 0)
    ]);
  }
}

void main() {
  group('test for TaskRepository', () {
    final MockTaskRepository taskRepository = MockTaskRepository();

    test('test for stream listener', () async {
      bool streamUpdate = false;
      final Completer completer = Completer<void>();

      taskRepository.getTasksChangedWatcher().listen((event) {
        streamUpdate = true;
        completer.complete();
      });

      await completer.future;

      expect(streamUpdate, true);
    });

    test('get all task', () async {
      List<Domain.Task> tasks = await taskRepository.getAllTasks();

      expect(tasks.length, 1);
    });
  });
}
