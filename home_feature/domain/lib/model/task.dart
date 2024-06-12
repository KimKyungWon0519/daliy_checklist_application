import 'package:domain/domain.dart';

class Task {
  final String goal;
  final SelectedDate selectedDate;

  const Task({
    required this.goal,
    required this.selectedDate,
  });

  factory Task.empty() => Task(
        goal: '',
        selectedDate: SelectedDate.empty(),
      );

  Task copyWith({String? goal, SelectedDate? selectedDate}) {
    return Task(
      goal: goal ?? this.goal,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  String toString() {
    return 'goal : $goal, selectedDate : $selectedDate';
  }
}
