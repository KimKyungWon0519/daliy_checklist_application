import 'package:domain/model/selected_date.dart';
import 'package:domain/model/task.dart';
import 'package:domain/repositories/task_repository.dart';
import 'package:domain/usecases/task_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'test_usecase_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  group('Test Get Task usecase', () {
    final TaskRepository taskRepository = MockTaskRepository();
    final GetTask getTask = GetTask(taskRepository);

    test('Test empty get all', () async {
      when(getTask.getAllTask()).thenAnswer((_) async => []);

      List<Task> tasks = await getTask.getAllTask();

      expect(tasks.length, 0);
      expect(tasks, []);
    });

    test('Test get 3 tasks', () async {
      List<Task> sourceTasks = List.generate(
        3,
        (index) => Task(
          goal: '$index',
          selectedDate: SelectedDate(
            startDate: DateTime.now(),
          ),
        ),
      );

      when(getTask.getAllTask()).thenAnswer((_) async => sourceTasks);

      final List<Task> tasks = await getTask.getAllTask();

      expect(tasks.length, 3);
      expect(tasks, equals(sourceTasks));
    });
  });
}
