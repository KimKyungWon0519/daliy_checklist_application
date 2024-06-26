import 'package:calendar_domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskPanelBody extends ConsumerWidget {
  final StateProvider<List<Task>> tasksProvider;
  final void Function(Task task, bool value)? onChangedCompleted;
  final void Function(Task task)? onPressedTaskTile;

  const TaskPanelBody({
    super.key,
    required this.tasksProvider,
    this.onChangedCompleted,
    this.onPressedTaskTile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> tasks = ref.watch(tasksProvider);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final Task task = tasks[index];

          Color? color;
          TextDecoration? decoration;

          if (task.isCompleted) {
            color = Colors.grey;
            decoration = TextDecoration.lineThrough;
          }

          return ListTile(
            title: Text(
              task.goal,
              style: TextStyle(
                color: color,
                decoration: decoration,
              ),
            ),
            onTap: () => onPressedTaskTile?.call(task),
            trailing: Checkbox(
              onChanged: (value) {
                if (value == null) return;

                onChangedCompleted?.call(task, value);
              },
              value: task.isCompleted,
            ),
          );

          return CheckboxListTile(
            title: Text(
              task.goal,
              style: TextStyle(
                color: color,
                decoration: decoration,
              ),
            ),
            value: task.isCompleted,
            onChanged: (value) {
              if (value == null) return;

              onChangedCompleted?.call(task, value);
            },
          );
        },
        childCount: tasks.length,
      ),
    );
  }
}
