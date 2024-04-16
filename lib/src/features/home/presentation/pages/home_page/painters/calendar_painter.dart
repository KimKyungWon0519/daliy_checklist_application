import 'dart:developer';

import 'package:flutter/material.dart';

class CalendarPainter extends CustomPainter {
  final int weekdayHeight = 32;

  final MaterialLocalizations localizations;
  final DateTime dateTime;
  final DateTime currentDateTime;
  final DateTime selectDateTime;

  final List<_DayPanel> _dayPanels = [];

  CalendarPainter({
    required this.localizations,
    required this.dateTime,
    required this.currentDateTime,
    required this.selectDateTime,
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

  @override
  bool? hitTest(Offset position) {
    for (_DayPanel dayPanel in _dayPanels) {
      if (dayPanel.isSelect(position)) {
        log('datetime : ${dayPanel.dateTime}');
      }
    }

    return super.hitTest(position);
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
      }

      final double dayWidth = size.width / 7;
      final double dayHeight = (size.height - startDayPanelOffset) / 6;

      final double dx = dayWidth * (i % 7) + dayWidth / 2;
      final double dy = dayHeight * (lineIndex - 1);

      if (day[i].isSelect) {
        canvas.drawRRect(
            RRect.fromLTRBR(
              dayWidth * (i % 7),
              startDayPanelOffset + dayHeight * (lineIndex - 1),
              dayWidth * (i % 7) + dayWidth,
              startDayPanelOffset + dayHeight * (lineIndex - 1) + dayHeight,
              const Radius.circular(5),
            ),
            Paint()..color = Colors.grey[300]!);
      }

      day[i].paint(canvas, Offset(dx, startDayPanelOffset + dy + 10));

      if (day[i].isActive) {
        _DayPanel dayPanel = _DayPanel(
          dateTime: dateTime.copyWith(day: int.parse(day[i].name)),
          path: Path()
            ..addRect(
              Rect.fromLTRB(
                  dayWidth * (i % 7),
                  startDayPanelOffset + dayHeight * (lineIndex - 1),
                  dayWidth * (i % 7) + dayWidth,
                  startDayPanelOffset +
                      dayHeight * (lineIndex - 1) +
                      dayHeight),
            ),
        );

        _dayPanels.add(dayPanel);
      }
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
        days.insert(0, _Day.isInactive(name: '${maxDayInPreviousMonth--}'));
      } else if (currentDay <= maxDayInMonth) {
        days.add(_Day.isActive(
          name: '$currentDay',
          isCurrent: DateUtils.isSameDay(
              DateTime.now(), dateTime.copyWith(day: currentDay)),
          isSelect: DateUtils.isSameDay(
              dateTime.copyWith(day: currentDay), selectDateTime),
        ));
      } else {
        days.add(_Day.isInactive(name: '${currentDay - maxDayInMonth}'));
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
  final bool isCurrent;
  final bool isSelect;
  final bool isActive;

  const _Day(
    this.name, {
    required this.color,
    required this.isCurrent,
    required this.isActive,
    required this.isSelect,
  });

  factory _Day.isActive({
    required String name,
    required bool isCurrent,
    required bool isSelect,
  }) =>
      _Day(
        name,
        color: Colors.black,
        isCurrent: isCurrent,
        isSelect: isSelect,
        isActive: true,
      );

  factory _Day.isInactive({
    required String name,
  }) =>
      _Day(
        name,
        color: Colors.grey,
        isCurrent: false,
        isSelect: false,
        isActive: false,
      );

  void paint(Canvas canvas, Offset offset) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: name,
        style: TextStyle(color: isCurrent ? Colors.white : color),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    if (isCurrent) {
      canvas.drawCircle(
          Offset(
            offset.dx,
            offset.dy + textPainter.height / 2,
          ),
          textPainter.height,
          Paint()..color = Colors.teal);
    }

    textPainter.paint(
      canvas,
      Offset(
        offset.dx - textPainter.width / 2,
        offset.dy,
      ),
    );
  }
}

class _DayPanel {
  final Path path;
  final DateTime dateTime;

  _DayPanel({
    required this.path,
    required this.dateTime,
  });

  bool isSelect(Offset position) => path.contains(position);
}
