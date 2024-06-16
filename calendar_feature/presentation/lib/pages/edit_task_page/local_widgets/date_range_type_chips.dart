import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateRangePicker extends StatelessWidget {
  final StateProvider<DateType> dateTypeProvider;
  final StateProvider<Task> taskProvider;

  const DateRangePicker({
    super.key,
    required this.dateTypeProvider,
    required this.taskProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _DailyChip(
          dateTypeProvider: dateTypeProvider,
          taskProvider: taskProvider,
        ),
        const SizedBox(width: 10),
        _PeriodChip(
          dateTypeProvider: dateTypeProvider,
          taskProvider: taskProvider,
        ),
      ],
    );
  }
}

class _DailyChip extends StatelessWidget {
  final StateProvider<DateType> dateTypeProvider;
  final StateProvider<Task> taskProvider;

  const _DailyChip({
    super.key,
    required this.dateTypeProvider,
    required this.taskProvider,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseChip(
      label: '하루',
      value: DateType.daily,
      dateTypeProvider: dateTypeProvider,
      taskProvider: taskProvider,
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final StateProvider<DateType> dateTypeProvider;
  final StateProvider<Task> taskProvider;

  const _PeriodChip({
    super.key,
    required this.dateTypeProvider,
    required this.taskProvider,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseChip(
      label: '기간',
      value: DateType.period,
      dateTypeProvider: dateTypeProvider,
      taskProvider: taskProvider,
    );
  }
}

class _BaseChip extends ConsumerWidget {
  final String label;
  final StateProvider<DateType> dateTypeProvider;
  final StateProvider<Task> taskProvider;
  final DateType value;

  const _BaseChip({
    super.key,
    required this.label,
    required this.dateTypeProvider,
    required this.taskProvider,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RawChip(
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      onPressed: () => _changeDateType(ref),
      avatar: Radio(
        value: value,
        groupValue: ref.watch(dateTypeProvider),
        onChanged: (value) => _changeDateType(ref),
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  void _changeDateType(WidgetRef ref) {
    ref.read(dateTypeProvider.notifier).update((state) => value);

    _changeSelectedDate(value, ref);
  }

  void _changeSelectedDate(final DateType type, final WidgetRef ref) {
    switch (type) {
      case DateType.daily:
        ref.read(taskProvider.notifier).update((state) {
          SelectedDate selectedDate = state.selectedDate;

          return state.copyWith(selectedDate: selectedDate.deleteEndDate());
        });
        break;
      case DateType.period:
        ref.read(taskProvider.notifier).update((state) {
          SelectedDate selectedDate = state.selectedDate;
          DateTime endDate =
              selectedDate.startDate.add(const Duration(days: 1));

          return state.copyWith(
              selectedDate: selectedDate.copyWith(endDate: endDate));
        });
        break;
    }
  }
}
