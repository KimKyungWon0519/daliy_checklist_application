import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/pages/add_task_page/local_widgets/default_panel.dart';

import 'date_field.dart';
import 'date_range_type_chips.dart';
import 'goal_field.dart';

class InputPanel extends ConsumerWidget {
  final StateProvider<Task> taskProvider;
  final StateProvider<DateType> dateTypeProvider;

  const InputPanel({
    super.key,
    required this.taskProvider,
    required this.dateTypeProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultPanel(
      children: [
        GoalField(
          onChanged: (value) {
            ref
                .read(taskProvider.notifier)
                .update((state) => state.copyWith(goal: value));
          },
        ),
        const Divider(),
        DateRangePicker(
          dateTypeProvider: dateTypeProvider,
          taskProvider: taskProvider,
        ),
        DateField(
          dateTypeProvider: dateTypeProvider,
          taskProvider: taskProvider,
        ),
      ],
    );
  }
}
