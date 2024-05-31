import 'dart:math';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CalendarPainter extends CustomPainter {
  final int _weekdayHeight = 32;
  final int _weekdayCnt = 7;
  final int _dayLineCnt = 6;

  final MaterialLocalizations localizations;
  final DateTime dateTime;
  final DateTime selectDateTime;

  final List<_DayPanel> _dayPanels = [];

  final Color highlightDayColor;

  final List<Task> tasks;

  bool isUpdateTask = true;
  late final List<_Day> _days;
  late final double _dayWidth;
  late final double _dayHeight;
  late final double _startDayPanelOffset;

  CalendarPainter({
    required this.localizations,
    required this.dateTime,
    required this.selectDateTime,
    required this.highlightDayColor,
    required this.tasks,
  }) {
    _days = _getDays();
  }

  @override
  void paint(Canvas canvas, Size size) {
    _startDayPanelOffset = size.height / _weekdayCnt / 2;
    _dayWidth = size.width / _weekdayCnt;
    _dayHeight = (size.height - _startDayPanelOffset) / _dayLineCnt;

    _drawWeekday(canvas, size);
    _drawDivider(canvas, size);
    _drawDay(canvas, size);
    _drawBarPanels(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CalendarPainter oldDelegate) {
    isUpdateTask = oldDelegate.tasks != tasks;

    return true;
  }

  void _drawWeekday(final Canvas canvas, final Size size) {
    final List<_Weekday> weekday = _getWeekday();
    final int weekdayLength = weekday.length;
    final double weekdayWidth = size.width / weekdayLength;
    final double dy = _weekdayHeight / 2;

    for (int i = 0; i < weekdayLength; i++) {
      final double dx = weekdayWidth * i + weekdayWidth / 2;

      weekday[i].paint(canvas, Offset(dx, dy));
    }
  }

  void _drawDay(final Canvas canvas, final Size size) {
    final double dayTextPadding = _startDayPanelOffset + 10;
    int lineIndex = 0;

    for (int i = 0; i < _days.length; i++) {
      if (i % _weekdayCnt == 0) {
        lineIndex++;
      }

      final double dx = _dayWidth * (i % _weekdayCnt) + _dayWidth / 2;
      final double dy = _dayHeight * (lineIndex - 1);

      _days[i].paint(canvas, Offset(dx, dy + dayTextPadding));

      if (_days[i].isActive) {
        _DayPanel dayPanel = _DayPanel(
          dateTime: dateTime.copyWith(day: _days[i].date.day),
          path: Path()
            ..addRect(
              Rect.fromLTRB(
                  _dayWidth * (i % _weekdayCnt),
                  _startDayPanelOffset + _dayHeight * (lineIndex - 1),
                  _dayWidth * (i % _weekdayCnt) + _dayWidth,
                  _startDayPanelOffset +
                      _dayHeight * (lineIndex - 1) +
                      _dayHeight),
            ),
        );

        _dayPanels.add(dayPanel);
      }
    }
  }

  void _drawDivider(final Canvas canvas, final Size size) {
    final double dy = _weekdayHeight.toDouble();
    final Offset p1 = Offset(0, dy), p2 = Offset(size.width, dy);
    final Paint paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.grey;

    canvas.drawLine(p1, p2, paint);
  }

  List<_BarPanel> _getBarPanels() {
    List<_BarPanel> barPanels =
        List.generate(_days.length, (index) => _BarPanel(bars: []));
    List<Task> isCheckTasks = [];

    for (int i = 0; i < _days.length; i++) {
      int barCount = 0;
      _BarPanel barPanel = barPanels[i];
      List<int> isAlreadyBarIndexs = barPanel.isAlreadyBarIndexs;

      DateTime dateTime = _days[i].date;

      List<Task> dateTask = tasks
          .where((element) => element.selectedDate.isIncludeDate(dateTime))
          .toList()
        ..sort(
          (a, b) =>
              a.selectedDate.diffDay().compareTo(a.selectedDate.diffDay()),
        );

      if (dateTask.isEmpty) continue;

      dateTask.removeWhere((element) => isCheckTasks.contains(element));

      for (int j = 0; j < dateTask.length; j++) {
        Task task = dateTask[j];

        while (true) {
          if (!isAlreadyBarIndexs.contains(barCount)) {
            break;
          }

          barCount++;
        }

        if (barCount >= 4) {
          barPanel.isMore = true;

          isCheckTasks.addAll(dateTask.sublist(j));

          List<Task> leftTask = dateTask.sublist(j);

          for (Task task in leftTask) {
            int diffDay = task.selectedDate.diffDay() -
                (task.selectedDate.startDate.difference(dateTime).abs().inDays);

            for (int k = 0; k < diffDay; k++) {
              barPanels[i + k].isMore = true;
            }
          }

          break;
        }

        int diffDay = task.selectedDate.diffDay() -
            (task.selectedDate.startDate.difference(dateTime).abs().inDays);
        _Bar bar = _Bar(
          barCount: barCount,
          task: task,
        );

        for (int k = 0; k < diffDay; k++) {
          bar.isStartDate = task.selectedDate.startDate
                  .compareTo(dateTime.add(Duration(days: k))) ==
              0;
          bar.isEndDate = task.selectedDate.endDate != null
              ? task.selectedDate.endDate!
                      .compareTo(dateTime.add(Duration(days: k))) ==
                  0
              : true;

          barPanels[i + k].bars.add(bar.copy());
        }

        isCheckTasks.add(task);
        barCount++;
      }
    }

    return barPanels;
  }

  void _drawBarPanels(final Canvas canvas, final Size size) {
    final double startBarYOffset = _startDayPanelOffset + 32;
    const int barSize = 10;
    const int barVerticalPadding = 8;
    const int barHorizontal = 2;

    List<_BarPanel> barPanels = _getBarPanels();
    int lineIndex = 0;

    for (int i = 0; i < barPanels.length; i++) {
      if (i % _weekdayCnt == 0) {
        lineIndex++;
      }

      _BarPanel barPanel = barPanels[i];
      List<_Bar> bars = barPanel.bars;

      for (int j = 0; j < bars.length; j++) {
        _Bar bar = bars[j];

        final defaultDayWidth = _dayWidth * (i % _weekdayCnt);
        final defaultDayHeight = _dayHeight * (lineIndex - 1) +
            barSize * bar.barCount +
            startBarYOffset;

        bar.paint(
          canvas,
          left: defaultDayWidth + (bar.isStartDate ? barHorizontal : 0),
          top: defaultDayHeight,
          right: defaultDayWidth +
              _dayWidth +
              (bar.isEndDate ? -barHorizontal : 0),
          bottom: defaultDayHeight + barVerticalPadding,
        );
      }

      if (barPanel.isMore) {
        _MoreCircle().paint(
          canvas,
          dx: _dayWidth * (i % _weekdayCnt) + _dayWidth / 2,
          dy: _dayHeight * (lineIndex - 1) +
              startBarYOffset +
              barSize * 4 +
              barVerticalPadding / 2,
        );
      }
    }
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

    while (currentDay < _dayLineCnt * _weekdayCnt) {
      if (currentDay < 1) {
        days.insert(
            0,
            _Day.isInactive(
                date: DateTime(
                    previousYear, previousMonth, maxDayInPreviousMonth--)));
      } else if (currentDay <= maxDayInMonth) {
        days.add(_Day.isActive(
          date: DateTime(dateTime.year, dateTime.month, currentDay),
          isCurrent: DateUtils.isSameDay(
              DateTime.now(), dateTime.copyWith(day: currentDay)),
          isSelect: DateUtils.isSameDay(
              dateTime.copyWith(day: currentDay), selectDateTime),
          highlightDayColor: highlightDayColor,
        ));
      } else {
        days.add(_Day.isInactive(
            date: DateTime(dateTime.year, dateTime.month + 1,
                currentDay - maxDayInMonth)));
      }

      currentDay++;
    }

    return days;
  }

  DateTime? isClickDay(final Offset position) {
    for (_DayPanel dayPanel in _dayPanels) {
      if (dayPanel.path.contains(position)) {
        return dayPanel.dateTime;
      }
    }

    return null;
  }
}

class _Weekday {
  final String name;

  const _Weekday(this.name);

  void paint(final Canvas canvas, final Offset offset) {
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
  final DateTime date;
  final Color color;
  final bool isCurrent;
  final bool isSelect;
  final bool isActive;
  final Color highlightDayColor;

  const _Day(
    this.date, {
    required this.color,
    required this.isCurrent,
    required this.isActive,
    required this.isSelect,
    this.highlightDayColor = Colors.transparent,
  });

  factory _Day.isActive({
    required DateTime date,
    required bool isCurrent,
    required bool isSelect,
    required Color highlightDayColor,
  }) =>
      _Day(
        date,
        color: Colors.black,
        isCurrent: isCurrent,
        isSelect: isSelect,
        isActive: true,
        highlightDayColor: highlightDayColor,
      );

  factory _Day.isInactive({
    required DateTime date,
  }) =>
      _Day(
        date,
        color: Colors.grey,
        isCurrent: false,
        isSelect: false,
        isActive: false,
      );

  void paint(final Canvas canvas, final Offset offset) {
    Color color = this.color;

    if (isSelect) {
      color = Colors.white;
    } else if (isCurrent) {
      color = highlightDayColor;
    }

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: date.day.toString(),
        style: TextStyle(
          color: color,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    if (isSelect) {
      canvas.drawCircle(
          Offset(
            offset.dx,
            offset.dy + textPainter.height / 2,
          ),
          textPainter.height,
          Paint()..color = highlightDayColor);
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

  bool isSelect(final Offset position) => path.contains(position);
}

class _MoreCircle {
  final int _size = 10;
  final Color _color = Colors.grey[300]!;

  _MoreCircle();

  void paint(
    final Canvas canvas, {
    required double dx,
    required double dy,
  }) {
    canvas.drawCircle(
      Offset(
        dx,
        dy,
      ),
      _size / 2,
      Paint()..color = _color,
    );
  }
}

class _BarPanel {
  List<_Bar> bars;
  bool isMore;

  _BarPanel({
    required this.bars,
    this.isMore = false,
  });

  List<int> get isAlreadyBarIndexs => bars.map((e) => e.barCount).toList();
}

class _Bar {
  final double _radius = 5;

  final int barCount;
  final Task task;

  bool isStartDate;
  bool isEndDate;

  _Bar({
    required this.barCount,
    required this.task,
    this.isStartDate = false,
    this.isEndDate = false,
  });

  void paint(
    final Canvas canvas, {
    required final double left,
    required final double top,
    required final double right,
    required final double bottom,
  }) {
    Radius startCorner = Radius.circular(isStartDate ? _radius : 0);
    Radius endCorner = Radius.circular(isEndDate ? _radius : 0);

    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          left,
          top,
          right,
          bottom,
          topLeft: startCorner,
          bottomLeft: startCorner,
          topRight: endCorner,
          bottomRight: endCorner,
        ),
        Paint()..color = Color(task.colorCode));
  }

  _Bar copy() {
    return _Bar(
      barCount: barCount,
      task: task,
      isEndDate: isEndDate,
      isStartDate: isStartDate,
    );
  }
}
