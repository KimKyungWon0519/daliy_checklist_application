import 'package:flutter/material.dart';

class CalendarPainter extends CustomPainter {
  final int weekdayHeight = 32;

  final MaterialLocalizations localizations;
  final DateTime dateTime;

  CalendarPainter({
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
    final double startDayPanelOffset = size.height / 7 / 2;

    int lineIndex = 0;

    for (int i = 0; i < day.length; i++) {
      if (i % 7 == 0) {
        lineIndex++;
      } else {}

      final double dayWidth = size.width / 7;
      final double dayHeight = (size.height - startDayPanelOffset) / 6;

      final double dx = dayWidth * (i % 7) + dayWidth / 2;
      final double dy = dayHeight * (lineIndex - 1);

      day[i].paint(canvas, Offset(dx, startDayPanelOffset + dy));
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

    int previousMonth = month - 1;
    int previousYear = year;

    if (previousMonth < 1) {
      previousMonth = 12;
      previousYear--;
    }

    int maxDayInPreviousMonth =
        DateUtils.getDaysInMonth(previousYear, previousMonth);

    int currentDay = -startDayOffset + 1;

    while (currentDay < 6 * 7) {
      if (currentDay < 1) {
        days.insert(
            0,
            _Day(
              '${maxDayInPreviousMonth--}',
              color: Colors.grey,
            ));
      } else if (currentDay <= maxDayInMonth) {
        days.add(_Day('$currentDay'));
      } else {
        days.add(_Day(
          '${currentDay - maxDayInMonth}',
          color: Colors.grey,
        ));
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
  final Color color;

  const _Day(
    this.name, {
    this.color = Colors.black,
  });

  void paint(Canvas canvas, Offset offset) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: name,
        style: TextStyle(color: color),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        offset.dx - textPainter.width / 2,
        offset.dy + 5,
      ),
    );
  }
}
