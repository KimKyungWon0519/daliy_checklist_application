class SelectedDate {
  final DateTime startDate;
  final DateTime? endDate;

  const SelectedDate({
    required this.startDate,
    this.endDate,
  });

  factory SelectedDate.empty() => SelectedDate(startDate: DateTime.now());

  SelectedDate copyWith({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return SelectedDate(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  SelectedDate deleteEndDate() {
    return SelectedDate(startDate: startDate);
  }

  @override
  String toString() {
    return 'startDate : $startDate, endDate : $endDate';
  }
}
