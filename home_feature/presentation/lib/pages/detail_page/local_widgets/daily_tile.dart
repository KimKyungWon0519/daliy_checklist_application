import 'dart:math';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'task_item.dart';

class DailyTile extends StatelessWidget {
  final DateTime dateTime;

  const DailyTile({
    super.key,
    required this.dateTime,
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
          children: List.generate(
            Random().nextInt(20),
            (index) => TaskItem(
              task: Task(
                  goal: 'task $index',
                  selectedDate: SelectedDate(startDate: DateTime.now()),
                  colorCode: Random().nextInt(0x00FFFFFF) + 0xFF000000),
            ),
          ),
        ),
      ),
    );
  }
}
