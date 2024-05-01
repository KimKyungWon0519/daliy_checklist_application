import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateRangePicker extends StatelessWidget {
  final StateProvider<DateType> dateTypeProvider;
  final StateProvider<SelectedDate> selectedDateProvider;

  const DateRangePicker({
    super.key,
    required this.dateTypeProvider,
    required this.selectedDateProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _DailyChip(
          dateTypeProvider: dateTypeProvider,
          selectedDateProvider: selectedDateProvider,
        ),
        const SizedBox(width: 10),
        _PeriodChip(
          dateTypeProvider: dateTypeProvider,
          selectedDateProvider: selectedDateProvider,
        ),
      ],
    );
  }
}

class _DailyChip extends StatelessWidget {
  final StateProvider<DateType> dateTypeProvider;
  final StateProvider<SelectedDate> selectedDateProvider;

  const _DailyChip({
    super.key,
    required this.dateTypeProvider,
    required this.selectedDateProvider,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseChip(
      label: '하루',
      value: DateType.daily,
      dateTypeProvider: dateTypeProvider,
      selectedDateProvider: selectedDateProvider,
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final StateProvider<DateType> dateTypeProvider;
  final StateProvider<SelectedDate> selectedDateProvider;

  const _PeriodChip({
    super.key,
    required this.dateTypeProvider,
    required this.selectedDateProvider,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseChip(
      label: '기간',
      value: DateType.period,
      dateTypeProvider: dateTypeProvider,
      selectedDateProvider: selectedDateProvider,
    );
  }
}

class _BaseChip extends ConsumerWidget {
  final String label;
  final StateProvider<DateType> dateTypeProvider;
  final StateProvider<SelectedDate> selectedDateProvider;
  final DateType value;

  const _BaseChip({
    super.key,
    required this.label,
    required this.dateTypeProvider,
    required this.selectedDateProvider,
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
        ref
            .read(selectedDateProvider.notifier)
            .update((state) => state = state.deleteEndDate());
        break;
      case DateType.period:
        ref.read(selectedDateProvider.notifier).update((state) => state = state
            .copyWith(endDate: state.startDate.add(const Duration(days: 1))));
        break;
    }
  }
}
