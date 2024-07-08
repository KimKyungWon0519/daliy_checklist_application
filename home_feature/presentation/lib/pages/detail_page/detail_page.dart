import 'dart:collection';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/constants/app_constants.dart';
import 'package:presentation/pages/detail_page/local_widgets/daily_tile.dart';
import 'package:presentation/presenter/viewmodels/detail_viewmodel.dart';

class DetailPage extends ConsumerStatefulWidget {
  final TasksType type;
  final List<Task> tasks;

  const DetailPage({
    super.key,
    required this.type,
    required this.tasks,
  });

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  late final DetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = viewModelProvider<DetailViewModel>();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref
            .read(_viewModel.tasksProvider.notifier)
            .update((state) => widget.tasks);
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = ref.watch(_viewModel.tasksProvider);
    final SplayTreeMap<DateTime, List<Task>> tasksWithinDateTimeMap =
        getTaskMap(tasks);

    return Scaffold(
      appBar: AppBar(title: Text(widget.type.name)),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) {
            DateTime dateTime =
                tasksWithinDateTimeMap.entries.elementAt(index).key;
            List<Task> tasks =
                tasksWithinDateTimeMap.entries.elementAt(index).value;

            return DailyTile(
              dateTime: dateTime,
              tasks: tasks,
            );
          },
          itemCount: tasksWithinDateTimeMap.keys.length,
        ),
      ),
    );
  }

  SplayTreeMap<DateTime, List<Task>> getTaskMap(List<Task> tasks) {
    SplayTreeMap<DateTime, List<Task>> map = SplayTreeMap();

    for (Task task in tasks) {
      if (map[task.selectedDate.startDate] == null) {
        map[task.selectedDate.startDate] = List.empty(growable: true);
      }

      map[task.selectedDate.startDate]?.add(task);
    }

    return map;
  }
}
