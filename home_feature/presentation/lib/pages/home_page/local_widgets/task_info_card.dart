import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class TaskInfoCard extends StatelessWidget {
  final TasksType type;
  final String? date;
  final List<Task> tasks;
  final void Function(TasksType type, List<Task> task)? pageNavigator;

  const TaskInfoCard({
    super.key,
    required this.type,
    this.date,
    required this.tasks,
    this.pageNavigator,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pageNavigator?.call(type, tasks);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (date != null) Text(date!),
                ],
              ),
              const Spacer(),
              Text(
                '${tasks.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
