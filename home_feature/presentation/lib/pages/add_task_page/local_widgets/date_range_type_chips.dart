import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateRangePicker extends StatelessWidget {
  final StateProvider<DateType> dateTypeProvider;

  const DateRangePicker({
    super.key,
    required this.dateTypeProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _DailyChip(
          dateTypeProvider: dateTypeProvider,
        ),
        const SizedBox(width: 10),
        _PeriodChip(
          dateTypeProvider: dateTypeProvider,
        ),
      ],
    );
  }
}

class _DailyChip extends StatelessWidget {
  final StateProvider<DateType> dateTypeProvider;

  const _DailyChip({
    super.key,
    required this.dateTypeProvider,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseChip(
      label: '하루',
      value: DateType.daily,
      dateTypeProvider: dateTypeProvider,
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final StateProvider<DateType> dateTypeProvider;

  const _PeriodChip({
    super.key,
    required this.dateTypeProvider,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseChip(
      label: '기간',
      value: DateType.period,
      dateTypeProvider: dateTypeProvider,
    );
  }
}

class _BaseChip extends ConsumerWidget {
  final String label;
  final StateProvider<DateType> dateTypeProvider;
  final DateType value;

  const _BaseChip({
    super.key,
    required this.label,
    required this.dateTypeProvider,
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
  }
}
