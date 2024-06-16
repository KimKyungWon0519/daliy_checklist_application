import 'package:data/mappers/task.dart';
import 'package:domain/domain.dart' as Model;
import 'package:shared_data/shared_data.dart' as Entity;

import 'package:test/test.dart';

void main() {
  group('test task mapper', () {
    test('model to entity', () {
      final Model.Task sourceTask = Model.Task(
        goal: 'test',
        selectedDate: Model.SelectedDate(
          startDate: DateTime(1900),
          endDate: DateTime(2300),
        ),
        colorCode: 0xFFFFFFFF,
      );

      final Entity.Task destinationTask = sourceTask.toEntity();

      expect(destinationTask.goal, equals(sourceTask.goal));
      expect(
          destinationTask.startDate, equals(sourceTask.selectedDate.startDate));
      expect(destinationTask.endDate, equals(sourceTask.selectedDate.endDate));
    });

    test('entity to model', () {
      final Entity.Task sourceTask = Entity.Task(
        goal: 'test',
        startDate: DateTime(1900),
        endDate: DateTime(2300),
        colorCode: 0xFFFFFFFF,
      );

      final Model.Task destinationTask = sourceTask.toModel();

      expect(destinationTask.goal, equals(sourceTask.goal));
      expect(
          destinationTask.selectedDate.startDate, equals(sourceTask.startDate));
      expect(destinationTask.selectedDate.endDate, equals(sourceTask.endDate));
    });
  });
}
