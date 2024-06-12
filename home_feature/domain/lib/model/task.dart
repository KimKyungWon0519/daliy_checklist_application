import 'package:domain/domain.dart';

class Task {
  final int? id;
  final String goal;
  final SelectedDate selectedDate;
  final int colorCode;
  final bool isCompleted;

  const Task({
    this.id,
    required this.goal,
    required this.selectedDate,
    required this.colorCode,
    this.isCompleted = false,
  });

  factory Task.empty() => Task(
        goal: '',
        selectedDate: SelectedDate.empty(),
        colorCode: 0xFFFF0000,
      );

  Task copyWith({
    String? goal,
    SelectedDate? selectedDate,
    int? colorCode,
    bool? isCompleted,
  }) {
    return Task(
      id: id,
      goal: goal ?? this.goal,
      selectedDate: selectedDate ?? this.selectedDate,
      colorCode: colorCode ?? this.colorCode,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return '(Task)[id : $id, goal : $goal, selectedDate : $selectedDate, colorCode : $colorCode, isCompleted : $isCompleted]';
  }
}
