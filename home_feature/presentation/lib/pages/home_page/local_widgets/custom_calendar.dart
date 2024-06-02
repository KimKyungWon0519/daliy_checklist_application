import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/constants/ui_constants.dart';
import 'package:presentation/pages/home_page/painters/calendar_painter.dart';

class _CalendarProvider extends InheritedWidget {
  final DateTime selectedDateTime;
  final DateTime viewDateTime;
  final Function(DateTime dateTime) onPressedDay;
  final Function(DateTime dateTime) onChangeMonth;
  final MaterialLocalizations localizations;

  const _CalendarProvider({
    required super.child,
    required this.selectedDateTime,
    required this.viewDateTime,
    required this.onPressedDay,
    required this.onChangeMonth,
    required this.localizations,
  });

  static _CalendarProvider? maybeOf(final BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_CalendarProvider>();
  }

  static _CalendarProvider of(final BuildContext context) {
    final _CalendarProvider? result = maybeOf(context);

    assert(result != null, 'No CalendarProvider found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(covariant _CalendarProvider oldWidget) {
    return true;
  }

  String get monthName => localizations.formatMonthYear(viewDateTime);
}

class CustomCalendar extends ConsumerStatefulWidget {
  final StateProvider<DateTime> selectedDateProvider;
  final StateProvider<List<Task>> allTasksProvider;
  final void Function(DateTime selectedDateTime) onPressedDay;

  const CustomCalendar({
    super.key,
    required this.selectedDateProvider,
    required this.allTasksProvider,
    required this.onPressedDay,
  });

  @override
  ConsumerState<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends ConsumerState<CustomCalendar> {
  late DateTime _viewDateTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _viewDateTime = ref.read(widget.selectedDateProvider);
  }

  @override
  Widget build(BuildContext context) {
    final DateTime selectedDateTime = ref.watch(widget.selectedDateProvider);
    final List<Task> tasks = ref.watch(widget.allTasksProvider);

    return _CalendarProvider(
      selectedDateTime: selectedDateTime,
      viewDateTime: _viewDateTime,
      localizations: MaterialLocalizations.of(context),
      onPressedDay: widget.onPressedDay,
      onChangeMonth: (dateTime) {
        setState(() {
          _viewDateTime = dateTime;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _MonthHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 1.5,
            child: _MonthPageView(tasks: tasks),
          ),
        ],
      ),
    );
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader();

  @override
  Widget build(BuildContext context) {
    final _CalendarProvider calendarProvider = _CalendarProvider.of(context);

    return Text(
      calendarProvider.monthName,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _MonthPageView extends StatefulWidget {
  final List<Task> tasks;

  const _MonthPageView({
    super.key,
    required this.tasks,
  });

  @override
  State<_MonthPageView> createState() => _MonthPageViewState();
}

class _MonthPageViewState extends State<_MonthPageView> {
  late final PageController _pageController;
  late final int _dateLength;

  late DateTime _firstDate;
  late DateTime _lastDate;
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();

    _initValue();
  }

  @override
  Widget build(BuildContext context) {
    final _CalendarProvider calendarProvider = _CalendarProvider.of(context);

    return PageView.builder(
      controller: _pageController,
      onPageChanged: (value) => _changeDate(value, calendarProvider),
      itemBuilder: (context, index) => _MonthPanel(
        dateTime: DateUtils.addMonthsToMonthDate(_firstDate, index),
        selectedDateTime: calendarProvider.selectedDateTime,
        tasks: widget.tasks,
      ),
      itemCount: _dateLength,
    );
  }

  void _initValue() {
    _currentDate = DateTime.now();

    int month = _currentDate.month;

    _firstDate = _currentDate.copyWith(month: month - dateRange);
    _lastDate = _currentDate.copyWith(month: month + dateRange);

    _dateLength = DateUtils.monthDelta(_firstDate, _lastDate);

    _pageController = PageController(initialPage: _dateLength ~/ 2);
  }

  void _changeDate(
    final int monthIndex,
    final _CalendarProvider calendarProvider,
  ) {
    final DateTime dateTime =
        DateUtils.addMonthsToMonthDate(_firstDate, monthIndex);

    calendarProvider.onChangeMonth(dateTime);
  }
}

class _MonthPanel extends StatelessWidget {
  final DateTime dateTime;
  final DateTime selectedDateTime;
  final List<Task> tasks;

  const _MonthPanel({
    super.key,
    required this.dateTime,
    required this.selectedDateTime,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    final _CalendarProvider calendarProvider = _CalendarProvider.of(context);

    final CalendarPainter calendarPainter = CalendarPainter(
      dateTime: dateTime,
      localizations: calendarProvider.localizations,
      selectDateTime: selectedDateTime,
      highlightDayColor: Theme.of(context).colorScheme.primary,
      tasks: tasks,
    );

    return GestureDetector(
      onTapUp: (details) {
        DateTime? dateTime = calendarPainter.isClickDay(details.localPosition);

        if (dateTime == null) return;

        calendarProvider.onPressedDay(dateTime);
      },
      child: CustomPaint(
        painter: calendarPainter,
      ),
    );
  }
}
