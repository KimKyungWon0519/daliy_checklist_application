import 'package:flutter/material.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late MaterialLocalizations _localizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _localizations = MaterialLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return _MonthYeaderHeader(_localizations.formatMonthYear(DateTime.now()));
  }
}

class _MonthYeaderHeader extends StatelessWidget {
  final String title;

  const _MonthYeaderHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
