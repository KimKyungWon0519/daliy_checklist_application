import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/pages/add_task_page/local_widgets/default_panel.dart';

import 'date_field.dart';
import 'date_range_type_chips.dart';
import 'goal_field.dart';

class InputPanel extends ConsumerStatefulWidget {
  final StateProvider<Task> taskProvider;
  final StateProvider<DateType> dateTypeProvider;

  const InputPanel({
    super.key,
    required this.taskProvider,
    required this.dateTypeProvider,
  });

  @override
  ConsumerState<InputPanel> createState() => _InputPanelState();
}

class _InputPanelState extends ConsumerState<InputPanel> {
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPanel(
      children: [
        Form(
          key: _formKey,
          child: GoalField(
            onChanged: (value) {
              ref
                  .read(widget.taskProvider.notifier)
                  .update((state) => state.copyWith(goal: value));
            },
          ),
        ),
        const Divider(),
        DateRangePicker(
          dateTypeProvider: widget.dateTypeProvider,
          taskProvider: widget.taskProvider,
        ),
        DateField(
          dateTypeProvider: widget.dateTypeProvider,
          taskProvider: widget.taskProvider,
        ),
      ],
    );
  }
}
