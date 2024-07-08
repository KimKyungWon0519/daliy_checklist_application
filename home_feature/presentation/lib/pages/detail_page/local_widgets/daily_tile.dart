import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'task_item.dart';

class DailyTile extends StatelessWidget {
  final DateTime dateTime;
  final List<Task> tasks;

  const DailyTile({
    super.key,
    required this.dateTime,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTileTheme(
        data: ExpansionTileThemeData(
          shape: Border.all(color: Colors.transparent),
        ),
        child: ExpansionTile(
          title: Text(DateFormat('yyyy-MM-dd').format(dateTime)),
          children: tasks
              .map(
                (e) => TaskItem(task: e),
              )
              .toList(),
        ),
      ),
    );
  }
}
