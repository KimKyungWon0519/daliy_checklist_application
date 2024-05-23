import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskPanelBody extends ConsumerWidget {
  final StateProvider<List<Task>> tasksProvider;

  const TaskPanelBody({
    super.key,
    required this.tasksProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> tasks = ref.watch(tasksProvider);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final Task task = tasks[index];

          return CheckboxListTile(
            title: Text(task.goal),
            value: false,
            onChanged: (value) {},
          );
        },
        childCount: tasks.length,
      ),
    );
  }
}
