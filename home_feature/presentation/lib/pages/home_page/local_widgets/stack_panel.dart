import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/constants/ui_constants.dart';

import 'custom_calendar.dart';
import 'task_sheet.dart';

class StackPanel extends StatelessWidget {
  final StateProvider<DateTime> selectedDateProvider;
  final StateProvider<List<Task>> allTasksProvider;
  final StateProvider<List<Task>> selectedDateTasksProvider;
  final void Function(DateTime dateTime)? onPressedDay;
  final VoidCallback? onPressedAddButton;
  final void Function(Task task, bool value)? onChangedCompleted;

  const StackPanel({
    super.key,
    required this.selectedDateProvider,
    required this.allTasksProvider,
    required this.selectedDateTasksProvider,
    this.onPressedDay,
    this.onPressedAddButton,
    this.onChangedCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: bodyPadding,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height / 1.5,
            child: CustomCalendar(
              selectedDateProvider: selectedDateProvider,
              allTasksProvider: allTasksProvider,
              onPressedDay: (selectedDateTime) =>
                  onPressedDay?.call(selectedDateTime),
            ),
          ),
        ),
        SizedBox.expand(
          child: TaskSheet(
            selectedDateProvider: selectedDateProvider,
            tasksProvider: selectedDateTasksProvider,
            onPressedAddButton: onPressedAddButton,
            onChangedCompleted: onChangedCompleted,
          ),
        ),
      ],
    );
  }
}
