import 'dart:developer';

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
    return Column(
      children: [
        _MonthYeaderHeader(_localizations.formatMonthYear(DateTime.now())),
        const SizedBox(height: 16),
        _Weekday(),
      ],
    );
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

class _Weekday extends StatelessWidget {
  const _Weekday({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _getWeekday(context),
    );
  }

  List<Widget> _getWeekday(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final List<Widget> weekday = [];

    for (int i = localizations.firstDayOfWeekIndex;
        weekday.length < DateTime.daysPerWeek;
        i = (i + 1) & DateTime.daysPerWeek) {
      final String dayOfWeek = localizations.narrowWeekdays[i];

      weekday.add(
        Text(
          dayOfWeek,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }

    return weekday;
  }
}
