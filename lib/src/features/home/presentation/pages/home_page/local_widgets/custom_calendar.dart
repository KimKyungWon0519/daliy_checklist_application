import 'package:daily_checklist_application/src/features/home/presentation/pages/home_page/painters/calendar_painter.dart';
import 'package:flutter/material.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final int maxDateMonth = 100;

  late final PageController _pageController;
  late final int _dateLength;

  late DateTime _firstDate;
  late DateTime _lastDate;
  late DateTime _currentDate;
  late MaterialLocalizations _localizations;

  @override
  void initState() {
    super.initState();

    _initValue();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _localizations = MaterialLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _MonthYeaderHeader(_localizations.formatMonthYear(_currentDate)),
        SizedBox(
          height: MediaQuery.sizeOf(context).height / 1.5,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (value) => _changeDate(value),
            itemBuilder: (context, index) {
              return CustomPaint(
                painter: CalendarPainter(
                  dateTime: DateUtils.addMonthsToMonthDate(_firstDate, index),
                  currentDateTime: _currentDate,
                  localizations: _localizations,
                ),
              );
            },
            itemCount: _dateLength,
          ),
        ),
      ],
    );
  }

  void _initValue() {
    _currentDate = DateTime.now();
    int month = _currentDate.month;

    _firstDate = _currentDate.copyWith(month: month - maxDateMonth);
    _lastDate = _currentDate.copyWith(month: month + maxDateMonth);

    _dateLength = DateUtils.monthDelta(_firstDate, _lastDate);

    _pageController = PageController(initialPage: _dateLength ~/ 2);
  }

  void _changeDate(int monthIndex) {
    DateTime dateTime = DateUtils.addMonthsToMonthDate(_firstDate, monthIndex);

    setState(() {
      _currentDate = dateTime;
    });
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
