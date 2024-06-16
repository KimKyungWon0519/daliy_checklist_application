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

  bool isIncludeDate(DateTime dateTime) {
    int startDateCompare = startDate.compareTo(dateTime);

    if (endDate != null) {
      int endDateCompare = endDate!.compareTo(dateTime);

      return startDateCompare != 1 && endDateCompare != -1;
    } else {
      return startDateCompare == 0;
    }
  }

  int diffDay() {
    if (endDate != null) {
      return startDate.difference(endDate!).abs().inDays + 1;
    } else {
      return 1;
    }
  }

  @override
  String toString() {
    return 'startDate : $startDate, endDate : $endDate';
  }
}
