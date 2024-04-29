import 'package:flutter/material.dart';
import 'package:presentation/pages/add_task_page/local_widgets/date_field.dart';
import 'package:presentation/pages/add_task_page/local_widgets/date_range_type_chips.dart';

import 'local_widgets/add_button.dart';
import 'local_widgets/goal_field.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새로운 목표'),
        actions: const [
          AddButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.secondaryContainer),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GoalField(),
              Divider(),
              DateRangePicker(),
              DateField(),
            ],
          ),
        ),
      ),
    );
  }
}
