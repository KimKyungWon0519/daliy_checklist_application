import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'date_field.dart';
import 'date_range_type_chips.dart';
import 'default_panel.dart';
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
    Task task = ref.watch(taskProvider);

    return DefaultPanel(
      children: [
        GoalField(
          initialValue: task.goal,
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
