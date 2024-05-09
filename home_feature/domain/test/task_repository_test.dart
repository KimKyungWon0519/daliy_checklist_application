import 'package:domain/model/selected_date.dart';
import 'package:domain/model/task.dart';
import 'package:domain/repositories/task_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'task_repository_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  group('test task repository', () {
    TaskRepository taskRepository = MockTaskRepository();

    test('add task', () async {
      final Task task = Task(
        goal: 'goal_1',
        selectedDate: SelectedDate(
          startDate: DateTime.now(),
        ),
      );

      when(taskRepository.addTask(task)).thenAnswer((_) async => 1);

      final int result = await taskRepository.addTask(task);

      expect(result, 1);
    });

    test('get empty tasks', () async {
      when(taskRepository.getAllTask()).thenAnswer((_) async => []);

      final List<Task> tasks = await taskRepository.getAllTask();

      expect(tasks.length, 0);
      expect(tasks, []);
    });

    test('get tasks', () async {
      when(taskRepository.getAllTask()).thenAnswer((_) async => List.generate(
            3,
            (index) => Task(
              goal: '$index',
              selectedDate: SelectedDate(
                startDate: DateTime.now(),
              ),
            ),
          ));

      final List<Task> tasks = await taskRepository.getAllTask();

      expect(tasks.length, 3);
    });
  });
}
