import 'package:domain/domain.dart';
import 'package:domain/model/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateField extends ConsumerWidget {
  final StateProvider<DateType> dateTypeProvider;
  final StateProvider<Task> taskProvider;

  const DateField({
    super.key,
    required this.dateTypeProvider,
    required this.taskProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Task task = ref.watch(taskProvider);

    return TextField(
      controller: TextEditingController(text: _formatText(task.selectedDate)),
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
    final DateTime startDate = ref.read(taskProvider).selectedDate.startDate;

    showDatePicker(
      context: context,
      firstDate: DateTime(startDate.year - 100),
      lastDate: DateTime(startDate.year + 100),
      initialDate: startDate,
    ).then((value) {
      if (value == null) return;

      ref.read(taskProvider.notifier).update((state) {
        SelectedDate selectedDate = state.selectedDate;

        return state.copyWith(
            selectedDate: selectedDate.copyWith(startDate: value));
      });
    });
  }

  void _changePeriod(final WidgetRef ref, final BuildContext context) {
    final SelectedDate selectedDate = ref.read(taskProvider).selectedDate;

    showDateRangePicker(
      context: context,
      firstDate: DateTime(selectedDate.startDate.year - 100),
      lastDate: DateTime(selectedDate.endDate!.year + 100),
      initialDateRange: DateTimeRange(
          start: selectedDate.startDate, end: selectedDate.endDate!),
    ).then((value) {
      if (value == null) return;

      ref.read(taskProvider.notifier).update((state) {
        return state.copyWith(
            selectedDate: SelectedDate(
          startDate: value.start,
          endDate: value.end,
        ));
      });
    });
  }
}
