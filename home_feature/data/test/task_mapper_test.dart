import 'package:data/mappers/task.dart';
import 'package:domain/domain.dart' as Model;
import 'package:data/entites/task.dart' as Entity;

import 'package:test/test.dart';

void main() {
  group('test task mapper', () {
    test('model To entity', () {
      final Model.Task sourceTask = Model.Task(
        goal: 'test',
        selectedDate: Model.SelectedDate(
          startDate: DateTime(1900),
          endDate: DateTime(2300),
        ),
      );

      final Entity.Task destinationTask = sourceTask.toEntity();

      expect(destinationTask.goal, equals(sourceTask.goal));
      expect(
          destinationTask.startDate, equals(sourceTask.selectedDate.startDate));
      expect(destinationTask.endDate, equals(sourceTask.selectedDate.endDate));
    });
  });
}
