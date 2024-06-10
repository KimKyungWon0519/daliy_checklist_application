import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;

  final String goal;
  final DateTime startDate;
  final DateTime? endDate;
  final int colorCode;
  final bool isCompleted;

  Task({
    required this.goal,
    required this.startDate,
    required this.colorCode,
    this.endDate,
    this.isCompleted = false,
  });
}
