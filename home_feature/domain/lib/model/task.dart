import 'package:domain/domain.dart';

class Task {
  final String goal;
  final SelectedDate selectedDate;
  final int colorCode;

  const Task({
    required this.goal,
    required this.selectedDate,
    required this.colorCode,
  });

  factory Task.empty() => Task(
        goal: '',
        selectedDate: SelectedDate.empty(),
        colorCode: 0xFFFFFFFF,
      );

  Task copyWith({
    String? goal,
    SelectedDate? selectedDate,
    int? colorCode,
  }) {
    return Task(
      goal: goal ?? this.goal,
      selectedDate: selectedDate ?? this.selectedDate,
      colorCode: colorCode ?? this.colorCode,
    );
  }

  @override
  String toString() {
    return '(Task)[goal : $goal, selectedDate : $selectedDate]';
  }
}
