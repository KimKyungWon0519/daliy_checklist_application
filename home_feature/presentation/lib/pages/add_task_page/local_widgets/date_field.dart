import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateField extends ConsumerWidget {
  final StateProvider<DateType> dateTypeProvider;
  final StateProvider<SelectedDate> selectedDateProvider;

  const DateField({
    super.key,
    required this.dateTypeProvider,
    required this.selectedDateProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SelectedDate selectedDate = ref.watch(selectedDateProvider);

    return TextField(
      controller: TextEditingController(text: _formatText(selectedDate)),
      decoration: const InputDecoration(
        labelText: '날짜',
        icon: Icon(Icons.calendar_month),
        contentPadding: EdgeInsets.all(8),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      readOnly: true,
      onTap: () {
        _onClickEvent(ref, context);
      },
    );
  }

  String _formatText(final SelectedDate selectedDate) {
    final DateFormat dateFormat = DateFormat('yyyy/MM/dd');

    final String startDate = dateFormat.format(selectedDate.startDate);

    if (selectedDate.endDate != null) {
      final String endDate = dateFormat.format(selectedDate.endDate!);

      return '$startDate ~ $endDate';
    }

    return startDate;
  }

  void _onClickEvent(final WidgetRef ref, final BuildContext context) {
    final DateType dateType = ref.read(dateTypeProvider);

    switch (dateType) {
      case DateType.daily:
        _changeDaily(ref, context);
        break;
      case DateType.period:
        _changePeriod(ref, context);
        break;
    }
  }

  void _changeDaily(final WidgetRef ref, final BuildContext context) {
    final DateTime startDate = ref.read(selectedDateProvider).startDate;

    showDatePicker(
      context: context,
      firstDate: DateTime(startDate.year - 100),
      lastDate: DateTime(startDate.year + 100),
      initialDate: startDate,
    ).then((value) {
      if (value == null) return;

      ref
          .read(selectedDateProvider.notifier)
          .update((state) => state = state.copyWith(startDate: value));
    });
  }

  void _changePeriod(final WidgetRef ref, final BuildContext context) {
    final SelectedDate selectedDate = ref.read(selectedDateProvider);

    showDateRangePicker(
      context: context,
      firstDate: DateTime(selectedDate.startDate.year - 100),
      lastDate: DateTime(selectedDate.endDate!.year + 100),
      initialDateRange: DateTimeRange(
          start: selectedDate.startDate, end: selectedDate.endDate!),
    ).then((value) {
      if (value == null) return;

      ref.read(selectedDateProvider.notifier).update((state) =>
          state = state.copyWith(startDate: value.start, endDate: value.end));
    });
  }
}
