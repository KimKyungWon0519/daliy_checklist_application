import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/constants/ui_constants.dart';

import 'custom_calendar.dart';
import 'task_sheet.dart';

class RowPanel extends StatelessWidget {
  final StateProvider<DateTime> selectedDateProvider;
  final StateProvider<List<Task>> allTaskProvider;
  final StateProvider<List<Task>> selectedDateTasksProvider;
  final void Function(DateTime dateTime)? onPressedDay;
  final VoidCallback? onPressedAddButton;

  const RowPanel({
    super.key,
    required this.selectedDateProvider,
    required this.allTaskProvider,
    required this.selectedDateTasksProvider,
    this.onPressedDay,
    this.onPressedAddButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: bodyPadding,
            child: CustomCalendar(
              selectedDateProvider: selectedDateProvider,
              allTasksProvider: allTaskProvider,
              onPressedDay: (selectedDateTime) =>
                  onPressedDay?.call(selectedDateTime),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            padding: const EdgeInsets.all(8),
            child: TaskPanel(
              selectedDateProvider: selectedDateProvider,
              tasksProvider: selectedDateTasksProvider,
              onPressedAddButton: onPressedAddButton,
            ),
          ),
        ),
      ],
    );
  }
}
