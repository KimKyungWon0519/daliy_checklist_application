import 'package:flutter/material.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime initialDateTime;

  const CustomCalendar({
    super.key,
    required this.initialDateTime,
  });

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
      mainAxisSize: MainAxisSize.min,
      children: [
        _MonthYeaderHeader(
            _localizations.formatMonthYear(widget.initialDateTime)),
        SizedBox(
          height: MediaQuery.sizeOf(context).height / 2,
          child: PageView(
            children: [
              CustomPaint(
                painter: _CalendarPainter(
                  localizations: MaterialLocalizations.of(context),
                  dateTime: widget.initialDateTime,
                ),
              ),
            ],
          ),
        ),
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

class _CalendarPainter extends CustomPainter {
  final int weekdayHeight = 32;

  final MaterialLocalizations localizations;
  final DateTime dateTime;

  const _CalendarPainter({
    required this.localizations,
    required this.dateTime,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawWeekday(canvas, size);
    _drawDivider(canvas, size);
    _drawDay(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawWeekday(Canvas canvas, Size size) {
    final List<_Weekday> weekday = _getWeekday();
    final int weekdayLength = weekday.length;

    for (int i = 0; i < weekdayLength; i++) {
      final double weekdayWidth = size.width / weekdayLength;
      final double dx = weekdayWidth * i + weekdayWidth / 2;
      final double dy = weekdayHeight / 2;

      weekday[i].paint(canvas, Offset(dx, dy));
    }
  }

  void _drawDay(Canvas canvas, Size size) {
    final List<_Day> day = _getDays();
    final int headerHeigth = weekdayHeight - 10;

    int lineIndex = 0;

    for (int i = 0; i < day.length; i++) {
      if (i % 7 == 0) {
        lineIndex++;
      }

      final double dayWidth = size.width / 7;
      final double dayHeight = (size.height - headerHeigth) / 6;

      final double dx = dayWidth * (i % 7) + dayWidth / 2;
      final double dy = dayHeight * lineIndex;

      day[i].paint(canvas, Offset(dx, dy - headerHeigth));
    }
  }

  void _drawDivider(Canvas canvas, Size size) {
    final double dy = weekdayHeight.toDouble();
    final Offset p1 = Offset(0, dy), p2 = Offset(size.width, dy);
    final Paint paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.grey;

    canvas.drawLine(p1, p2, paint);
  }

  List<_Weekday> _getWeekday() {
    final List<_Weekday> weekday = [];

    for (int i = localizations.firstDayOfWeekIndex;
        weekday.length < DateTime.daysPerWeek;
        i = (i + 1) & DateTime.daysPerWeek) {
      final String dayOfWeek = localizations.narrowWeekdays[i];

      weekday.add(_Weekday(dayOfWeek));
    }

    return weekday;
  }

  List<_Day> _getDays() {
    final List<_Day> days = [];

    final int year = dateTime.year, month = dateTime.month;
    final int maxDayInMonth = DateUtils.getDaysInMonth(year, month);
    final int startDayOffset =
        DateUtils.firstDayOffset(year, month, localizations);

    int currentDay = -startDayOffset + 1;

    while (currentDay <= maxDayInMonth) {
      if (currentDay < 1) {
        days.add(const _Day(''));
      } else {
        days.add(_Day('$currentDay'));
      }

      currentDay++;
    }

    return days;
  }
}

class _Weekday {
  final String name;

  const _Weekday(this.name);

  void paint(Canvas canvas, Offset offset) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: name,
        style: const TextStyle(color: Colors.black),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        offset.dx - textPainter.width / 2,
        offset.dy - textPainter.height / 2,
      ),
    );
  }
}

class _Day {
  final String name;

  const _Day(this.name);

  void paint(Canvas canvas, Offset offset) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: name,
        style: const TextStyle(color: Colors.black),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        offset.dx - textPainter.width / 2,
        offset.dy - textPainter.height / 2,
      ),
    );
  }
}
