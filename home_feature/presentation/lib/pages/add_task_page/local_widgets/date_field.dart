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
      controller: TextEditingController(
        text: DateFormat('yyyy/MM/dd').format(selectedDate.startDate),
      ),
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
    showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2300),
      initialDate: ref.read(selectedDateProvider).startDate,
    );
  }

  void _changePeriod(final WidgetRef ref, final BuildContext context) {
    showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2300),
    );
  }
}
