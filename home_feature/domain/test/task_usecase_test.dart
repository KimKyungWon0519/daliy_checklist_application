import 'dart:async';

import 'package:domain/usecases/task_usecase.dart';
import 'package:shared_domain/domain.dart';
import 'package:test/test.dart';

class MockGetTask implements GetTask {
  @override
  Stream<void> getTasksChangedWatcher() async* {
    for (int i = 0; i < 1; i++) {
      yield 0;
    }
  }

  @override
  Future<List<Task>> getAllTasks() {
    return Future.value([
      Task(
          goal: 'goal',
          selectedDate: SelectedDate(startDate: DateTime.now()),
          colorCode: 0)
    ]);
  }
}

void main() {
  group('test for GetTask', () {
    final MockGetTask getTask = MockGetTask();

    test('test for stream listener', () async {
      bool streamUpdate = false;
      final Completer completer = Completer<void>();

      getTask.getTasksChangedWatcher().listen((event) {
        streamUpdate = true;
        completer.complete();
      });

      await completer.future;

      expect(streamUpdate, true);
    });

    test('get all task', () async {
      List<Task> tasks = await getTask.getAllTasks();

      expect(tasks.length, 1);
    });
  });
}
