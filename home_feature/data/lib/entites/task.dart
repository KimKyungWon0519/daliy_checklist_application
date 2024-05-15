import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;

  final String goal;
  final DateTime startDate;
  final DateTime? endDate;

  Task({
    required this.goal,
    required this.startDate,
    this.endDate,
  });
}
