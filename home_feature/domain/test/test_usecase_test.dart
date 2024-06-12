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
    final DateTime dateTime = DateTime.now();
    final TaskRepository taskRepository = MockTaskRepository();
    final GetTask getTask = GetTask(taskRepository: taskRepository);

    test('Test empty get all', () async {
      when(getTask.getTaskOnSelectedDate(dateTime)).thenAnswer((_) async => []);

      List<Task> tasks = await getTask.getTaskOnSelectedDate(dateTime);

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
          colorCode: 0xFFFFFFFF,
        ),
      );

      when(getTask.getTaskOnSelectedDate(dateTime))
          .thenAnswer((_) async => sourceTasks);

      final List<Task> tasks = await getTask.getTaskOnSelectedDate(dateTime);

      expect(tasks.length, 3);
      expect(tasks, equals(sourceTasks));
    });
  });

  test('add task', () async {
    final TaskRepository taskRepository = MockTaskRepository();
    final AddTask addTask = AddTask(taskRepository: taskRepository);

    final Task task = Task(
      goal: 'goal_1',
      selectedDate: SelectedDate(
        startDate: DateTime.now(),
      ),
      colorCode: 0xFFFFFFFF,
    );

    when(taskRepository.addTask(task)).thenAnswer((_) async => 1);

    final int result = await addTask.addTask(task);

    expect(result, 1);
  });
}
