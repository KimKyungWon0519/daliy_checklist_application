import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  final Id id = Isar.autoIncrement;

  final String goal;
  final DateTime startDate;
  final DateTime? endDate;

  const Task({
    required this.goal,
    required this.startDate,
    this.endDate,
  });
}
