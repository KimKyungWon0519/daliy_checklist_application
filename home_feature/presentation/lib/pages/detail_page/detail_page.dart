import 'dart:collection';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/pages/detail_page/local_widgets/daily_tile.dart';

class DetailPage extends ConsumerStatefulWidget {
  final String title;
  final List<Task> tasks;

  const DetailPage({
    super.key,
    required this.title,
    required this.tasks,
  });

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) {
            DateTime dateTime = getTaskMap().entries.elementAt(index).key;
            List<Task> tasks = getTaskMap().entries.elementAt(index).value;

            return DailyTile(
              dateTime: dateTime,
              tasks: tasks,
            );
          },
          itemCount: getTaskMap().keys.length,
        ),
      ),
    );
  }

  SplayTreeMap<DateTime, List<Task>> getTaskMap() {
    SplayTreeMap<DateTime, List<Task>> map = SplayTreeMap();

    for (Task task in widget.tasks) {
      if (map[task.selectedDate.startDate] == null) {
        map[task.selectedDate.startDate] = List.empty(growable: true);
      }

      map[task.selectedDate.startDate]?.add(task);
    }

    return map;
  }
}
